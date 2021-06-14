'use strict'

//! VARS
const lanIP = `${window.location.hostname}:5000`;
const socket = io(`http://${lanIP}`);
let modeStatus = false;

//! UI
const listenToUI = function () {
    //! LIGHT TOGGLE
    document.querySelector('.js-lights').addEventListener('change', function () {
        socket.emit('F2B_lightToggle', this.checked);
    });

    //! MODUS TOGGLE
    document.querySelector('.js-auto').addEventListener('change', function () {
        modeStatus = !modeStatus;

        if (modeStatus) {
            document.querySelector('.controlsRange').style.display = 'block';
            document.querySelector('.controlsRangeLabel').style.display = 'block';
            handleData(`http://${lanIP}/api/v1/mode/${false}`, modeReturn);

        }
        else {
            document.querySelector('.controlsRange').style.display = 'none';
            document.querySelector('.controlsRangeLabel').style.display = 'none';
            handleData(`http://${lanIP}/api/v1/mode/${true}`, modeReturn);
        }
    });

    //! SNELHEID RANGE
    document.querySelector('.controlsRange').addEventListener('input', function () {
        socket.emit('F2B_speedChange', this.value);
    });

    //! NOODSTOP
    document.querySelector('.stop').addEventListener('click', function () {
        socket.emit('F2B_speedChange', 0);
        document.querySelector('.controlsRange').value = 0;
    });

    //! OVERLAY TOGGLE
    document.querySelector('.js-sensor').addEventListener('click', function () {
        document.querySelector('.overlay').style.display = 'block';
        handleData(`http://${lanIP}/api/v1/kalibreer`, modeReturn)
    });

    //! OVERLAY TOGGLE
    document.querySelector('.js-overlay_ok').addEventListener('click', function () {
        document.querySelector('.overlay').style.display = 'none';
    });
};

const modeReturn = function (jsonObject) { }

//! SOCKET IO
const listenToSocket = function () {
    //! LOCATIE UPDATE 1
    socket.on('B2F_LocationUpdate1', (data) => {
        let mask = 0b00000001;
        var hits = []

        for (let x = 1; x <= 8; x++) {
            if (parseInt(data) & mask) {
                for (let y of document.querySelectorAll(`[data-section='${x}']`)) {
                    y.style.stroke = 'red';
                    hits.push(x);
                }
            }
            else {
                document.querySelector(`.trackE[data-section='${x}']`).style.stroke = 'rgb(0, 0, 0)';
                document.querySelector(`.trackO[data-section='${x}']`).style.stroke = 'rgb(128, 128, 128)';
            }

            mask <<= 1
        }
    });

    //! LOCATIE UPDTAE 2
    socket.on('B2F_LocationUpdate2', (data) => {
        let mask = 0b00000001;
        let even = document.querySelectorAll('.trackE');
        let oneven = document.querySelectorAll('.trackO');
        var hits = []

        for (let x = 1; x <= 5; x++) {
            if (parseInt(data) & mask) {
                for (let y of document.querySelectorAll(`[data-section='${8 + x}']`)) {
                    y.style.stroke = 'red'
                }
            }
            else {
                document.querySelector(`.trackE[data-section='${8 + x}']`).style.stroke = 'rgb(0, 0, 0)';
                document.querySelector(`.trackO[data-section='${8 + x}']`).style.stroke = 'rgb(128, 128, 128)';
            }

            mask <<= 1
        }
    });

    //! LICHTSTATUS
    socket.on('B2F_lightStatus', (data) => {
        console.log(data);
        document.querySelector('.js-lights').checked = data;
    });

    //! WAARDE MOTOR
    socket.on('B2F_WaardeMotorUpdate', (data) => {
        console.log(data);
        document.querySelector('.semi-circle--mask').style.transform = `rotate(${data / 64 * 180}deg)`; //MAX = 180
        document.querySelector('.speedPercentage').innerHTML = `${(data / 64 * 5).toPrecision(3)}A`;
    });
};

//! DOM CONTENT LOADED
document.addEventListener('DOMContentLoaded', function () {
    //! EVENT LISTENERS
    listenToUI();
    listenToSocket();

    //! SPEDDOMETER
    document.querySelector('.semi-circle--mask').style.transform = 'rotate(0deg)'; //MAX = 180
    document.querySelector('.controlsRange').style.display = 'none';
    document.querySelector('.controlsRangeLabel').style.display = 'none';

    
    //! LICTSTATUS
    socket.emit('F2B_lightStatus', null);
});

