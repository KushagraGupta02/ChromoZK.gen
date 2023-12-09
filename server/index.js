const express = require('express');
const { exec } = require('child_process');
const path = require('path');

const app = express();
const port = 3001;

app.use(express.static('public'));

app.post('/execute', (req, res) => {
  // Specify the path to your npm project folder
  const npmProjectPath = '../';

  // Change to the npm project folder
  process.chdir(npmProjectPath);

  // Execute the desired npm command (e.g., start)
  exec('a.out', (error, stdout, stderr) => {
    if (error) {
      console.error(`Error executing npm command: ${error.message}`);
      return res.status(500).send(`Error executing npm command: ${error.message}`);
    }
    console.log(`npm command output: ${stdout}`);
    res.status(200).send('Execution initiated');
  });
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
