const express = require("express");
const app = express();
app.use(express.json());

// env
const dotenv = require("dotenv");
dotenv.config();

const Search = require("./routes/Search");
const Map = require("./routes/Map");

app.use("/search", Search);
app.use("/map", Map);

const PORT = 5001;
app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});
