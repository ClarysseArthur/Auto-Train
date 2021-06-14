const lanIP = `${window.location.hostname}:5000`;
let dateDropdown, tijdDropdown;

const changeGraph = function () {
    let datum = document.querySelector(`.js-dropdown__dates`);
    let tijd = document.querySelector(`.js-dropdown__tijd`);

    console.log(datum.value);
    console.log(tijd.value);

    if (datum.value == 'all' && tijd.value == 'all') {
        handleData(`http://${lanIP}/api/v1/get_all/0`, function (jsonObject) {
            showChartData(jsonObject);
        });
    }
    else if (datum.value == 'all') {
        handleData(`http://${lanIP}/api/v1/get_all/${tijd.value}`, function (jsonObject) {
            // handleData(`http://${lanIP}/api/v1/get_vertraging/0`, showAllDelays);
            clearAllDelays();
            handleData(`http://${lanIP}/api/v1/get_vertraging/0`, showAllDelays);
            showChartData(jsonObject);
        });
    }
    else if (tijd.value == 'all') {
        handleData(`http://${lanIP}/api/v1/sort_date/${datum.value}`, function (jsonObject) {
            clearAllDelays();
            handleData(`http://${lanIP}/api/v1/get_vertraging_date/${datum.value}`, showAllDelays);
            showChartData(jsonObject);
        });
    }
    else {
        handleData(`http://${lanIP}/api/v1/get_date_vertraging/${datum.value}/${tijd.value}`, showChartData)
    }
}

const addCallback = function () {
    for (let x of dateDropdown) {
        x.addEventListener('change', changeGraph);
    }

    for (let x of tijdDropdown) {
        x.addEventListener('change', changeGraph);
    }
}

const formatDate = function (data, format) {
    if (format == 1) {
        let datum = new Date(data);

        let dag = datum.getDate();
        let maand = datum.getMonth() + 1;
        let jaar = datum.getFullYear();
        let uur = datum.getHours();
        let minuut = datum.getMinutes();

        return dag + "/" + maand + "/" + jaar + " " + uur + ":" + minuut;
    }
    else if (format == 2) {
        let datum = new Date(data);

        let dag = datum.getDate();
        let maand = datum.getMonth() + 1;
        let jaar = datum.getFullYear();

        return dag + "/" + maand + "/" + jaar;
    }
    else if (format == 3) {
        let datum = new Date(data);

        let dag = datum.getDate();
        let maand = datum.getMonth() + 1;
        let jaar = datum.getFullYear();

        return jaar + "-" + maand + "-" + dag;
    }
}

//! SHOW DATES
const showDates = function (jsonObject) {
    let html = '';

    for (let x of jsonObject) {
        html += `<option value="${formatDate(x.Datum, 3)}">${formatDate(x.Datum, 2)}</option>`;
    }

    for (let x of dateDropdown) {
        x.innerHTML += html;
    }
}

//! SHOW DELEYAS
const showAllDelays = function (jsonObject) {
    let html = '';

    for (let x of jsonObject) {
        if (x.Vertraging == 0) {

        }
        else {
            html += `<option value="${x.Vertraging}">${x.Vertraging} seconden</option>`;
        }
    }

    for (let x of tijdDropdown) {
        x.innerHTML += html;
    }
}

const clearAllDelays = function () {
    document.querySelector('.js-dropdown__tijd').innerHTML = "<option value='all'>Met alle vertragingen</option>";
}

document.addEventListener('DOMContentLoaded', function () {
    dateDropdown = document.querySelectorAll('.js-dropdown__dates');
    tijdDropdown = document.querySelectorAll('.js-dropdown__tijd');

    addCallback();

    handleData(`http://${lanIP}/api/v1/get_dates`, showDates);
    handleData(`http://${lanIP}/api/v1/get_vertraging/0`, showAllDelays);

    handleData(`http://${lanIP}/api/v1/get_all/0`, initChart);
})