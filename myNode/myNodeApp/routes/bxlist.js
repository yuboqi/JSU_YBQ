//保险信息

const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/bxxx');

/**
 * 获取保险列表
 */
router.get('/list', async (ctx, next) => {
  const bxmc = ctx.query.bxmc || '';
  const page = ctx.query.page || 1;
  const pageSize = ctx.query.pageSize || 10;
  const start = (page - 1) * pageSize;
  const result = await query(`SELECT *
                              FROM insurance_types
                              WHERE insuranceName LIKE '%${bxmc}%' limit ${start}
                                  , ${pageSize}`);
  const total = await query(`SELECT COUNT(*)
                             FROM insurance_types
                             WHERE insuranceName LIKE '%${bxmc}%'`);
  ctx.body = {
    code: 200,
    data: result,
    total: total[0]['COUNT(*)']
  }
});

/**
 * 添加保险
 */
router.post('/add', async (ctx, next) => {
  const insuranceName = ctx.request.body.insuranceName;
  const upperLimit = ctx.request.body.upperLimit;
  const description = ctx.request.body.description;
  const rate = ctx.request.body.rate;
  const ranges = ctx.request.body.ranges;
  const result = await query(`INSERT INTO insurance_types (insuranceName, upperLimit, description, rate, ranges)
                              VALUES ('${insuranceName}', '${upperLimit}', '${description}', '${rate}', '${ranges}')`);
  ctx.body = {
    code: 200,
    data: result
  }
})

/**
 * 修改保险
 */
router.put('/update', async (ctx, next) => {
  const typeId = ctx.request.body.typeId;
  const insuranceName = ctx.request.body.insuranceName;
  const upperLimit = ctx.request.body.upperLimit;
  const description = ctx.request.body.description;
  const rate = ctx.request.body.rate;
  const ranges = ctx.request.body.ranges;
  const result = await query(`UPDATE insurance_types
                              SET insuranceName = '${insuranceName}',
                                  upperLimit    = '${upperLimit}',
                                  description   = '${description}',
                                  rate          = '${rate}',
                                  ranges        = '${ranges}'
                              WHERE type_id = '${typeId}'`);
  ctx.body = {
    code: 200,
    data: result
  }
});

/**
 * 删除保险
 */
router.delete('/delete', async (ctx, next) => {
  const typeId = ctx.query.typeId;
  const result = await query(`DELETE
                              FROM insurance_types
                              WHERE type_id = '${typeId}'`);
  ctx.body = {
    code: 200,
    data: result
  }
});

/**
 * 购买保险
 */
router.post('/buy', async (ctx, next) => {
  const userId = ctx.request.body.userId;
  const typeId = ctx.request.body.typeId;
  const root_id = ctx.request.body.root_id;
  const amount = ctx.request.body.amount;
  // 查看是否已购买
  const isBuy = await query(`SELECT *
                             FROM insurance_policies
                             WHERE cust_id = '${userId}'
                               AND type_id = '${typeId}'`);
  if (isBuy.length > 0) {
    ctx.body = {
      code: 201,
      data: '已购买'
    }
    return;
  }
  // 根据typeId查询保险信息
  const insurance = await query(`SELECT *
                                 FROM insurance_types
                                 WHERE type_id = '${typeId}'`);
  const insuranceName = insurance[0].insuranceName;
  const upperLimit = insurance[0].upperLimit;
  const description = insurance[0].description;
  const rate = insurance[0].rate;
  const ranges = insurance[0].ranges;
  const random = Math.random().toString().slice(-8);
  // const startDate = new Date();
  // const tempDate = new Date();
  // const endDate = new Date(tempDate.setFullYear(tempDate.getFullYear() + 1));
  const result = await query(`INSERT INTO insurance_policies (policies_id, number, start_time, end_time, insurance_cost,
                                                              type_id, cust_id, root_id)
                              VALUES (NULL, '${random}',
                                      '${new Date().toLocaleDateString()}',
                                      '${new Date(new Date().setFullYear(new Date().getFullYear() + 1)).toLocaleDateString()}',
                                      '${amount}', '${typeId}',
                                      '${userId}', '${root_id}')`);
  ctx.body = {
    code: 200,
    data: result
  }
});

/**
 * 我的购买订单
 */
router.get('/myOrder', async (ctx, next) => {
  const userId = ctx.query.userId;
  const bxmc = ctx.query.bxmc || '';
  const ddh = ctx.query.ddh || '';
  const page = ctx.query.page || 1;
  const pageSize = ctx.query.pageSize || 10;
  const start = (page - 1) * pageSize;
  console.log('-------------'+ddh+'------------')
  const result = await query(`SELECT i.policies_id    as policies_id,
                                     i.number         as number,
                                     i.start_time     as start_time,
                                     i.end_time       as end_time,
                                     i.insurance_cost as insurance_cost,
                                     t.insuranceName  as insuranceName
                              FROM insurance_policies i
                                       LEFT JOIN insurance_types t ON i.type_id = t.type_id
                              WHERE i.cust_id = '${userId}'
                                AND i.number LIKE '%${ddh}%'
                                AND t.insuranceName LIKE '%${bxmc}%' limit ${start}
                                  , ${pageSize}`);
  const total = await query(`SELECT COUNT(*)
                             FROM insurance_policies i
                                      LEFT JOIN insurance_types t ON i.type_id = t.type_id
                             WHERE i.cust_id = '${userId}'
                               AND i.number LIKE '%${ddh}%'
                               AND t.insuranceName LIKE '%${bxmc}%'`);
  ctx.body = {
    code: 200,
    data: result,
    total: total[0]['COUNT(*)']
  }
});
/**
 * 我的保险
 */
router.get('/myBx', async (ctx, next) => {
  const userId = ctx.query.userId;
  const result = await query(`SELECT i.policies_id    as policies_id,
                                     i.number         as number,
                                     i.start_time     as start_time,
                                     i.end_time       as end_time,
                                     i.insurance_cost as insurance_cost,
                                     t.insuranceName  as insuranceName
                              FROM insurance_policies i
                                       LEFT JOIN insurance_types t ON i.type_id = t.type_id
                              WHERE i.cust_id = '${userId}' `);
  ctx.body = {
    code: 200,
    data: result
  }
});

/**
 * 删除订单
 */
router.delete
('/deleteOrder', async (ctx, next) => {
  const policiesId = ctx.query.policiesId;
  const result = await query(`
      DELETE
      FROM insurance_policies
      WHERE policies_id = '${policiesId}'`);
  ctx.body = {
    code: 200,
    data: result
  }
});

module.exports = router
