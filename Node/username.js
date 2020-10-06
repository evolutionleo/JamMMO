// generate a name
module.exports = getUsername = function() {
    sessionid += 1;
    return "Guest#" + sessionid;
}