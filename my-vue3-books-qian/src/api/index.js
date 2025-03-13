// 对所有的api接口进行统一管理
import http from "./http";

// 注册接口
export const postRegisterAPI = (readerInfo) =>
  http({
    url: "/register",
    method: "post",
    data: readerInfo,
  });
// 登录接口
export const postLoginAPI = (readerInfo) =>
  http({
    url: "/login",
    method: "post",
    data: readerInfo,
  });
// 书籍接口
export const postBooksAPI = () =>
  http({
    url: "/books",
    method: "post",
  });
// 评论区接口
export const postCommentsAPI = () =>
  http({
    url: "/comments",
    method: "post",
  });
// 添加评论接口
export const postAddCommentAPI = (dataObj) =>
  http({
    url: "/addcomment",
    method: "post",
    data: dataObj,
  });
// 点赞接口
export const postAddPraiseAPI = (dataObj) =>
  http({
    url: "/addpraise",
    method: "post",
    data: dataObj,
  });
// 书名查找接口
export const postSearchBookAPI = (bookNameObj) =>
  http({
    url: "/searchbook",
    method: "post",
    data: bookNameObj,
  });

// 管理员查询借阅接口
export const postBorrowsListAPI = (readerId) =>
  http({
    url: "/borrowslist",
    method: "post",
    data: readerId,
  });

export const postInitReportListAPI = () =>
  http({
    url: "/initreportlist",
    method: "post",
  });

// 管理员查询预订接口
export const postReserveListAPI = () =>
  http({
    url: "/reservelist",
    method: "post",
  });
// 管理员删除借阅记录接口
export const postDeleteBorrowAPI = (borrowObj) =>
  http({
    url: "/deleteborrow",
    method: "post",
    data: borrowObj,
  });
// 管理员通过读者ID查找借阅记录接口
export const postSearchBorrowAPI = (infoObj) =>
  http({
    url: "/searchborrow",
    method: "post",
    data: infoObj,
  });
// 管理员获取读者信息接口
export const postInitReaderListAPI = () =>
  http({
    url: "/initreaderlist",
    method: "post",
  });
// 管理员添加书籍接口
export const postAdminAddBooksAPI = (infoObj) =>
  http({
    url: "/adminaddbooks",
    method: "post",
    data: infoObj,
  });

// 管理员删除评论接口
export const postDelCommentAPI = (infoObj) =>
  http({
    url: "/delcomment",
    method: "post",
    data: infoObj,
  });
// 管理员修改图书信息接口
export const postChangeBookInfoAPI = (infoObj) =>
  http({
    url: "/changebookinfo",
    method: "post",
    data: infoObj,
  });
// 管理员删除图书信息接口
export const postDelBookAPI = (infoObj) =>
  http({
    url: "/delbook",
    method: "post",
    data: infoObj,
  });
// 管理员删除人员信息接口
export const postDelPersonAPI = (infoObj) =>
  http({
    url: "/delperson",
    method: "post",
    data: infoObj,
  });
// 管理员提醒读者还书接口
export const postAlertPersonAPI = (infoObj) =>
  http({
    url: "/alertperson",
    method: "post",
    data: infoObj,
  });

// 读者请求借阅记录接口
export const postBorrowsAPI = (readerId) =>
  http({
    url: "/borrows",
    method: "post",
    data: readerId,
  });
// 读者查询举报记录接口
export const postInitStuReportAPI = (readerId) =>
  http({
    url: "/initstureport",
    method: "post",
    data: readerId,
  });
// 添加预约记录接口
export const postAddReserveAPI = (reserveObj) =>
  http({
    url: "/addreserve",
    method: "post",
    data: reserveObj,
  });
// 删除预约记录接口
export const postCancelReserveAPI = (reserveObj) =>
  http({
    url: "/cancelreserve",
    method: "post",
    data: reserveObj,
  });
// 借书接口
export const postAddBorrowAPI = (borrowObj) =>
  http({
    url: "/addborrow",
    method: "post",
    data: borrowObj,
  });
// 续借接口
export const postContinueBorrowAPI = (infoObj) =>
  http({
    url: "/continueborrow",
    method: "post",
    data: infoObj,
  });
// 还书接口
export const postReturnBookAPI = (infoObj) =>
  http({
    url: "/returnbook",
    method: "post",
    data: infoObj,
  });
// 查询预约接口
export const postReserveAPI = (readerObj) =>
  http({
    url: "/reserve",
    method: "post",
    data: readerObj,
  });
// 重新获取学生信息接口
export const postInitReaderAPI = (readerId) =>
  http({
    url: "/initreader",
    method: "post",
    data: readerId,
  });
//获取管理员信息接口
export const getInitAdminAPI = () =>
  http({
    url: "/initadmin",
    method: "get",
  });
