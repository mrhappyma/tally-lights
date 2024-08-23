#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <config.h>
#include <ArduinoWebsockets.h>
#include <ArduinoJson.h>

#define RED 5
#define GREEN 4
#define BLUE 13

void color(int r, int g, int b)
{
  analogWrite(RED, r);
  analogWrite(GREEN, g);
  analogWrite(BLUE, b);
}

boolean initWifi()
{
  WiFi.mode(WIFI_STA);
  WiFi.begin(SSID, PASSWORD);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(WiFi.status());
  }
  return true;
}

boolean shouldWake()
{
  // get /tallies/up, true if id is in the response
  WiFiClient client;
  HTTPClient http;

  http.begin(client, HUB + "/tallies/on");
  int httpCode = http.GET();
  if (httpCode == 200)
  {
    String payload = http.getString();
    Serial.println(payload);
    return payload.indexOf(String(ID)) > 0;
  }
  else
  {
    Serial.println("error getting tallies");
    Serial.println(httpCode);
    return false;
  }
}

using namespace websockets;
WebsocketsClient socket;

void handleMessage(WebsocketsMessage message)
{
  Serial.println("got message");
  Serial.println(message.data());

  JsonDocument doc;
  deserializeJson(doc, message.data());

  JsonDocument identifier;
  deserializeJson(identifier, doc["identifier"]);

  if (identifier["channel"] == "TallyStatusChannel")
  {
    if (doc["message"] == false)
    {
      color(0, 0, 0);
      socket.end();
      ESP.deepSleep(WAKE_CHECK_INTERVAL);
    }
  }

  if (identifier["channel"] == "TallyColorChannel")
  {
    String colorStr = doc["message"];
    int commaIndex = colorStr.indexOf(',');
    int r = colorStr.substring(0, commaIndex).toInt();
    int g = colorStr.substring(commaIndex + 1, commaIndex + 1 + commaIndex).toInt();
    int b = colorStr.substring(commaIndex + 1 + commaIndex + 1).toInt();
    color(r, g, b);
  }
}

void setup()
{
  Serial.begin(9600);

  initWifi();
  if (!shouldWake())
  {
    Serial.println("not my turn to wake up");
    ESP.deepSleep(WAKE_CHECK_INTERVAL);
  }
  else
  {
    Serial.println("it's my turn to wake up");
  }

  pinMode(RED, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(BLUE, OUTPUT);

  color(15, 15, 15);

  bool connected = socket.connect(HOST, PORT, "/cable");
  if (!connected)
  {
    color(15, 0, 0);
    Serial.println("failed to connect to websocket");
    delay(3000);
    ESP.deepSleep(WAKE_CHECK_INTERVAL);
  }

  socket.send("{\"command\":\"subscribe\",\"identifier\":\"{\\\"channel\\\":\\\"TallyStatusChannel\\\", \\\"tally_id\\\":" + String(ID) + "}\"}");
  socket.send("{\"command\":\"subscribe\",\"identifier\":\"{\\\"channel\\\":\\\"TallyColorChannel\\\", \\\"tally_id\\\":" + String(ID) + "}\"}");

  socket.onMessage([&](WebsocketsMessage message)
                   { handleMessage(message); });
}

void loop()
{
  // color(15, 15, 15);
  if (socket.available())
  {
    socket.poll();
  }
}