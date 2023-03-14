//保险营业额

const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/lipei');

/**
 * 理赔
 */
router.post('/', async (ctx, next) => {
  const claimsId = ctx.request.body.claimsId; // 索赔ID
  const rootId = ctx.request.body.rootId; // 业务员ID
  const number = ctx.request.body.number; // 理赔单号
  const lipeiMoney = ctx.request.body.lipeiMoney; // 理赔金额
  const lipeiDate = Date.now();

  // 1. 根据索赔ID查询索赔是否存在
  const claims = await query(`SELECT *
                              FROM claims
                              WHERE claims_id = ${claimsId}`);
  if (claims.length === 0) {
    ctx.body = {
      code: 201,
      msg: '索赔不存在'
    }
  }
  // 2. 根据索赔ID查询索赔是否已经理赔
  const claims2 = await query(`SELECT *
                               FROM claims
                               WHERE claims_id = ${claimsId}
                                 AND claims_status = 'pending' ||
                                                     ''`);
  if (claims2.length === 0) {
    ctx.body = {
      code: 201,
      msg: '索赔已理赔'
    }
  }
  // 理赔a
  const random = Math.random().toString().slice(2, 6);
  const result = await query(`INSERT INTO lipei (lipei_id, claims_id, root_id, lipei_number, lipei_date, lipei_money)
                              VALUES (${random}, ${claimsId}, ${rootId}, '${number}', '${lipeiDate}',
                                      ${lipeiMoney})`);
  // 更新状态
  const result2 = await query(`UPDATE claims
                               SET claims_status = 'negotiation'
                               WHERE claims_id = ${claimsId}`);
  if (result.affectedRows === 1 && result2.affectedRows === 1) {
    ctx.body = {
      code: 200,
      msg: '理赔成功'
    }
  }
});


module.exports = router;
