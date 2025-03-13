const express = require("express");
const router = express.Router();
const conn = require("../js/conn");
const { nanoid } = require("nanoid");
const { encrypt, decrypt } = require("../js/encrypt.js");
var bodyParser = require("body-parser");
router.use(bodyParser.urlencoded({ extended: false }));

// 重新获取学生信息
router.post("/initreader", (req, res) => {
  let data = req.body;
  conn.query(
    `select email,readerId,readerName,phone,borrowTimes,ovdTimes,avatar, 
        gender  from reader where readerId='${data.readerId}'`,
    (err, rs) => {
      if (err) throw err;
      console.log("重新获取学生信息：", rs);
      if (rs.length > 0) {
        res.json({
          msg: "学生获取信息成功！",
          status: 200,
          readerId: rs[0].readerId,
          readerName: rs[0].readerName,
          readerPhone: rs[0].phone,
          borrowTimes: rs[0].borrowTimes,
          ovdTimes: rs[0].ovdTimes,
          email: rs[0].email,
          avatar:rs[0].avatar ||'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png',
          gender:rs[0].gender || '男',
          isAdmin: false,
        });
      } else {
        res.json({
          msg: "学生获取信息失败！",
          status: 0,
        });
      }
    }
  );
});

// 重新获取管理员信息
router.get("/initadmin", (req, res) => {
  conn.query(
      `SELECT adminName, phone, avatar, gender FROM admin`, // 查询所有管理员信息
      (err, rs) => {
        if (err) throw err;
        console.log("重新获取管理员信息：", rs);
        if (rs.length > 0) {
          // 如果有管理员信息，返回成功响应
          res.json({
            msg: "获取管理员信息成功！",
            status: 200,
            data: rs, // 返回查询到的管理员信息
            isAdmin: true,
          });
        } else {
          // 如果没有管理员信息，返回失败响应
          res.json({
            msg: "暂无管理员信息！",
            status: 0,
          });
        }
      }
  );
});


// router.post('/changeadmininfo', (req, res) => {
//   // 获取前端传来的数据
//   const { adminName, avatar, gender,phone } = req.body;
//
//   // 检查是否传入了必要的字段
//   if (!adminName || !avatar || !gender||!phone ) {
//     return res.send({
//       status: 400,
//       msg: '缺少必要的字段，请确保传入 adminName, avatar, gender '
//     });
//   }
//
//   // 构造 SQL 更新语句
//   const sql = `
//         UPDATE admin
//         SET adminName = ?, avatar = ?, gender = ?
//         WHERE phone = ?
//     `;
//
//   // 执行 SQL 查询
//   conn.query(sql, [adminName, avatar, gender, phone], (err, results) => {
//     if (err) {
//       // 如果发生错误，返回错误信息
//       console.error('数据库更新失败:', err);
//       return res.send({
//         status: 500,
//         msg: '数据库更新失败，请稍后重试'
//       });
//     }
//
//     // 如果更新成功，返回成功信息
//     if (results.affectedRows > 0) {
//       res.send({
//         status: 200,
//         msg: '修改管理员信息成功！'
//       });
//     } else {
//       // 如果没有更新到任何行，返回失败信息
//       res.send({
//         status: 404,
//         msg: '未找到对应的管理员记录，修改失败'
//       });
//     }
//   });
// });




// 学生注册接口
router.post("/register", (req, res) => {
  let data = req.body;
  console.log("注册接收的数据", data);
  if (!data) {
    res.json({
      msg: "没有提交数据！",
      status: 0,
    });
    return false;
  }
  // 用户名非空校验
  if (!data.userName) {
    res.json({
      msg: "用户名不能为空",
      status: 0,
    });
    return false;
  }
  // 电话号码非空校验
  if (!data.phone) {
    res.json({
      msg: "手机号不能为空",
      status: 0,
    });
    return false;
  }
  // 邮箱非空校验
  if (!data.email) {
    res.json({
      msg: "邮箱不能为空",
      status: 0,
    });
    return false;
  }
  // 密码非空校验
  if (!data.password) {
    res.json({
      msg: "密码不能为空",
      status: 0,
    });
    return false;
  }
  // 随机用户ID
  let readerId = nanoid();
  // 加密密码
  let userRegisterPwd = encrypt(data.password);
  // 手机号格式验证
  const regexp = /^(\+\d{2,3}-)?\d{11}$/;
  if (!regexp.test(data.phone)) {
    res.json({
      msg: "手机号格式错误",
      status: 0,
    });
    return false;
  }
  conn.query(`select * from reader where phone='${data.phone}'`, (err, rs) => {
    if (err) throw err;
    // 注册前先校验该用户是否已经注册过
    if (rs.length > 0) {
      res.json({
        msg: "该手机号已经注册过！",
        status: 0,
      });
      console.log("注册：", rs);
    } else {
      // 修正后的 SQL 插入语句
      conn.query(
          `insert into reader values('${readerId}','${data.userName}','${userRegisterPwd}','${data.phone}',0,0,'${data.email}','','')`,
          (err, rs) => {
            if (err) throw err;
            res.json({
              msg: "注册成功",
              status: 200,
            });
          }
      );
    }
  });
});

// 学生请求预约记录接口
router.post("/reserve", (req, res) => {
  let readerId = req.body.readerId;
  const query = `SELECT reserve.readerId, reserve.bookId, reserve.status, reserve.date 
								 FROM reserve 
								 LEFT JOIN book ON reserve.bookId = book.bookId 
								 WHERE reserve.readerId = readerId`;

  conn.query(query, [readerId], (err, rs) => {
    if (err) {
      console.error("查询错误:", err);
      res.json({
        msg: "查询预约记录失败",
        status: 500,
      });
    } else {
      let data = rs || [];
      if (data.length === 0) {
        res.json({
          msg: "读者请求预订记录为空",
          status: 404,
        });
      } else {
        res.json({
          msg: "读者请求预订记录成功",
          status: 200,
          data: rs,
        });
      }
    }
  });
});

// 学生添加预约记录接口
router.post("/addreserve", (req, res) => {
  let data = req.body;
  console.log("学生添加预约记录");
  conn.query(`select * from book where bookId='${data.bookId}'`, (err, rs) => {
    if (err) throw err;
    rs = rs || [];
    if (rs.length > 0) {
      conn.query(`insert into reserve values('${data.readerId}',
				'${data.bookId}','${data.date}','${data.status}')`);
      res.json({
        msg: "预约成功！",
        status: 200,
      });
    } else {
      res.json({
        msg: "不好意思，该书当前库存不足！",
        status: 0,
      });
    }
  });
});

// 管理员删除预约记录接口
router.post("/cancelreserve", (req, res) => {
  let data = req.body;
  console.log("管理员删除预约记录接口", data);
  // 执行 SQL 查询
  conn.query(
      `DELETE FROM reserve WHERE readerId = ? AND bookId = ? AND date = ?`,
      [data.readerId, data.bookId, data.date],
      (err, results) => {
        if (err) {
          console.error("取消预约失败:", err);
          return res.status(500).send({
            msg: "取消预约失败",
            status: 500,
            error: err.message
          });
        }
        // 检查是否成功删除
        if (results.affectedRows === 0) {
          return res.status(404).send({
            msg: "预约记录不存在或已取消",
            status: 404
          });
        }
        // 删除成功
        res.json({
          msg: "取消预约成功！",
          status: 200
        });
      }
  );
});

// 学生续借接口
router.post("/continueborrow", (req, res) => {
  let data = req.body;
  console.log("学生续借接口:", data);
  //更新借阅表状态
  conn.query(`update borrow set status='已续借',borrowDate=now(),returnDate=date_add(NOW(), interval 1 month) 
	where readerId='${data.readerId}' and bookId = '${data.bookId}' and borrowDate = '${data.borrowDate}'`);
  //更新预约表状态
  conn.query(`update reserve set status = '已借阅',borrowDate=now(),returnDate=date_add(NOW(), interval 1 month)
  where readerId='${data.readerId}' and bookId = '${data.bookId}' and date='${data.date}'`)
  res.send({
    msg: "续借成功！",
    status: 200,
  });
});
// 学生请求借阅记录接口
router.post("/borrows", (req, res) => {
  let data = req.body;
  console.log("学生请求借阅记录接口", data);
  conn.query(
    `select readerId,borrow.bookId,borrow.status,book.author,bookName,borrowDate,returnDate,realDate from borrow left join book on borrow.bookId=book.bookId where borrow.readerId in (select readerId from reader where readerId = '${data.readerId}')`,
    (err, rs) => {
      let data = rs || [];
      if (data.length == 0)
        res.json({
          msg: "读者请求借阅记录为空",
          status: 0,
        });
      else
        res.json({
          msg: "读者请求借阅记录成功",
          status: 200,
          data: rs,
        });
    }
  );
});

// 学生借书接口
router.post("/addborrow", (req, res) => {
  let data = req.body;
  console.log("学生借书信息为：", data);
  // 向借书表中添加数据
  conn.query(
    `insert into borrow values('${data.readerId}','${data.bookId}',now(),date_add(NOW(), interval 1 month),'9999-12-31','未还')`
  );
  // 书籍表数量-1
  conn.query(
    `update book set amount = amount - 1 where bookId='${data.bookId}'`
  );
  // 书籍表借阅次数+1
  conn.query(
    `update book set borrowedTimes = borrowedTimes + 1 where bookId='${data.bookId}'`
  );
  // 用户借阅数量+1
  conn.query(
    `update reader set borrowTimes = borrowTimes + 1 where readerId='${data.readerId}'`
  );
  // 将预订表的借书时间改为当前时间
  // conn.query(`update reserve set borrowDate = now() where bookId='${data.bookId}' and readerId='${data.readerId}' and date='${data.date}'`)
  conn.query(
    `update reserve set status='已借阅' where bookId='${data.bookId}' and readerId='${data.readerId}' and date='${data.date}'`
  );
  res.json({
    msg: "添加借书记录成功！",
    status: 200,
  });
});

// 学生还书接口
router.post("/returnbook", (req, res) => {
  let data = req.body;
  console.log("学生还书：", data);
  // 书籍表数量加1
  conn.query(
      `update book set amount = amount + 1 where bookId='${data.bookId}'`,
      (err) => {
        if (err) {
          console.error("更新书籍数量失败：", err);
          res.json({
            msg: "还书失败，更新书籍数量时出错！",
            status: 0,
          });
          return;
        }
      }
  );
  // 重新设置真正的还书日期
  conn.query(
      `update borrow set status='已还',realDate = sysDate() where bookId='${data.bookId}' and readerId='${data.readerId}' and borrowDate='${data.borrowDate}'`,
      (err) => {
        if (err) {
          console.error("更新借阅记录失败：", err);
          res.json({
            msg: "还书失败，更新借阅记录时出错！",
            status: 0,
          });
          return;
        }
      }
  );

  // 时间戳比较
  conn.query(
      `select unix_timestamp(returnDate) as returnDate from borrow where bookId='${data.bookId}' and readerId='${data.readerId}' and borrowDate='${data.borrowDate}'`,
      (err, rs) => {
        if (err) {
          console.error("查询还书日期失败：", err);
          res.json({
            msg: "还书失败，查询还书日期时出错！",
            status: 0,
          });
          return;
        }

        if (rs.length > 0) {
          let realDate = new Date(data.date).getTime() / 1000;
          let returnDate = rs[0].returnDate;
          if (realDate > returnDate) {
            // 用户逾期记录+1
            conn.query(
                `update reader set ovdTimes = ovdTimes + 1 where readerId='${data.readerId}'`,
                (err) => {
                  if (err) {
                    console.error("更新逾期记录失败：", err);
                    res.json({
                      msg: "还书成功，但更新逾期记录时出错！",
                      status: 100,
                    });
                    return;
                  }
                  res.json({
                    msg: "还书成功，您已逾期！",
                    status: 100,
                  });
                }
            );
          } else {
            res.json({
              msg: "还书成功！",
              status: 200,
            });
          }
        } else {
          res.json({
            msg: "还书失败！",
            status: 0,
          });
        }
      }
  );
});
module.exports = router;
