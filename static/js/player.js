document.addEventListener("DOMContentLoaded", function () {
  function formatSpeed(speed) {
    return speed + "x";
  }

  function addSpeedControl(player) {
    var controls = player.elements && player.elements.controls;

    if (!controls) {
      throw new Error("Plyr controls were not initialized");
    }

    var speeds = [0.75, 1, 1.25, 1.5, 1.75, 2];
    var speedControl = document.createElement("select");
    speedControl.className =
      "plyr__controls__item plyr__control episode-player-speed";
    speedControl.setAttribute("aria-label", "Playback speed");

    speeds.forEach(function (speed) {
      var option = document.createElement("option");
      option.value = String(speed);
      option.textContent = formatSpeed(speed);
      speedControl.appendChild(option);
    });

    speedControl.value = String(player.speed);
    speedControl.addEventListener("change", function () {
      player.speed = Number(speedControl.value);
    });
    player.on("ratechange", function () {
      speedControl.value = String(player.speed);
    });

    controls.insertBefore(
      speedControl,
      controls.querySelector(".plyr__volume")
    );
  }

  Array.prototype.forEach.call(
    document.querySelectorAll(".js-player"),
    function (player) {
      var plyr = new Plyr(player, {
        controls: [
          "play",
          "rewind",
          "fast-forward",
          "progress",
          "current-time",
          "duration",
          "mute",
          "volume",
        ],
        iconUrl: "/third-party/plyr/3.8.4/plyr.svg",
        seekTime: 15,
      });
      addSpeedControl(plyr);
    }
  );
});
