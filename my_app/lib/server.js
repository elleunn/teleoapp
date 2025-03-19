const express = require("express");
const cors = require("cors");
const admin = require("firebase-admin");
const dotenv = require("dotenv");
const path = require("path");

dotenv.config();

const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();
const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// 🔑 Verify Firebase Token and Store User in Firestore
app.post("/authenticate", async (req, res) => {
  const { token } = req.body;

  if (!token) {
    return res.status(400).json({ error: "Missing token" });
  }

  try {
    // 🔍 Verify Firebase ID token
    const decodedToken = await admin.auth().verifyIdToken(token);
    const { uid, email, name, picture } = decodedToken;

    // 🔍 Check if user exists in Firestore
    const userRef = db.collection("users").doc(uid);
    const userDoc = await userRef.get();

    if (!userDoc.exists) {
      // 📌 Save new user in Firestore
      await userRef.set({
        uid,
        email,
        name: name || "",
        picture: picture || "",
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    res.json({ message: "Authentication successful", user: { uid, email, name, picture } });
  } catch (error) {
    console.error("Authentication failed:", error);
    res.status(401).json({ error: "Invalid token" });
  }
});

// 🚀 Test Route
app.get("/", (req, res) => {
  res.send("Flutter Firebase Authentication Backend is Working!");
});

// 🎯 Start Server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
