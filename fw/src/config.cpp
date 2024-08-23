#include <WString.h>
#include <config.h>

const int ID = 1;

const String SSID = "Unicorn Minion Trucks";
const String PASSWORD = "Elmo5ever";
const char *HOST = "192.168.1.228";
const int PORT = 3000;

const uint64_t WAKE_CHECK_INTERVAL = 30e6;

const String HUB = "http://" + String(HOST) + ":" + String(PORT);