//保险赔偿

const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/bxpc');

/**
 * 索赔处理
 */
router.get('/suopei', async (ctx, next) => {
  const page = ctx.query.page || 1;
  const pageSize = ctx.query.pageSize || 10;
  const start = (page - 1) * pageSize;
  const result = await query(`SELECT *
                              FROM claims limit ${start},${pageSize}`);
  const total = await query(`SELECT COUNT(*)
                             FROM claims`);
  ctx.body = {
    code: 200,
    data: result,
    total: total[0]['COUNT(*)']
  };
});
/**
 * 获取索赔详情
 */
router.get('/suopeiDetail', async (ctx, next) => {
    const claims_id = ctx.query.claimsId;
    const result = await query(`SELECT *
                                FROM claims
                                WHERE claims_id = ${claims_id}`);
    ctx.body = {
      code: 200,
      data: result
    };
  }
);
/**
 * 索赔删除
 */
router.delete('/suopei', async (ctx, next) => {
  // 根据claims_id删除数据
  const claims_id = ctx.query.claimsId;
  const result = await query(`DELETE
                              FROM claims
                              WHERE claims_id = ${claims_id}`);
  ctx.body = {
    code: 200,
    data: result
  };
});


/**
 * 理赔处理
 */
router.get('/lipei', async (ctx, next) => {
  const page = ctx.query.page || 1;
  const pageSize = ctx.query.pageSize || 10;
  const start = (page - 1) * pageSize;
  const result = await query(`SELECT *
                              FROM lipei limit ${start},${pageSize}`);
  const total = await query(`SELECT COUNT(*)
                             FROM lipei`);
  ctx.body = {
    code: 200,
    data: result,
    total: total[0]['COUNT(*)']
  };
});
/**
 * 获取理赔详情
 */
router.get('/lipeiDetail', async (ctx, next) => {
    const lipei_id = ctx.query.lipeiId;
    const result = await query(`SELECT *
                                FROM lipei
                                WHERE lipei_id = ${lipei_id}`);
    ctx.body = {
      code: 200,
      data: result
    };
  }
);
/**
 * 理赔删除
 * @type {*|module:koa-router|Router}
 */
router.delete('/lipei', async (ctx, next) => {
    // 根据claims_id删除数据
    const lipei_id = ctx.query.lipeiId;
    const result = await query(`DELETE
                                FROM lipei
                                WHERE lipei_id = ${lipei_id}`);
    ctx.body = {
      code: 200,
      data: result
    };
  }
);
module.exports = router
