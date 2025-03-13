const express = require('express')
const router = express.Router()
const conn = require('../js/conn')
const fs = require('fs');

var bodyParser = require('body-parser')
router.use(bodyParser.urlencoded({ extended: false }))
const nodemailer = require("nodemailer");
const { nanoid } = require('nanoid')
const userEmail = '*****@qq.com'
const userCode = '*****'
// 管理员获取借阅记录接口
router.post('/borrowslist', (req, res) => {
	let data = req.body;
	console.log("管理员获取借阅记录接口",data)
	conn.query(`select readerId,borrow.bookId,borrow.status,book.author,bookName,borrowDate,returnDate,realDate from borrow left join book on borrow.bookId=book.bookId where borrow.readerId in (select readerId from reader where readerId = '${data.readerId}')`, (err, rs) => {
		let data = rs || []
		if (data.length == 0)
			res.json({
				msg: '管理员请求借阅记录为空',
				status: 0,
				data: rs
			})
		else
			res.json({
				msg: '管理员请求借阅记录成功',
				status: 200,
				data: data
			})
	})
})
// 管理员获取预订记录接口
router.post('/reservelist', (req, res) => {
	conn.query(`select reader.readerId,book.bookId,readerName,bookName,date from reserve 
    	left join reader on reserve.readerId=reader.readerId 
    	left join book on reserve.bookId=book.bookId`, (err, rs) => {
		let data = rs || []
		if (data.length == 0)
			res.json({
				msg: '管理员请求预订记录为空',
				status: 0,
			})
		else
			res.json({
				msg: '管理员请求预订记录成功',
				status: 200,
				data: rs
			})

	})
})
// 管理员删除借阅记录接口
router.post('/deleteborrow', (req, res) => {
	let data = req.body
	conn.query(`delete from borrow where readerId='${data.readerId}' 
    	and bookId='${data.bookId}' and borrowDate='${data.borrowDate}'`)
	res.json({
		msg: '管理员删除借阅记录成功',
		status: 200,
	})
})

// 人员管理
// 管理员获取人员信息
router.post('/initreaderlist', (req, res) => {
	conn.query(`select * from reader`, (err, rs) => {
		let data = rs || []
		if (data.length == 0)
			res.json({
				msg: '管理员请求人员记录为空',
				status: 0,
			})
		else
			res.json({
				msg: '管理员请求人员记录成功',
				status: 200,
				data: data
			})

	})
})
// 管理员删除人员信息
router.post('/delperson', (req, res) => {
	let data = req.body;
	conn.query(`delete from reader where readerId='${data.readerId}'`)
	res.send({
		msg: '删除人员成功！',
		status: 200
	})
})


// 管理员修改图书信息
router.post('/changebookinfo', (req, res) => {
	let data = req.body
	let status = data.status
	switch (status) {
		case '1': {
			// 修改书名
			conn.query(`update book set bookName='${data.value}' where bookId='${data.bookId}'`)
			res.send({
				status: 200,
				msg: '修改书名成功！'
			})
			break;
		}
		case '2': {
			// 修改作者
			conn.query(`update book set author='${data.value}' where bookId='${data.bookId}'`)
			res.send({
				status: 200,
				msg: '修改作者成功！'
			})
			break;
		}
		case '3': {
			// 修改位置
			conn.query(`select * from book where position = '${data.value}'`, (err, rs) => {
				if (rs.length > 0) {
					return res.send({
						msg: '该位置已有书籍存放！',
						status: 0
					})
				} else {
					conn.query(`update book set position='${data.value}' where bookId='${data.bookId}'`)
					res.send({
						status: 200,
						msg: '修改位置成功！'
					})
				}
			})
			break;
		}
		case '4': {
			// 修改当前库存
			conn.query(`update book set amount='${data.value}' where bookId='${data.bookId}'`)
			// 修改总库存
			conn.query(`update book set totalAmount=totalAmount + '${data.difference}' where bookId='${data.bookId}'`)
			res.send({
				status: 200,
				msg: '修改当前库存成功！'
			})
			break;
		}
		default: break;
	}
})


// 管理员删除图书
router.post('/delbook', (req, res) => {
	const data = req.body;

	// 调用 SQL 查询
	conn.query(`DELETE FROM book WHERE bookId = ?`, [data.bookId], (err, results) => {
		if (err) {
			console.error("删除失败:", err);
			return res.status(500).send({
				msg: '删除图书失败',
				status: 500,
				error: err.message
			});
		}

		res.send({
			msg: '删除图书成功',
			status: 200
		});
	});
});
// 管理提醒用户还书
router.post('/alertperson', (req, res) => {
	let data = req.body
	conn.query(`select email from reader where readerId='${data.readerId}'`, (err, rs) => {
		console.log('rs:', rs);
		var email = rs[0].email
		let transporter = nodemailer.createTransport({
			service: 'qq',
			port: 465,
			secure: true,
			auth: {
				user: userEmail, // QQ邮箱
				pass: userCode	// 授权码
			},
		});
		let mailobj = {
			from: userEmail, // 发送者QQ邮箱
			to: `${email}`, // 接收者QQ邮箱
			subject: "还书提醒", 
			text: `读者您好，请尽快归还书籍:${data.bookName}！`,
		}
		transporter.sendMail(mailobj, (err, data) => {
			console.log(data);
		});

		res.send({
			msg: '发送成功！',
			status: 200
		})
	})

})
// 管理员删除评论接口
router.post('/delcomment', (req, res) => {
	let data = req.body;
	console.log("管理员删除评论接口", data);
	// 执行删除操作
	conn.query(`DELETE FROM comment WHERE commentId = ?  `,
		[data.commentId],
		(err, rs) => {
			if (err) {
				console.error("删除评论失败", err);
				return res.send(   {
					msg: '删除失败',
					status: 500
				});
			}

			if (rs.affectedRows === 0) {
				return res.send({
					msg: '未找到匹配的评论',
					status: 404
				});
			}

			res.send({
				msg: '删评成功！',
				status: 200
			});
		}
	);
});
module.exports = router;

