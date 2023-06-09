//个人信息 ybq

const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/account');


// 获取管理员和保险员的个人信息
router.get('/root', async (ctx, next) => {
	// console.log(ctx.request.body);
	let root_id = ctx.request.body.root_id;
	//根据用户id值更新数据
	let a = await query(
		`SELECT * from root WHERE root_id = '${root_id}';`
	);
	console.log(a);
	console.log("---------");
	if (a.length > 0) {
		// 200代表更新成功
		let data = {
			code: 200,
			data: a
		};
		ctx.body = data;
	} else {
		let data = {
			code: 400,
			errorMessage: "数据获取失败"
		};
		ctx.body = data;
	}
});

router.get('/user', async (ctx, next) => {
	// console.log(ctx.request.body);
	let cust_id = ctx.request.body.cust_id;
	//根据用户id值更新数据
	let a = await query(
		`SELECT * from customer WHERE cust_id = '${cust_id}';`
	);
	console.log(a);
	console.log("---------");
	if (a.length > 0) {
		// 200代表更新成功
		let data = {
			code: 200,
			data: a
		};
		ctx.body = data;
	} else {
		let data = {
			code: 400,
			errorMessage: "数据获取失败"
		};
		ctx.body = data;
	}
});

// 用户注册接口
router.post('/add', async (ctx, next) => {
	// console.log(ctx.request.body);
	let insuranceName = ctx.request.body.insuranceName;
	let upperLimit = ctx.request.body.upperLimit;
	let description = ctx.request.body.description;
	let rate = ctx.request.body.rate;
	let ranges = ctx.request.body.ranges;

	//根据用户id值更新数据
	let a = await query(
		`INSERT INTO insurance_types (insuranceName,upperLimit,description,rate, ranges) 
		VALUES ('${insuranceName}','${upperLimit}','${description}','${rate}', '${ranges}');`
	);
	console.log(a);
	if (a.affectedRows == 1) {
		// 更新成功
		//根据id查询数据库,返回前端
		let newA = await query(`SELECT * FROM insurance_types`);
		// 格式化数据类型
		var newDataString = JSON.stringify(newA);
		var newResult = JSON.parse(newDataString);
		console.log(newResult);
		// 200代表更新成功
		let data = {
			code: 200,
			newResult
		};
		ctx.body = data;
	} else {
		let data = {
			code: 400,
			errorMessage: "新增失败"
		};
		ctx.body = data;
	}
});


//修改产品信息
router.put('/update', async (ctx, next) => {
	// console.log(ctx.request.body);
	let type_id = ctx.request.body.type_id;
	let insuranceName = ctx.request.body.insuranceName;
	let upperLimit = ctx.request.body.upperLimit;
	let description = ctx.request.body.description;
	let rate = ctx.request.body.rate;
	let ranges = ctx.request.body.ranges;
	//更新数据
	let a = await query(
		`UPDATE insurance_types SET insuranceName = '${insuranceName}',upperLimit = '${upperLimit}',description = '${description}',rate = '${rate}', ranges = '${ranges}' WHERE type_id = '${type_id}';`
	);
	console.log(a);

	if (a.affectedRows == 1) {
		// 更新成功

		//根据id查询数据库,返回前端
		let newA = await query(`SELECT * FROM insurance_types`);
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
			errorMessage: "修改失败"
		};
		ctx.body = data;
	}
});




module.exports = router
