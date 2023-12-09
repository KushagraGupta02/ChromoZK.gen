const express = require('express');
const { exec } = require('child_process');
const path = require('path');

const app = express();
const port = 3003;

app.use(express.static('public'));

app.post('/execute', (req, res) => {
  // Specify the path to your npm project folder
  const npmProjectPath = '../GeneticDataSharing/contract/contracts';

  // Change to the npm project folder
  process.chdir(npmProjectPath);

  // Execute the desired npm command (e.g., start)
  exec('forge create contracts/Geneticdatasharing.sol:GeneticDataSharing --constructor-args 0 --rpc-url https://sepolia-rpc.scroll.io --verify --private-key 7aa9382df0475e42859cff4b752dde4a71dcc7d6111ac813c13e1ba74d430fca', (error, stdout, stderr) => {
    if (error) {
      console.error(`Error executing npm command: ${error.message}`);
      return res.status(500).send(`Error executing npm command: ${error.message}`);
    }
    console.log(`npm command script output: ${stdout}`);
    res.status(200).send('Execution initiated');
  });
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
