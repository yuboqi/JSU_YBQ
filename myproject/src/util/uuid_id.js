//生成多位的数字随机数
export function randomNum() {
  var num = "";
  for (var i = 0; i < 10; i++) {
    num += Math.floor(Math.random() * 10);
  }
  return num;
}