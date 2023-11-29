// server.js
const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();

// Set default middlewares (logger, static, cors)
server.use(middlewares);

// Add custom routes to fake the specified endpoints
server.use(jsonServer.bodyParser);

let status = 200;
let status200 = 200;
let status400 = 400;
let status401 = 401;
let status402 = 402;
let status403 = 403;
let status500 = 500;

// ================= API ENDPOINTS ====================
// Fake the "api/funix_portal/user/create_user" endpoint
server.post('/api/funix_portal/user/create_user', (req, res) => {
  // Return the request payload as the response
  res.status(status200).json(req.body);
});

// Fake the "api/funix_portal/user/update_password" endpoint
server.post('/api/funix_portal/user/update_password', (req, res) => {
  // Return the request payload as the response
  res.status(status).json(req.body);
});

// Fake the "api/bulk_enroll/v1/bulk_enroll" endpoint
server.post('/api/bulk_enroll/v1/bulk_enroll', (req, res) => {
  // Return the request payload as the response
  res.status(status).json(req.body);
});

// // Use the router for other endpoints defined in your "db.json" file
// server.use(router);

// Start the JSON server
const port = process.env.PORT || 3000;
server.listen(port, () => {
  console.log(`JSON Server is running on port ${port}`);
});
