const http = require("http");
const url = require("url");

function cpuHeavyWork(n) {
  let sum = 0;
  for (let i = 0; i < n; i++) {
    sum += Math.sqrt(i) * Math.sin(i);
  }
  return sum;
}

const server = http.createServer((req, res) => {
  const q = url.parse(req.url, true);
  
  if (q.pathname === "/heavy") {
    const n = parseInt(q.query.n) || 50_000_000;
    const start = Date.now();
    const result = cpuHeavyWork(n);
    const elapsed = (Date.now() - start) / 1000;

    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ iterations: n, result, elapsed_seconds: elapsed }));
  }

  else if (q.pathname === "/slow") {
    const dur = parseFloat(q.query.dur) || 5;
    setTimeout(() => {
      res.writeHead(200, { "Content-Type": "text/plain" });
      res.end(`Réponse après ${dur} secondes`);
    }, dur * 1000);
  }

  else {
    res.writeHead(404, { "Content-Type": "text/plain" });
    res.end("Not found");
  }
});

server.listen(3000, () => {
  console.log("Serveur Node.js en écoute sur http://localhost:3000");
});

