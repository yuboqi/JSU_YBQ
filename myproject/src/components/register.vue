<template>
  <div class="login">
    <h1>注册</h1>
    <div class="loginBox">
      <!-- signUp区域 -->
      <div class="loginLogo">
        <img src="../assets/img/log.png" alt />
      </div>
      <!-- 注册表单区域 -->
      <el-form
        :model="signinForm"
        :rules="rules"
        ref="signupFormRef"
        label-width="0px"
        class="login_form"
      >
        <!-- 账号 -->
        <el-form-item prop="account">
          <el-input
            v-model="signinForm.account"
            placeholder="请输入账号"
            prefix-icon="el-icon-s-custom"
          ></el-input>
        </el-form-item>
        <!-- 密码 -->
        <el-form-item prop="password">
          <el-input
            v-model="signinForm.password"
            placeholder="请输入密码"
            prefix-icon="el-icon-lock"
            type="password"
          ></el-input>
        </el-form-item>
        <!-- 用户名 -->
        <el-form-item prop="name">
          <el-input
            v-model="signinForm.name"
            placeholder="请输入姓名"
            prefix-icon="el-icon-s-custom"
          ></el-input>
        </el-form-item>

        <!-- 地址 -->
        <el-form-item prop="address">
          <el-input
            v-model="signinForm.address"
            placeholder="请输入地址"
            prefix-icon="el-icon-s-custom"
          ></el-input>
        </el-form-item>

        <!-- 手机号 -->
        <el-form-item prop="phone">
          <el-input
            v-model="signinForm.phone"
            placeholder="请输入手机号"
            prefix-icon="el-icon-s-custom"
          ></el-input>
        </el-form-item>

        <!-- 生日 -->
        <el-form-item prop="birthday">
          <div class="block">
            <el-date-picker style="width:100%" v-model="signinForm.birthday" type="date" placeholder="选择日期" format="yyyy 年 MM 月 dd 日" value-format="yyyyMMdd" size="large" append-to-body:false>
            </el-date-picker>
          </div>
        </el-form-item>

         <!-- 手机号 -->
         <el-form-item prop="email">
          <el-input
            v-model="signinForm.email"
            placeholder="请输入邮箱"
            prefix-icon="el-icon-s-custom"
          ></el-input>
        </el-form-item>

         <!-- 性别 -->
         <el-form-item prop="sex">
          <span>性别：</span>
          <el-radio v-model="signinForm.sex" label="男">男</el-radio>
          <el-radio v-model="signinForm.sex" label="女">女</el-radio>
        </el-form-item>

        

        <!-- 登录注册按钮 -->
        <el-form-item class="btns">
          <el-button type="primary" @click="userSignUp">注册</el-button>,
          <el-button type="primary" @click="toSignin">登录</el-button>,
          <el-button type="info" @click="reset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import {randomNum} from '@/util/uuid_id.js'
export default {
  name: 'register',
  data() {
    return {
      //登录表单数据绑定对象
      signinForm: {
        id: '',
        account: '',
        password: '',
        name: '',
        address: '',
        phone: '',
        birthday: '',
        email: '',
        sex: '',
      },
      value1: '',
      // 登录表单数据验证规则对象
      rules: {
        account: [
          { required: true, message: '请输入账号', trigger: 'blur' },
          {
            min: 3,
            max: 10,
            message: '长度在 3 到 10 个字符',
            trigger: 'blur',
          },
        ],
        name: [
          { required: true, message: '请输入姓名', trigger: 'blur' },
          {
            min: 3,
            max: 10,
            message: '长度在 3 到 10 个字符',
            trigger: 'blur',
          },
        ],
        address: [
          { required: true, message: '请输入地址', trigger: 'blur' },
          {
            min: 1,
            max: 30,
            message: '长度在 1 到 30 个字符',
            trigger: 'blur',
          },
        ],
        password: [
          { required: true, message: '请输入合法的密码', trigger: 'blur' },
        ],
        //手机验证
        phone: [
          { required: true, message: '请输入手机号', trigger: 'blur' },
          {
            pattern: /^1[3456789]\d{9}$/,
            message: '请输入正确的手机号',
            trigger: 'blur',
          },
        ],
        //邮箱验证1
        email: [
          { required: true, message: '请输入邮箱', trigger: 'blur' },
          {
            pattern: /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+$/,
            message: '请输入正确的邮箱',
            trigger: 'blur',
          },
        ],
        //性别不为空
        sex:[
          { required: true, message: '请选择性别', trigger: 'blur' },
        ]
      },
    }
  },
  methods: {
    // 点击重置按钮重置表单
    reset() {
      this.$refs.signupFormRef.resetFields()
    },
    rootLogin() {},
    userSignUp() {
      console.log(this.signinForm);
      this.$refs.signupFormRef.validate(async (valid) => {
         // 如果校验失败就返回
         if (!valid) return
         try {
          this.signinForm.id = randomNum()
          const res = await this.$API.signupAPI(this.signinForm)
          if(res.data.code == 200){
            this.$message({
              type: 'success',
              message: '注册成功'
            })
            this.$router.push('/login')
          }else{
            this.$message({
              type: 'error',
              message: '注册失败'
            })
          }
         } catch (error) {
          console.log(error);
          alert(error.message)
         }
      })
    },
    toSignin(){
      this.$router.push('/login')
    }
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
html,
body {
  width: 100%;
  height: 100%;
}
.login {
  width: 100%;
  height: 100%;
  background: url('../assets/img/10.jpg') center center no-repeat;
  background-size: 100% 100%;
  position: relative;
  overflow: hidden;
}
.login h1 {
  text-align: center;
  color: white;
  font-size: 42px;
  margin-top: 45px;
  letter-spacing: 0.2em;
}
.loginBox {
  width: 500px;
  height: 630px;
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.4);
  position: absolute;
  top: 50%;
  left: 50%;
  margin-left: -250px;
  margin-top: -150px;
}
.loginLogo {
  width: 130px;
  height: 130px;
  background: rgba(255, 255, 255, 0.4);
  border-radius: 50%;
  position: absolute;
  top: 0%;
  left: 50%;
  margin-left: -65px;
  margin-top: -65px;
}
.loginLogo img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
}
.btns {
  display: flex;
  justify-content: flex-end;
}
.login_form {
  position: absolute;
  bottom: 0px;
  width: 80%;
  margin-left: 10%;
}
</style>
