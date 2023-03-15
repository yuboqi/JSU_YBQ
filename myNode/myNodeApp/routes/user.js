//用户管理
const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/user');

/**
 * 获取用户列表
 */
router.get('/list', async (ctx, next) => {
  const keyword = ctx.query.keyword || '';
  const page = ctx.query.page || 1;
  const pageSize = ctx.query.pageSize || 10;
  const start = (page - 1) * pageSize;
  const result = await query(`SELECT *
                              FROM customer
                              where cust_name like '%${keyword}%'
                                  limit ${start}
                                  , ${pageSize}`);
  const total = await query(`SELECT COUNT(*)
                             FROM customer
                             where cust_name like '%${keyword}%'`);
  ctx.body = {
    code: 200,
    data: result,
    total: total[0]['COUNT(*)']
  }
});

/**
 * 获取用户信息
 */
router.get('/info', async (ctx, next) => {
  const custId = ctx.query.custId;
  const result = await query(`SELECT *
                              FROM customer
                              WHERE cust_id = '${custId}'`);
  ctx.body = {
    code: 200,
    data: result
  }
});

/**
 * 更新用户信息
 */
router.post('/update', async (ctx, next) => {
  const cust_name = ctx.request.body.cust_name;
  const cust_account = ctx.request.body.cust_account;
  const cust_password = ctx.request.body.cust_password;
  const cust_address = ctx.request.body.cust_address;
  const cust_sex = ctx.request.body.cust_sex;
  const cust_phone = ctx.request.body.cust_phone;
  const cust_email = ctx.request.body.cust_email;
  const role = ctx.request.body.role;
  const cust_id = ctx.request.body.cust_id;
  const result = await query(`UPDATE customer
                              SET cust_account  = '${cust_account}',
                                  cust_password = '${cust_password}',
                                  cust_name     = '${cust_name}',
                                  role          = ${role},
                                  cust_address  = '${cust_address}',
                                  cust_sex      = '${cust_sex}',
                                  cust_phone    = '${cust_phone}',
                                  cust_email    = '${cust_email}',
                                  role          = ${role}
                              WHERE cust_id = '${cust_id}'`);
  ctx.body = {
    code: 200,
    data: result
  }
});

/**
 * 删除用户
 */
router.post('/delete', async (ctx, next) => {
  const custId = ctx.request.body.custId;
  const result = await query(`DELETE
                              FROM customer
                              WHERE cust_id = '${custId}'`);
  ctx.body = {
    code: 200,
    data: result
  }
});

/**
 * 添加用户
 */
router.post('/add', async (ctx, next) => {
  const cust_name = ctx.request.body.cust_name;
  const cust_account = ctx.request.body.cust_account;
  const cust_password = ctx.request.body.cust_password;
  const cust_address = ctx.request.body.cust_address;
  const cust_sex = ctx.request.body.cust_sex;
  const cust_phone = ctx.request.body.cust_phone;
  const cust_email = ctx.request.body.cust_email;
  const role = ctx.request.body.role;
  const result = await query(`INSERT INTO customer(cust_account, cust_password, cust_name, role, cust_address,
                                                   cust_phone, cust_email, cust_sex)
                              values ('${cust_account}', '${cust_password}', '${cust_name}', ${role}, '${cust_address}',
                                      '${cust_phone}', '${cust_email}', '${cust_sex}')`);
  ctx.body = {
    code: 200,
    data: result
  }
});

module.exports = router
