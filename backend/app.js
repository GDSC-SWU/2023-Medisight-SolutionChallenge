const express = require("express");
const app = express();
app.use(express.json());

// env
const dotenv = require("dotenv");
dotenv.config();

const database = require("./util/Database");

const Search = require("./routes/Search");

app.use("/search", Search);

const PORT = 5001;
app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});
