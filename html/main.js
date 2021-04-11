const newDoorForm = document.getElementById('newDoor');
const sound = document.getElementById('sounds');
const doorlock = document.getElementById('doorlock');

const formInfo = {
    doorname: document.getElementById('doorname'),
    doortype: document.getElementById('doortype'),
    doorlocked: {
        true: document.getElementById('radiot'),
        false: document.getElementById('radiof'),
    },
    job1: document.getElementById('job1'),
    job2: document.getElementById('job2'),
    job3: document.getElementById('job3'),
    job4: document.getElementById('job4'),
    item: document.getElementById('item'),
}

window.addEventListener('message', ({data}) => {
    if(data.type == "newDoorSetup") {
        data.enable ? newDoorForm.style.display = "block" : newDoorForm.style.display = "none";

        // Rest of the logic soon
    }

    if(data.type == "audio") {
        var volume = (data.audio['volume'] / 10 ) * data.sfx
        if (data.distance !== 0) {
            var volume = volume / data.distance
        }
        sound.setAttribute('src', 'sounds/' + data.audio['file']);
        sound.volume = volume;
		sound.play();
    }

    if(data.type == "display") {
        if(data.text == undefined) {
            doorlock.innerHTML = '';
            doorlock.style.display = 'none';
        } else {
            doorlock.style.display = 'block';
            if (data.text == "Locked") {
                doorlock.innerHTML = '<i style="color:orange" class="fas fa-lock"></i>';
            } else if (data.text == "Unlocked") {
                doorlock.innerHTML = '<i style="color:limegreen" class="fas fa-unlock"></i>';
            } else if (data.text == "Locking") {
                doorlock.innerHTML = '<i style="color:orange" class="fas fa-lock"><br>Locking</i>';
            }
    
            let x = (data.x * 100) + '%';
            let y = (data.y * 100) + '%';

            doorlock.style.left = x;
            doorlock.style.top = y;
        }
    }
    
    if(data.type == "hide") {
        doorlock.innerHTML = '';
        doorlock.style.display = 'none';
    }
})

document.addEventListener('keyup', (e) => {
    if(e.key == 'Escape') {
        sendNUICB('close');
    }
});

document.querySelector('#newDoor').addEventListener('submit', (e) => {
    e.preventDefault();
    sendNUICB('newDoor', ({
        channel: Info.channel.value, name: Info.name.value}));
})

function sendNUICB(event, data = {}, cb = () => {}) {
    fetch(`https://${GetParentResourceName()}/${event}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8', },
        body: JSON.stringify(data)
    }).then(resp => resp.json()).then(resp => cb(resp));
}
