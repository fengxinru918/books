const express = require("express");
const app = express();
const conn = require("./js/conn");
const { encrypt, decrypt } = require("./js/encrypt.js");
const { nanoid } = require("nanoid");
const cors = require("cors");
const bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: false }));
const admin = require("./order/admin.js");
const reader = require("./order/reader.js");
const multer = require("multer");
const path = require('path');
app.use(express.urlencoded({ extended: true }));
app.use(admin);
app.use(reader);
app.use(express.json()); // 用于解析 JSON 格式的请求体
app.use(express.urlencoded({ extended: false }));

// 配置 CORS
app.use(cors({
  origin: "http://localhost:3000", // 允许前端的域名和端口
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
  allowedHeaders: ["Content-Type", "Authorization"],
}));

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/"); // 上传文件的存储目录
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname); // 上传文件的文件名
  },
});

const upload = multer({ storage: storage });
// 图片上传接口
app.post("/upload", upload.single("file"), (req, res) => {
  console.log("图片上传接口:", req.file);
  if (!req.file) {
    return res.status(400).json({
      msg: "文件上传失败，请重试",
      status: 0,
    });
  }
  res.status(200).json({
    status: 200,
    msg: "文件上传成功",
    url: `http://localhost:8980/uploads/${req.file.filename}`,
  });
});

// 添加书籍接口
app.post('/adminaddbooks', (req, res) => {
  const data = req.body;
  // 检查 position 是否已存在
  conn.query(`SELECT * FROM book WHERE position = ?`, [data.position], (err, rs) => {
    if (err) {
      return res.send({
        msg: '查询失败',
        status: 0,
      });
    }
    if (rs.length > 0) {
      return res.send({
        msg: '该位置已有书籍存放！',
        status: 0,
      });
    } else {
      // 插入新书籍
      conn.query(
          `INSERT INTO book (bookId, bookName, author, amount, position, totalAmount, borrowedTimes, status, bookImage, bookDescription) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
          [
            nanoid(), // 生成唯一 ID
            data.bookName,
            data.author,
            data.amount,
            data.position,
            data.totalAmount || data.amount, // 如果未传递 totalAmount，默认值为 amount
            data.borrowedTimes || 0, // 如果未传递 borrowedTimes，默认值为 0
            data.status || 1, // 如果未传递 status，默认值为 1
            data.bookImage,
            data.bookDescription || '', // 如果未传递 bookDescription，默认值为空字符串
          ],
          (err, result) => {
            if (err) {
              console.error('数据库插入错误:', err); // 打印错误信息
              return res.send({
                msg: '添加书籍失败',
                status: 0,
              });
            }
            res.send({
              msg: '添加书籍成功！',
              status: 200,
            });
          }
      );
    }
  });
});
// 登录接口
app.post("/login", (req, res) => {
  let data = req.body;
  // 判断接收数据是否为空
  if (!data) {
    res.json({
      msg: "没有提交数据！",
      status: 0,
    });
    return;
  }
  // 管理员登录
  if (data.isAdmin === true) {
    // 打印查询条件
    console.log("查询条件：", { phone: data.phone, password: data.password });
    conn.query(
        `SELECT * FROM admin WHERE phone = ? AND password = ?`,
        [data.phone, data.password],
        (err, rs) => {
          if (err) throw err;
          console.log("管理员信息：", rs);
          if (rs.length > 0) {
            res.json({
              msg: "管理员登录成功",
              status: 200,
              data:rs,
              isAdmin: true,
            });
          } else {
            res.json({
              msg: "管理员账号或密码错误！",
              status: 0,
            });
          }
        }
    );
  }
  if (data.isAdmin === false) {
    // 电话号码格式验证
    const regexp = /^(\+\d{2,3}-)?\d{11}$/;
    if (!regexp.test(data.phone)) {
      res.json({
        msg: "请输入正确的手机号",
        status: 0,
      });
      return false;
    }
    // 加密密码
    let userLoginPwd = encrypt(data.password);
    // 检测是否已有账号以及密码的验证
    conn.query(
      `select readerId,readerName,phone,borrowTimes,ovdTimes from reader where phone='${data.phone}' and password='${userLoginPwd}'`,
      (err, rs) => {
        if (err) throw err;
        if (rs.length > 0) {
          res.json({
            msg: "学生登录成功",
            status: 200,
            readerId: rs[0].readerId,
            readerName: rs[0].readerName,
            readerPhone: rs[0].phone,
            borrowTimes: rs[0].borrowTimes,
            ovdTimes: rs[0].ovdTimes,
            isAdmin: false,
          });
        } else {
          res.json({
            msg: "账号密码错误或该用户未注册！",
            status: 0,
          });
        }
      }
    );
  }
});
// 图书接口
app.post("/books", (req, res) => {
  conn.query(`select * from book order by borrowedTimes desc`, (err, rs) => {
    let data = rs || [];
    if (data.length > 0) {
      res.json({
        msg: "书籍请求成功",
        status: 200,
        data: rs,
      });
      // console.log("书籍请求：",rs)
    } else {
      res.json({
        msg: "书籍请求数据为空",
        status: 0,
      });
    }
  });
});
// 评论接口
app.post("/comments", (req, res) => {
  conn.query(
    `select reader.email,comment.status,comment.commentId,
    comment.readerId,comment.bookId,readerName,bookName,date,content,praise from comment 
    left join reader on comment.readerId=reader.readerId left join book on comment.bookId=book.bookId`,
    (err, rs) => {
      let data = rs || [];
      console.log("评论区：",rs)
      if (data.length > 0) {
        res.json({
          msg: "评论区请求成功",
          status: 200,
          data: rs,
        });
      } else {
        res.json({
          msg: "评论区请求数据为空！",
          status: 0,
        });
      }
    }
  );
});
// 添加评论
app.post("/addcomment", (req, res) => {
  let data = req.body;
  console.log("添加评论",data);
  let commentId = nanoid();
  conn.query(
    `insert into comment values('${commentId}','${data.readerId}','${data.bookId}',sysdate(),'${data.content}',0,1)`
  );
  res.send({
    msg: "评论成功！",
    status: 200,
  });
});
// 添加点赞
app.post("/addpraise", (req, res) => {
  let data = req.body;
  console.log("添加点赞", data);
  // 通过 commentId 更新 praise 字段
  conn.query(
      `UPDATE comment SET praise = praise + 1 WHERE commentId = '${data.commentId}'`,
      (err, results) => {
        if (err) {
          console.error("更新点赞数失败：", err);
          return res.send({
            msg: "点赞失败，请稍后重试！",
            status: 500,
          });
        }
        // 检查是否有受影响的行
        if (results.affectedRows === 0) {
          return res.send({
            msg: "点赞失败，评论不存在！",
            status: 404,
          });
        }
        // 返回成功响应
        res.send({
          msg: "点赞成功！",
          status: 200,
        });
      }
  );
});
// 书籍查询接口
app.post("/searchbook", (req, res) => {
  let data = req.body;
  // console.log(data.name)
  conn.query(
    `select * from book where bookName like '%${data.name}%'`,
    (err, book) => {
      book = book || [];
      conn.query(
        `select * from book where author like '%${data.name}%'`,
        (err, author) => {
          const data = [...new Set(book.concat(author))];
          if (data.length > 0)
            res.json({
              msg: "查询成功！",
              data: data,
              status: 200,
            });
          else
            res.json({
              msg: "查询结果为空！",
              status: 0,
            });
        }
      );
    }
  );
});

// 获取评论最多的人员
app.post("/amountmax", (req, res) => {
  conn.query(
    `select count(*) as amount,readerName from reader left join comment on reader.readerId=comment.readerId GROUP BY reader.readerId ORDER BY amount desc limit 1`,
    (err, rs) => {
      rs = rs || [];
      res.send({
        status: 200,
        msg: "请求成功！",
        data: rs,
      });
    }
  );
});
// 获取评论数量
app.post("/amount", (req, res) => {
  conn.query(`select count(*) as mytotal from comment`, (err, rs) => {
    rs = rs || [];
    res.send({
      status: 200,
      msg: "请求成功！",
      data: rs,
    });
  });
});

// 配置静态文件服务
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
// 端口监听
app.listen(8981, (err) => {
  if (!err) console.log("服务器启动成功!");
});
