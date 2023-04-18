//反馈信息

const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/fankui');

//获取反馈信息
router.get('/', async (ctx, next) => {
  const page = ctx.query.page || 1;
  const pageSize = ctx.query.pageSize || 10;
  const start = (page - 1) * pageSize;
	//更新数据
	let result = await query(
		`SELECT * FROM fankui ORDER BY id DESC LIMIT ${start},${pageSize}`
	);

  let total = await query(
    `SELECT COUNT(*) FROM fankui`
  );
  console.log("--------------------");
  console.log(result);
  console.log(total);
  ctx.body = {
    code: 200,
    data: result,
    total: total[0]['COUNT(*)']
  };
});

//添加反馈信息
router.post('/', async (ctx, next) => {
  // console.log(ctx.request.body);
  let title = ctx.request.body.title;
  let content = ctx.request.body.content;
  let data = ctx.request.body.data;
  let user_name = ctx.request.body.user_name;
  //更新数据
  let a = await query(
    `INSERT INTO fankui (title,content,data,user_name) VALUES ('${title}','${content}','${data}','${user_name}')`
  );
  console.log("--------------------");
  console.log(a);
  if (a.affectedRows == 1) {
    // 更新成功
    //根据id查询数据库,返回前端
    let newA = await query(`SELECT * FROM fankui`);
    // 格式化数据类型
    var newDataString = JSON.stringify(newA);
    var newResult = JSON.parse(newDataString);
    console.log(newResult);
    // 200代表更新成功
    let data = {
      code: 200,
      data: newResult
    };
    ctx.body = data;
  } else {
    let data = {
      code: 400,
      errorMessage: "添加失败"
    };
    ctx.body = data;
  }
}
);

//删除公告信息
router.delete('/', async (ctx, next) => {
  // console.log(ctx.request.body);
  let id = ctx.request.query.id;
  //更新数据
  let a = await query(
    `DELETE FROM fankui WHERE id = '${id}'`
  );
  console.log("--------------------");
  console.log(a);
  if (a.affectedRows == 1) {
    // 更新成功
    //根据id查询数据库,返回前端
    let newA = await query(`SELECT * FROM fankui`);
    // 格式化数据类型
    var newDataString = JSON.stringify(newA);
    var newResult = JSON.parse(newDataString);
    console.log(newResult);
    // 200代表更新成功
    let data = {
      code: 200,
      data: newResult
    };
    ctx.body = data;
  } else {
    let data = {
      code: 400,
      errorMessage: "删除失败"
    };
    ctx.body = data;
  }
}
);

module.exports = router