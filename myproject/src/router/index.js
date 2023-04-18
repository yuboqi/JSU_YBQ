import Vue from 'vue'
import VueRouter from 'vue-router'
import login from '../components/login.vue'
import home from '../components/home.vue'
import welcome from '../components/welcome.vue'
import users from '../components/user/users.vue'
import splb from '../components/spgl/splb.vue' //1
import myorder from '../components/spgl/myorder.vue' //1
import profile from '../components/profile.vue' //1
import sqsp from '../components/spgl/sqsp.vue' //1
import fsqsp from '../components/spgl/f-spsq.vue' //1
import wdsq from '../components/spgl/wdsq.vue' //1
import fwdsq from '../components/spgl/f-wdsq.vue' //1
import index from '../components/index.vue'
import zyye from '../components/spgl/zyye.vue' //1
import cpyye from '../components/spgl/cpyye.vue' //1
import xsqk from '../components/spgl/xsqk.vue' //1
import wdkh from '../components/spgl/wdkh.vue' //1
import gggl from '../components/spgl/gggl.vue'
import yhfk from '../components/spgl/yhfk.vue'
import register from '@/components/register' //1

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
    path: '/register',
    component: register
  },
  {
    path: '/home',
    component: home,
    redirect: '/welcome',
    children: [
      {path: '/welcome', component: welcome},
      {path: '/yhlb', component: users},
      {path: '/sqsp', component: sqsp},
      {path: '/wdsq', component: wdsq},
      {path: '/zyye', component: zyye},
      {path: '/cpyye', component: cpyye},
      {path: '/xsqk', component: xsqk},
      {path: '/wdkh', component: wdkh},
      {path: '/gggl', component: gggl},
      {path: '/yhfk', component: yhfk},
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
