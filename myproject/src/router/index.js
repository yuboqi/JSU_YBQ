import Vue from 'vue'
import VueRouter from 'vue-router'
import login from '../components/login.vue'
import home from '../components/home.vue'
import welcome from '../components/welcome.vue'
import users from '../components/user/users.vue'
import jslb from '../components/user/jslb.vue'
import qxlb from '../components/user/qxlb.vue'
import xgmm from '../components/grzx/xgmm.vue'
import newly from '../components/lygl/newly.vue'
import sslb from '../components/ssgl/sslb.vue'
import sswhjs from '../components/ssgl/sswhjs.vue'
import xslb from '../components/xsgl/xslb.vue'
import shbx from '../components/hqfw/shbx.vue'
import bxlb from '../components/hqfw/bxlb.vue'
import sspf from '../components/tjzx/sspf.vue'
import bxtj from '../components/tjzx/bxtj.vue'
import lgdf from '../components/tjzx/lgdf.vue'
import splb from '../components/spgl/splb.vue'
import myorder from '../components/spgl/myorder.vue'
import profile from '../components/profile.vue' //1
import sqsp from '../components/spgl/sqsp.vue'
import fsqsp from '../components/spgl/f-spsq.vue'
import wdsq from '../components/spgl/wdsq.vue'
import fwdsq from '../components/spgl/f-wdsq.vue'
import index from '../components/index.vue'
import zyye from '../components/spgl/zyye.vue'
import cpyye from '../components/spgl/cpyye.vue'
import xsqk from '../components/spgl/xsqk.vue'
import wdkh from '../components/spgl/wdkh.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    component: index,
    redirect: '/login',
    children: [
      {path: '/bxcp', component: splb},
      {path: '/wddd', component: myorder},
      {path: '/profile', component: profile},
      {path: '/f-sqsp', component: fsqsp},
      {path: '/f-wdsq', component: fwdsq},
    ]
  },
  {
    path: '/login',
    component: login
  },
  {
    path: '/home',
    component: home,
    redirect: '/welcome',
    children: [
      {path: '/welcome', component: welcome},
      {path: '/yhlb', component: users},
      {path: '/xgmm', component: xgmm},
      {path: '/newly', component: newly},
      {path: '/sslb', component: sslb},
      {path: '/sswhjs', component: sswhjs},
      {path: '/xslb', component: xslb},
      {path: '/shbx', component: shbx},
      {path: '/sspf', component: sspf},
      {path: '/bxtj', component: bxtj},
      {path: '/lgdf', component: lgdf},
      {path: '/jslb', component: jslb},
      {path: '/qxlb', component: qxlb},
      {path: '/bxlb', component: bxlb},
      {path: '/sqsp', component: sqsp},
      {path: '/wdsq', component: wdsq},
      {path: '/zyye', component: zyye},
      {path: '/cpyye', component: cpyye},
      {path: '/xsqk', component: xsqk},
      {path: '/wdkh', component: wdkh},
    ]
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

// 挂载路由导航守卫
router.beforeEach((to, from, next) => {
  if (to.path === '/login') return next();
  // 获取token
  // const tokenStr = window.sessionStorage.getItem('token');
  // if(!tokenStr) return next('/login');
  next();
})

export default router
