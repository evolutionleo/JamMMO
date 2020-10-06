// FREE, WAITING, PLAY
module.exports = function() {
    var lobby = this;
    this.status = "FREE";
    this.players = [];
    this.map = "";

    this.play = function() {
        this.status = "PLAY";
        // if(lobby.status === "PLAY") {
            this.players.forEach((_c, idx) => {
                var col = (idx == 0) ? "pink" : "cyan";

                var map = this.map;
                var pack = [
                    [8, cmd["FIND_GAME"]],
                    col,
                    map
                ]
                _c.socket.write(packet.build(pack));
                _c.team = col;
            })
        // }
    }

    this.end = function() {
        this.players.forEach(function(p) {
            p.quitLobby();
        })
        this.status = "FREE";
    }

    this.updateStatus = function() {
        switch(this.players.length) {
            case 0:
                this.status = "FREE";
                break;
            case 1:
                this.status = "WAITING";
                break;
            case 2:
                this.status = "PLAY";
                this.play();
                break;
        }

        // console.log(this);
    }
}