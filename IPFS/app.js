const fs = require("fs");
const ipfsAPI = require("ipfs-api");

// Create an IPFS instance
const ipfs = ipfsAPI({ host: "localhost", port: "5001", protocol: "http" });

async function uploadImageToIPFS(imagePath) {
  try {
    // Read the image file
    const imageBuffer = fs.readFileSync(imagePath);

    // Upload the image to IPFS
    const result = await ipfs.files.add({
      content: imageBuffer,
      path: "image.jpg",
    });

    // Log the IPFS hash (CID) of the uploaded image
    console.log("Image uploaded to IPFS. CID:", result[0].hash);
  } catch (error) {
    console.error("Error uploading image to IPFS:", error.message);
  }
}

// Specify the path to your image file
const imagePath = "wallpaper.jpg";

// Call the function to upload the image to IPFS
uploadImageToIPFS(imagePath);
