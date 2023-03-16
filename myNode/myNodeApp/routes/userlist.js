//权限管理ybq

const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/userlist');


//获取用户列表
router.get('/', async (ctx, next) => {
  // console.log(ctx.request.body);
  //更新数据

  //获取root和customer表中的数据的sql语句
  let a = await query(`SELECT *
                       FROM root;`);
  let b = await query(`SELECT *
                       FROM customer;`);
  console.log(a);
  console.log(b);

  if (a.length > 0 && b.length > 0) {
    var dataString = JSON.stringify(a);
    var result = JSON.parse(dataString);
    var dataString2 = JSON.stringify(b);
    var result2 = JSON.parse(dataString2);

    console.log(result);
    console.log(result2);

    // 200代表更新成功
    let data = {
      code: 200, root: result, customer: result2
    };
    ctx.body = data;
  } else if (a.length > 0 && b.length == 0) {
    var dataString = JSON.stringify(a);
    var result = JSON.parse(dataString);
    console.log(result);
    // 200代表更新成功
    let data = {
      code: 200, root: result, customer: []
    };
    ctx.body = data;
  } else if (a.length == 0 && b.length > 0) {
    var dataString2 = JSON.stringify(b);
    var result2 = JSON.parse(dataString2);
    console.log(result2);
    // 200代表更新成功
    let data = {
      code: 200, root: [], customer: result2
    };
    ctx.body = data;
  } else {
    let data = {
      code: 400, errorMessage: "获取失败"
    };
    ctx.body = data;
  }
});

//保险员查看自己手下的客户
router.get('/user', async (ctx, next) => {
  let root_id = ctx.request.query.root_id;
  let number = ctx.request.query.number || '';
  let bxmc = ctx.request.query.bxmc || '';
  let khmc = ctx.request.query.khmc || '';
  const page = ctx.query.page || 1;
  const pageSize = ctx.query.pageSize || 10;
  const start = (page - 1) * pageSize;
  // 查询rootid下客户
  const result = await query(`SELECT *
                              FROM insurance_policies i
                                       LEFT JOIN insurance_types t ON i.type_id = t.type_id
                                       LEFT JOIN customer c ON i.cust_id = c.cust_id
                              WHERE i.root_id = '${root_id}'
                                AND t.insuranceName LIKE '%${bxmc}%'
                                AND c.cust_name LIKE '%${khmc}%' 
                                AND i.number LIKE '%${number}%'
                                  LIMIT ${start}
                                  , ${pageSize}`);
  const total = await query(`SELECT COUNT(*)
                             FROM insurance_policies i
                                      LEFT JOIN insurance_types t ON i.type_id = t.type_id
                                      LEFT JOIN customer c ON i.cust_id = c.cust_id
                             WHERE i.root_id = '${root_id}'
                               AND t.insuranceName LIKE '%${bxmc}%'
                               AND c.cust_name LIKE '%${khmc}%'
                               AND i.number LIKE '%${number}%'`);
  ctx.body = {
    code: 200,
    data: result,
    total: total[0]['COUNT(*)']
  };
});


module.exports = router
