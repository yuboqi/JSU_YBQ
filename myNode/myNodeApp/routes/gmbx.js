//购买保险ybq

const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/gmbx');

/**
 * 获取用户已购买保险列表
 */
router.get('/list', async (ctx, next) => {
  const custId = ctx.query.custId;
  const page = ctx.query.page || 1;
  const pageSize = ctx.query.pageSize || 10;
  const start = (page - 1) * pageSize;
  const result = await query(`SELECT *
                              FROM insurance_policies
                              WHERE cust_id = '${custId}' limit ${start}
                                  , ${pageSize}`);
  const total = await query(`SELECT COUNT(*)
                             FROM insurance_policies
                             WHERE cust_id = '${custId}'`);
  ctx.body = {
    code: 200,
    data: result,
    total: total[0]['COUNT(*)']
  }
});

/**
 * 购买情况统计
 */
router.get('/statistics', async (ctx, next) => {
  const bxmc = ctx.query.bxmc || '';
  const page = ctx.query.page || 1;
  const pageSize = ctx.query.pageSize || 10;
  const start = (page - 1) * pageSize;
  const result = await query(`SELECT t.type_id,
                                     t.insuranceName,
                                     count(*)              as soldCount,
                                     sum(i.insurance_cost) as soldAmount
                              FROM insurance_policies i
                                       LEFT JOIN insurance_types t
                                                 ON i.type_id = t.type_id
                              WHERE t.insuranceName LIKE '%${bxmc}%'
                              GROUP BY i.type_id
                              ORDER BY i.type_id asc
                                  limit ${start}
                                     , ${pageSize}`);

  ctx.body = {
    code: 200,
    data: result,
    total: 1
  }
});
module.exports = router
