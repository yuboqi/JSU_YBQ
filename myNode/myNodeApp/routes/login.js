// 用户登录接口ybq
const router = require('koa-router')()
//引入MySQL数据库
const query = require('./MYSQL');
router.prefix('/login');

router.get('/', function (ctx, next) {
  ctx.body = '这是用户登录页面'
});

//登录页面，查询数据库是否有该用户并返回前端请求的数据
router.post('/', async (ctx, next) => {
    console.log(ctx.request.body);
    let cust_account = ctx.request.body.name;
    let cust_password = ctx.request.body.password;
    //根据用户名和密码查询数据库
    let a = await query(`SELECT *
                         FROM customer
                         where cust_account = '${cust_account}'
                           and cust_password = '${cust_password}'`);
    // console.log(a);
    // console.log(a.length);
    // 格式化数据类型
    var dataString = JSON.stringify(a);
    var result = JSON.parse(dataString);
    console.log(result);

    var data;
    if (result.length > 0) {
      const menus0 = [
        {
          id: 22,
          authName: "营业额",
          path: "yye",
          children: [{
            id: "22.1",
            authName: "总营业额",
            path: "zyye",
            children: []
          }, {
            id: 22,
            authName: "产品营业额",
            path: "cpyye",
            children: []
          }]
        },
        {
          id: 66,
          authName: "索赔管理",
          path: "spgl",
          children: [{
            id: "66.3",
            authName: "申请索赔",
            path: "sqsp",
            children: []
          },
            {
              id: "66.4",
              authName: "我的索赔",
              path: "wdsq",
              children: []
            }]
        },
        {
          id: 4,
          authName: "用户权限管理",
          path: "yhqxgl",
          children: [{
            id: "4.1",
            authName: "用户权限列表",
            path: "yhlb",
            children: []
          }
          ]
        },
        {
          id: 33,
          authName: "产品统计",
          path: "cptj",
          children: [{
            id: "33.1",
            authName: "销售情况",
            path: "xsqk",
            children: []
          }]
        },
        {
          id: 44,
          authName: "客户管理",
          path: "wdkh",
          children: [{
            id: "44.1",
            authName: "我的客户",
            path: "wdkh",
            children: []
          }
        ]
        },
      ]
      const menus1 = [
        {
          id: 66,
          authName: "索赔管理",
          path: "spgl",
          children: [{
            id: "66.3",
            authName: "申请索赔",
            path: "sqsp",
            children: []
          },
            {
              id: "66.4",
              authName: "我的索赔",
              path: "wdsq",
              children: []
            }]
        },
        {
          id: 33,
          authName: "产品统计",
          path: "cptj",
          children: [{
            id: "33.1",
            authName: "销售情况",
            path: "xsqk",
            children: []
          }]
        },
        {
          id: 44,
          authName: "客户管理",
          path: "wdkh",
          children: [{
            id: "44.1",
            authName: "我的客户",
            path: "wdkh",
            children: []
          }
        ]
        },
      ]
      let data = {
        code: 200,
        data: result,
        route: result[0].role == 0 ? menus0 : result[0].role == 1 ? menus1 : []
      
      }

      ctx.body = data;
    } else {
      let data = {
        code: 400,
        data: '用户名或密码错误'
      };
      ctx.body = data;
    }
  }
)
;
// 修改用户信息
router.post('/update', async (ctx, next) => {
  console.log(ctx.request.body);
  let cust_id = ctx.request.body.cust_id;
  let cust_password = ctx.request.body.cust_password;
  let cust_address = ctx.request.body.cust_address;
  let cust_phone = ctx.request.body.cust_phone;
  let cust_birthday = ctx.request.body.cust_birthday;
  let cust_email = ctx.request.body.cust_email;
  let cust_sex = ctx.request.body.cust_sex;
  //根据用户id值更新数据
  let a = await query(
    `update customer
     set cust_password = '${cust_password}',
         cust_address  ='${cust_address}',
         cust_phone    = '${cust_phone}',
         cust_birthday = '${cust_birthday}',
         cust_email    = '${cust_email}',
         cust_sex      = '${cust_sex}'
     where cust_id = '${cust_id}'`
  );
  console.log(a);

  if (a.changedRows == 1) {
    // 更新成功
    //根据id查询数据库,返回前端
    let newA = await query(`SELECT *
                            FROM customer
                            WHERE cust_id = '${cust_id}'`);
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
      errorMessage: '更新失败'
    };
    ctx.body = data;
  }
});


module.exports = router
