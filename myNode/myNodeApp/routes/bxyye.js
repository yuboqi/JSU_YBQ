//保险营业额

const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/bxpc');

/**
 * 营业额
 */
router.post('/zyye', async (ctx, next) => {
  const bxmc = ctx.request.body.bxmc || '';
  const page = ctx.request.body.page || 1;
  const pageSize = ctx.request.body.pageSize || 10;
  const start = (page - 1) * pageSize;
  const costResult = await query(`SELECT i.policies_id,
                                         i.number,
                                         it.insuranceName,
                                         i.insurance_cost
                                  FROM insurance_policies i
                                           LEFT JOIN insurance_types it ON i.type_id = it.type_id `);
  const claimsResult = await query(`SELECT cl.policies_id,
                                           cl.claims_money
                                    FROM claims cl
                                    where cl.claims_status = 'approved'`);
  const lipeiResult = await query(`SELECT cl.policies_id,
                                          l.lipei_money
                                   FROM lipei l
                                            LEFT JOIN claims cl ON l.claims_id = cl.claims_id
  `);
  const result = [];
  for (let i = 0; i < costResult.length; i++) {
    if (bxmc && costResult[i].insuranceName.indexOf(bxmc) === -1) {
      continue;
    }
    const policiesId = costResult[i].policies_id;
    const insuranceCost = costResult[i].insurance_cost;
    let claimsMoney = 0;
    let lipeiMoney = 0;
    for (let j = 0; j < claimsResult.length; j++) {
      if (policiesId === claimsResult[j].policies_id) {
        claimsMoney = claimsResult[j].claims_money;
      }
    }
    for (let k = 0; k < lipeiResult.length; k++) {
      if (policiesId === lipeiResult[k].policies_id) {
        lipeiMoney = lipeiResult[k].lipei_money;
      }
    }
    const turnover = insuranceCost - claimsMoney - lipeiMoney;
    result.push({
      policiesId,
      insuranceCost,
      claimsMoney,
      lipeiMoney,
      turnover,
      number: costResult[i].number,
      insuranceName: costResult[i].insuranceName
    })
  }
  const total = await query(`SELECT count(*)
                             FROM insurance_policies`);
  ctx.body = {
    code: 200,
    data: result.slice(start, start + pageSize),
    total: total[0]['count(*)']
  }
  ctx.body = {
    code: 200,
    data: result,
    total: total[0]['count(*)']
  }
});
/**
 * 获取营业额详情：根据policies_id查询
 */
router.get('/detail', async (ctx, next) => {
    const policiesId = ctx.query.policiesId;
    const newSQL = `SELECT i.policies_id,
                           i.number,
                           i.start_time,
                           i.end_time,
                           i.insurance_cost,
                           i.insurance_cost - cl.claims_money AS turnover,
                           it.description,
                           it.rate,
                           it.ranges,
                           c.cust_id,
                           c.cust_account,
                           c.cust_name,
                           c.role,
                           c.cust_address,
                           c.cust_phone,
                           c.cust_birthday,
                           c.cust_email,
                           c.cust_sex,
                           r.root_id,
                           r.root_name,
                           r.role,
                           r.root_phone
                    FROM insurance_policies i
                             LEFT JOIN insurance_types it ON i.type_id = it.type_id
                             LEFT JOIN customer c ON i.cust_id = c.cust_id
                             LEFT JOIN root r ON i.root_id = r.root_id
                             LEFT JOIN claims cl ON i.policies_id = cl.policies_id
                    WHERE i.policies_id = ${policiesId}`;
    const result = await query(newSQL);
    ctx.body = {
      code: 200,
      data: result
    }
  }
);
/**
 * 删除营业额
 */
router.delete('/delete', async (ctx, next) => {
  const policiesId = ctx.request.body.policiesId;
  const result = await query(`DELETE
                              FROM insurance_policies
                              WHERE policies_id = ${policiesId}`);
  ctx.body = {
    code: 200,
    data: result
  };
});
/**
 * 产品营业额
 */
router.post('/cpyye', async (ctx, next) => {
  const bxmc = ctx.request.body.bxmc || '';
  const page = ctx.request.body.page || 1;
  const pageSize = ctx.request.body.pageSize || 10;
  const start = (page - 1) * pageSize;

  const costResult = await query(`SELECT i.type_id,
                                         it.insuranceName,
                                         sum(i.insurance_cost) AS insurance_cost
                                  FROM insurance_policies i
                                           LEFT JOIN insurance_types it ON i.type_id = it.type_id
                                  GROUP BY i.type_id`);
  const claimsResult = await query(`SELECT i.type_id,
                                           sum(cl.claims_money) AS claims_money
                                    FROM claims cl
                                             LEFT JOIN insurance_policies i ON cl.policies_id = i.policies_id
                                    where cl.claims_status = 'approved'
                                    group by i.type_id
  `);
  const lipeiResult = await query(`SELECT
                                          i.type_id,
                                          sum(l.lipei_money) AS lipei_money
                                   FROM lipei l
                                            LEFT JOIN claims cl ON l.claims_id = cl.claims_id
                                            left join insurance_policies i on cl.policies_id = i.policies_id
                                   group by i.type_id
  `);
  const result = [];
  for (let i = 0; i < costResult.length; i++) {
    if (bxmc && costResult[i].insuranceName.indexOf(bxmc) === -1) {
      continue;
    }
    let claimsMoney = 0;
    let lipeiMoney = 0;
    const typeId = costResult[i].type_id;
    for (let j = 0; j < claimsResult.length; j++) {
      if (typeId === claimsResult[j].type_id) {
        claimsMoney = claimsResult[j].claims_money;
      }
    }
    for (let k = 0; k < lipeiResult.length; k++) {
      if (typeId === lipeiResult[k].type_id) {
        lipeiMoney = lipeiResult[k].lipei_money;
      }
    }
    const turnover = costResult[i].insurance_cost - claimsMoney - lipeiMoney;
    result.push({
      type_id: typeId,
      insuranceCost: costResult[i].insurance_cost,
      claimsMoney,
      lipeiMoney,
      turnover,
      number: costResult[i].number,
      insuranceName: costResult[i].insuranceName
    })
  }

  const total = await query(`SELECT count(*)
                             FROM insurance_policies i
                                      LEFT JOIN insurance_types it ON i.type_id = it.type_id
                             GROUP BY i.type_id`);
  ctx.body = {
    code: 200,
    data: result.slice(start, start + pageSize),
    total: total[0]['count(*)']
  }
})

module.exports = router
