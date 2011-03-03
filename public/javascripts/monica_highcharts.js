var chart;

$(document).ready(function() {
  chart = new Highcharts.Chart({
    chart: {
      renderTo: 'orders_chart',
      defaultSeriesType: 'column',
      margin: [ 50, 50, 100, 80]
    },
    title: {
      text: 'Статистика проблем по месяцам'
    },
    xAxis: {
      categories: [
        'Январь',
        'Февраль',
        'Март',
        'Апрель',
        'Май',
        'Июнь',
        'Июль',
        'Август',
        'Сентябрь',
        'Октябрь',
        'Ноябрь',
        'Декабрь'
      ],
      labels: {
        rotation: -45,
        align: 'right',
        style: {
          font: 'normal 13px Verdana, sans-serif'
        }
      }
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Масштаб (1:1)'
      }
    },
    legend: {
      enabled: false
    },
    tooltip: {
      formatter: function() {
        return '<b>' + this.x + '</b><br/>' +
                'За текущий месяц : ' + Highcharts.numberFormat(this.y, 0) +
                ' проблем';
      }
    },
    series: [
      {
        name: 'Population',
        data: [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec],
        dataLabels: {
          enabled: true,
          rotation: -90,
          color: '#FFFFFF',
          align: 'right',
          x: -3,
          y: 10,
          formatter: function() {
            return this.y;
          },
          style: {
            font: 'normal 13px Verdana, sans-serif'
          }
        }
      }
    ]
  });
});
