// Create your global variables below:
var tracklist =
	["Let It Happen",
		"Nangs",
		"The Moment",
		"Yes I'm Changing",
		"Eventually",
		"Gossip",
		"The Less I Know The Better",
		"Past Life",
		"Disciples",
		"'Cause I'm A Man"];
var volLevels = [];
var levels = ["vl0", "vl1", "vl2", "vl3", "vl4", "vl5"]
var interv =
	setInterval(function () {
		// updates range = WORKS!
		if (parseInt(document.getElementById("myRange").value) == 180) {
			// if interval hits 180, reset range to 0 = WORKS!
			document.getElementById("myRange").value = 0;
			// if interval hits 180, reset time to 0 = WORKS!
			document.getElementById("time-elapsed").innerHTML = secondsToMs(0);
			// if interval hits 180, call NextSong() = WORKS!
			nextSong();

		} else {
			// updates range = WORKS!
			document.getElementById("myRange").value =
				parseInt(document.getElementById("myRange").value) + 1;
			// updates time = WORKS!
			document.getElementById("time-elapsed").innerHTML =
				secondsToMs(parseInt(document.getElementById("myRange").value));
		}
	}, 1000);

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

function init() {
	// fill array w/ referenes to vol level,
	for (v = 0; v < 6; v++) {
		volLevels.push(document.getElementById(levels[v]))

		// fill first 3 volume bars w/ purple
		// NOTE: GETTING SERIOUS ISSUES WITH CHANGING THE COLOR TO A HEX.
		// KEEP STRINGS (purple/white)!!
		if (v < 3) {
			volLevels[v].style.backgroundColor = "darkmagenta";
		} else {
			volLevels[v].style.backgroundColor = "white";
		}
	}
}

function volUp() {
	// if current last volLevel is white, change it to purple
	for (i = 0; i < 6; i++) {
		if (volLevels[i].style.backgroundColor == "white") {
			volLevels[i].style.backgroundColor = "darkmagenta";
			break;
		}
	}
}

function volDown() {
	// if current last volLevel is purple, change it to white
	for (i = 5; i > -1; i--) {
		if (volLevels[i].style.backgroundColor == "darkmagenta") {
			volLevels[i].style.backgroundColor = "white";
			break;
		}
	}
}

function switchPlay() {
	// switch icons
	// set interval & update range value = WORKS!
	if (document.getElementById("play-pause").innerHTML == "play_arrow") {
		document.getElementById("play-pause").innerHTML = "pause";
		setInterval(interval, 1000);
	}
	else if (document.getElementById("play-pause").innerHTML == "pause") {
		document.getElementById("play-pause").innerHTML = "play_arrow";
		// stop playing if pause is hit
		clearInterval(interv);
	}
}

function nextSong() {
	// next song in var tracklist
	// loops back to tracklist[0] when tracklist[9] is reached
	current = document.getElementById("player-song-name").innerHTML
	for (i = 0; i < 10; i++) {
		if (current == tracklist[i]) {
			if (i != tracklist.length - 1) {
				song = tracklist[i + 1];
			} else {
				song = tracklist[0];
			}
			document.getElementById("player-song-name").innerHTML = song;
			// changes range value 0
			document.getElementById("myRange").value = 0;
		}
	}
}

function prevSong() {
	// last song in var tracklist
	// loops back to tracklist[9] when tracklist[0] is reached
	current = document.getElementById("player-song-name").innerHTML
	for (i = 9; i > -1; i--) {
		if (current == tracklist[i]) {
			if (i != 0) {
				song = tracklist[i - 1];
			} else {
				song = tracklist[tracklist.length - 1];
			}
			document.getElementById("player-song-name").innerHTML = song;
			// changes range value 0
			document.getElementById("myRange").value = 0;
		}
	}
}

function secondsToMs(d) {
	d = Number(d);

	var min = Math.floor(d / 60);
	var sec = Math.floor(d % 60);

	return `0${min}`.slice(-1) + ":" + `00${sec}`.slice(-2);
}

/** Same as var interv, but only the function part, used above in switchPlay() */
function interval() {
	// updates range = WORKS!
	if (parseInt(document.getElementById("myRange").value) == 180) {
		// if interval hits 180, reset range to 0 = WORKS!
		document.getElementById("myRange").value = 0;
		// if interval hits 180, reset time to 0 = WORKS!
		document.getElementById("time-elapsed").innerHTML = secondsToMs(0);
		// if interval hits 180, call NextSong() = WORKS!
		nextSong();

	} else {
		// updates range = WORKS!
		document.getElementById("myRange").value =
			parseInt(document.getElementById("myRange").value) + 1;
		// updates time = WORKS!
		document.getElementById("time-elapsed").innerHTML =
			secondsToMs(parseInt(document.getElementById("myRange").value));
	}
}

init();