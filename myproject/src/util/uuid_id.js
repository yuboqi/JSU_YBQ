
import { v4 as uuidv4 } from 'uuid';
//生成多位的数字随机数finish
export function randomNum() {
  var num = "";
  for (var i = 0; i < 10; i++) {
    num += Math.floor(Math.random() * 10);
  }
  return num;
}

export function getSession(){
  const session = uuidv4();
  return session;
}