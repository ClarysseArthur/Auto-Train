var chart;

const initChart = function (jsonObject) {
    console.log(jsonObject);

    const data = [];
    const cat = [];

    for (let x of jsonObject) {
        data.push(x.Vertraging);
        cat.push(formatDate(x.Starttijd, 1));
    }

    console.log(data);
    console.log(cat);

    var options = {
        series: [{
            name: "Vertraging",
            data: data,
        }],
        fill: {
            colors: ['#1C6180']
        },
        chart: {
            height: 350,
            type: 'line',
            zoom: {
                enabled: true
            }
        },
        dataLabels: {
            enabled: false
        },
        stroke: {
            curve: 'smooth'
        },
        title: {
            text: 'Alle vertragingen',
            align: 'center'
        },
        grid: {
            row: {
                colors: ['white', 'transparent'], // takes an array which will be repeated on columns
                opacity: 0.5
            },
        },
        xaxis: {
            categories: cat,
        },
    };

    chart = new ApexCharts(document.querySelector(`.chart`), options);
    chart.render()
}

const showChartData = function (jsonObject) {
    console.log(jsonObject);

    const data = [];
    const cat = [];

    for (let x of jsonObject) {
        data.push(x.Vertraging);
        cat.push(formatDate(x.Starttijd, 1));
    }

    console.log(data);
    console.log(cat);

    chart.updateOptions({
        series: [{
            name: "Vertraging",
            data: data,
        }],
        fill: {
            colors: ['#1C6180', '#1C6180', '#1C6180']
        },
        chart: {
            height: 350,
            type: 'line',
            zoom: {
                enabled: true
            }
        },
        dataLabels: {
            enabled: false
        },
        stroke: {
            curve: 'smooth'
        },
        title: {
            text: 'Alle vertragingen',
            align: 'center'
        },
        grid: {
            row: {
                colors: ['white', 'transparent'], // takes an array which will be repeated on columns
                opacity: 0.5
            },
        },
        xaxis: {
            categories: cat,
        }
    })
}