// 索赔管理

const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/spgl');

/**
 * 申请索赔
 */
router.post('/apply', async (ctx, next) => {
  const custId = ctx.request.body.custId;  // 用户id
  const policyId = ctx.request.body.policyId; // 保险ID
  const claimsDate = ctx.request.body.claimsDate; // 索赔日期
  const claimsMoney = ctx.request.body.claimsMoney; // 索赔金额
  const description = ctx.request.body.description; // 索赔描述
  // // 1. 根据用户id查询此用户否购买了保险
  // const result = await query(`SELECT *
  //                             FROM insurance_policies
  //                             WHERE cust_id = ${custId}
  //                               AND policies_id = ${policyId}`);
  // if (result.length === 0) {
  //   ctx.body = {
  //     code: 201,
  //     msg: '您未购买此保险'
  //   }
  // }
  // // 2. 根据保险ID查询保险是否已经过期
  // const result2 = await query(`SELECT *
  //                              FROM insurance_policies
  //                              WHERE policies_id = ${policyId}
  //                                AND end_time < NOW()`);
  // if (result2.length > 0) {
  //   ctx.body = {
  //     code: 201,
  //     msg: '保险已过期'
  //   }
  // }
  // // 3. 根据保险ID查询保险是否已经索赔
  // const result3 = await query(`SELECT *
  //                              FROM claims
  //                              WHERE policies_id = ${policyId}
  //                                AND claims_id = ${custId}
  //                                AND claims_status <> 'blocked'
  // `);
  // if (result3.length > 0) {
  //   ctx.body = {
  //     code: 201,
  //     msg: '您已经申请过索赔'
  //   }
  // }
  // // 4. 申请索赔
  const random = Math.random().toString().slice(2, 6);
  const result4 = await query(`INSERT INTO claims (claims_id, policies_id, cust_id, claims_number, claims_date,
                                                   claims_money,
                                                   description, claims_status)
                               VALUES (${random}, ${policyId}, ${custId}, 'SP${Date.now()}', '${claimsDate}',
                                       ${parseFloat(claimsMoney)},
                                       '${description}', 'pending')
  `);
  if (result4.affectedRows === 1) {
    ctx.body = {
      code: 200,
      msg: '申请成功'
    }
  }
})
/**
 * 我的索赔
 */
router.get('/myClaims', async (ctx, next) => {
    const userId = ctx.request.query.userId; // 用户ID
    const role = ctx.request.query.role; // 用户角色
    const ddh = ctx.request.query.ddh || ''; // 订单号
    const bxmc = ctx.request.query.bxmc || ''; // 保险名称
    const page = ctx.query.page || 1;
    const pageSize = ctx.query.pageSize || 10;
    const start = (page - 1) * pageSize;
    let result;
    if (role === '2') {
      result = await query(`SELECT c.claims_id      as claimsId,
                                   c.claims_number  as claimsNumber,
                                   c.claims_date    as claimsDate,
                                   c.claims_money   as claimsMoney,
                                   c.description    as description,
                                   c.description    as description,
                                   c.claims_status  as claimsStatus,
                                   t.insuranceName  as insuranceName,
                                   p.insurance_cost as insuranceCost,
                                   p.number         as number,
                                   t.rate           as rate,
                                   p.policies_id    as policiesId,
                                   l.lipei_money    as lipeiMoney,
                                   l.lipei_date     as lipeiDate,
                                   u.cust_name      as custName
                            FROM claims c
                                     LEFT JOIN insurance_policies p ON c.policies_id = p.policies_id
                                     LEFT JOIN insurance_types t ON p.type_id = t.type_id
                                     LEFT JOIN lipei l ON c.claims_id = l.claims_id
                                     LEFT JOIN customer u ON u.cust_id = p.cust_id
                            WHERE c.cust_id = ${userId}
                              AND t.insuranceName LIKE '%${bxmc}%'
                              AND p.number LIKE '%${ddh}%'
                            ORDER BY c.claims_date DESC
                                LIMIT ${start}, ${pageSize}
      `);
    } else {
      result = await query(`SELECT c.claims_id      as claimsId,
                                   c.claims_number  as claimsNumber,
                                   c.claims_date    as claimsDate,
                                   c.claims_money   as claimsMoney,
                                   c.description    as description,
                                   c.description    as description,
                                   c.claims_status  as claimsStatus,
                                   t.insuranceName  as insuranceName,
                                   p.insurance_cost as insuranceCost,
                                   p.number         as number,
                                   t.rate           as rate,
                                   p.policies_id    as policiesId,
                                   l.lipei_money    as lipeiMoney,
                                   l.lipei_date     as lipeiDate,
                                   u.cust_name      as custName
                            FROM claims c
                                     LEFT JOIN insurance_policies p ON c.policies_id = p.policies_id
                                     LEFT JOIN insurance_types t ON p.type_id = t.type_id
                                     LEFT JOIN lipei l ON c.claims_id = l.claims_id
                                     LEFT JOIN customer u ON u.cust_id = p.cust_id
                            WHERE t.insuranceName LIKE '%${bxmc}%'
                              AND p.number LIKE '%${ddh}%'
                            ORDER BY c.claims_date DESC
                                LIMIT ${start}, ${pageSize}
      `);
    }
    let total;
    if (role === '2') {
      total = await query(`SELECT COUNT(*)
                           FROM claims c
                                    LEFT JOIN insurance_policies p ON c.policies_id = p.policies_id
                                    LEFT JOIN insurance_types t ON p.type_id = t.type_id
                                    LEFT JOIN lipei l ON c.claims_id = l.claims_id
                                    LEFT JOIN customer u ON p.cust_id = u.cust_id
                           WHERE c.cust_id = ${userId}
                             AND t.insuranceName LIKE '%${bxmc}%'
                             AND c.claims_number LIKE '%${ddh}%'
      `);
    } else {
      total = await query(`SELECT COUNT(*)
                           FROM claims c
                                    LEFT JOIN insurance_policies p ON c.policies_id = p.policies_id
                                    LEFT JOIN insurance_types t ON p.type_id = t.type_id
                                    LEFT JOIN lipei l ON c.claims_id = l.claims_id
                                    LEFT JOIN customer u ON p.cust_id = u.cust_id
                           WHERE t.insuranceName LIKE '%${bxmc}%'
                             AND c.claims_number LIKE '%${ddh}%'
      `);
    }
    result.forEach(item => {
      switch (item.claimsStatus) {
        case '':
        case null:
        case 'pending':
          item.claimsStatus = '待审核';
          break;
        case 'approved':
          item.claimsStatus = '已通过';
          break;
        case 'blocked':
          item.claimsStatus = '不通过';
          break;
        case 'negotiation':
          item.claimsStatus = '已理赔';
          break;
      }
      return item;
    })
    ctx.body = {
      code: 200,
      msg: '查询成功',
      data: result,
      total: total[0]['COUNT(*)']
    }
  }
)
/**
 * 同意索赔
 */
router.post('/agree', async (ctx, next) => {
  const claimsId = ctx.request.body.claimsId; // 索赔ID
  const result = await query(`UPDATE claims
                              SET claims_status = 'approved'
                              WHERE claims_id = ${claimsId}`);
  if (result.affectedRows === 1) {
    ctx.body = {
      code: 200,
      msg: '操作成功'
    }
  }
});

/**
 * 拒绝索赔
 */
router.post('/refuse', async (ctx, next) => {
    const claimsId = ctx.request.body.claimsId; // 索赔ID
    const result = await query(`UPDATE claims
                                SET claims_status = 'blocked'
                                WHERE claims_id = ${claimsId}`);
    if (result.affectedRows === 1) {
      ctx.body = {
        code: 200,
        msg: '操作成功'
      }
    }
  }
);
/**
 * 删除索赔
 */
router.delete('/delete', async (ctx, next) => {
  const claimsId = ctx.request.query.claimsId; // 索赔ID
  const result = await query(`DELETE
                              FROM claims
                              WHERE claims_id = ${claimsId}`);
  if (result.affectedRows === 1) {
    ctx.body = {
      code: 200,
      msg: '删除成功'
    }
  }
});
module.exports = router
