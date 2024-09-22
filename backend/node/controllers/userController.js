// controllers/userController.js
const connection = require("../connection");
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");

require("dotenv").config();

var transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL,
    pass: process.env.PASSWORD,
  },
});

exports.signup = (req, res) => {
  let user = req.body;
  const query = "select email, password, role from user where email = ?";
  connection.query(query, [user.email], (err, result) => {
    if (!err) {
      if (result.length <= 0) {
        const insertQuery = "insert into user(name, contactNumber, email, password, role) values(?,?,?,?,?);";
        connection.query(insertQuery, [user.name, user.contactNumber, user.email, user.password, user.role], (err, result) => {
          if (!err) {
            res.status(200).json({ message: "Successfully Registered" });
          } else {
            return res.status(500).json(err);
          }
        });
      } else {
        return res.status(400).json({ message: "Email already exists." });
      }
    } else {
      return res.status(500).json(err);
    }
  });
};

exports.login = (req, res) => {
  const user = req.body;
  const query = "select email, password, role from user where email = ?";
  connection.query(query, [user.email], (err, results) => {
    if (!err) {
      if (results.length <= 0 || results[0].password !== user.password) {
        return res.status(401).json({ message: "Incorrect Username or password" });
      } else if (results[0].password === user.password) {
        const response = { email: results[0].email, role: results[0].role };
        const accessToken = jwt.sign(response, process.env.ACCESS_TOKEN, {
          expiresIn: "8h",
        });
        res.status(200).json({ accessToken: accessToken });
      } else {
        return res.status(400).json({ message: "Something went wrong, please try again later." });
      }
    } else {
      return res.status(500).json(err);
    }
  });
};

exports.forgotPassword = (req, res) => {
  const user = req.body;
  const query = "select email, password from user where email = ?";
  connection.query(query, [user.email], (err, results) => {
    if (!err) {
      if (results.length <= 0) {
        return res.status(200).json({ message: "Password sent successfully to your email." });
      } else {
        var mailOptions = {
          from: process.env.EMAIL,
          to: results[0].email,
          subject: "Password by Ecommerce Companies",
          html: "<p>Your login details for Our Ecommerce system:</p><p><b>Email:</b> " + results[0].email +
            "<br><b>Password:</b> " + results[0].password +
            '<br><a href="http://localhost:4200">Click here to Login</a></p>',
        };

        transporter.sendMail(mailOptions, function (error, info) {
          if (error) {
            console.log(error);
          } else {
            console.log("Email sent: " + info.response);
          }
        });
        return res.status(200).json({ message: "Password sent successfully to your email." });
      }
    } else {
      return res.status(500).json(err);
    }
  });
};

exports.getUsers = (req, res) => {
  const query = "select id, name, email, contactNumber, role from user where role='client'";
  connection.query(query, (err, results) => {
    if (!err) {
      return res.status(200).json(results);
    } else {
      return res.status(500).json(err);
    }
  });
};

exports.updateUser = (req, res) => {
  let user = req.body;
  const query = "update user set status=? where id=?";
  connection.query(query, [user.status, user.id], (err, results) => {
    if (!err) {
      if (results.affectedRows === 0) {
        return res.status(404).json({ message: "User ID does not exist" });
      }
      return res.status(200).json({ message: "User Updated Successfully" });
    } else {
      return res.status(500).json(err);
    }
  });
};

exports.checkToken = (req, res) => {
  return res.status(200).json({ message: "true" });
};

exports.changePassword = (req, res) => {
  const user = req.body;
  const email = res.locals.email;
  const query = "select * from user where email = ? and password = ?";
  connection.query(query, [email, user.oldPassword], (err, results) => {
    if (!err) {
      if (results.length <= 0) {
        return res.status(400).json({ message: "Incorrect old password" });
      } else if (results[0].password === user.oldPassword) {
        const updateQuery = "update user set password = ? where email = ?";
        connection.query(updateQuery, [user.newPassword, email], (err, results) => {
          if (!err) {
            return res.status(200).json({ message: "Password Updated Successfully." });
          } else {
            return res.status(500).json(err);
          }
        });
      } else {
        return res.status(400).json({ message: "Something went wrong, try again later." });
      }
    } else {
      return res.status(500).json(err);
    }
  });
};
