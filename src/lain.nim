import std/json
from std/terminal import eraseScreen, setCursorPos, getch
from std/osproc import execCmd
from std/os import fileExists
from std/httpclient import downloadFile, newHttpClient

let
  layers: JsonNode = parseJson(readFile("layers/layers.json"))

proc getLayer(layerNumber: int): JsonNode =
  if layers.kind == JObject:
    if layers.hasKey($layerNumber):
      return layers[$layerNumber]
    else:
      echo "lain: the layer you desired does not exist"
  else:
    echo "lain: details file is corrupted or deleted, please reinstall lain"
  

proc lain(layers: seq[int] =  @[], download: bool = false, watch: bool = true): int =
  # const source: string = ""
  let ly: int = layers[0]
  let client = newHttpClient()

  if ly > 13 or ly < 1:
    echo "lain: episode(s) do not exist"
  else:
    let layer = getLayer(ly)
    eraseScreen()
    setCursorPos(0, 0)

    let
      title = layer["title"].getStr()
      directory = layer["director"].getStr()
      date = layer["date"].getStr()
      description = layer["description"].getStr()
      link = layer["link"].getStr()

    echo "lain: v0.1.0\n-----------------------------"
    echo "title: " & title
    echo "director: " & directory
    echo "date: " & date
    echo "description: " & description & "\n-----------------------------"
    
    if download:
      if not fileExists(title & ".mp4"):
        echo "lain: downloading layer"
        client.downloadFile(link, "layers/" & title & ".mp4")
      else:
        echo "lain: layer already downloaded"

    if watch and not download:
      discard execCmd("mpv --title=lain --profile=fast " & link)

    elif watch and download:
      discard execCmd("mpv --title=lain --profile=fast " & "layers/" & title & ".mp4")

    elif watch == false:
      echo ""

when isMainModule:
  import cligen; dispatch lain, help = {
                                        "layers": "which layer(s) to watch/download (1-13)",
                                        "download": "download the layer or not",
                                        "watch": "watch the layer or not, if download is set to true uses local file"
                                       }