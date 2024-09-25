import dotenv from 'dotenv';
import jwt from 'jsonwebtoken';

dotenv.config();
function authenticationToken(req, res, next) {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(' ')[1];

  if (token == null) return res.sendStatus(401);
  jwt.verify(token, process.env.ACCESS_TOKEN, (err, response) => {
    if (err) return res.sendStatus(403);
    res.locals = response;
    next();
  });
}

export default { authenticationToken: authenticationToken };