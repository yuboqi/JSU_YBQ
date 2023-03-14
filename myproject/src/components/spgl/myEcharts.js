import * as echarts from 'echarts';

function createEcharts(el, title, data) {
  const chartDom = document.getElementById(el);
  const myChart = echarts.init(chartDom);
  const option = {
    title: {
      text: title,
      left: 'center'
    },
    tooltip: {
      trigger: 'item'
    },
    legend: {
      orient: 'vertical',
      left: 'left'
    },
    series: [
      {
        name: 'Access From',
        type: 'pie',
        radius: '50%',
        data: data,
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
          }
        }
      }
    ]
  };
  return option && myChart.setOption(option);
}

export default createEcharts;
