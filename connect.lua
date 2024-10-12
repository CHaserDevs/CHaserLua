-- CHaserクライアント通信プログラム

-- ソケット通信ライブラリの読み込み
socket = require("socket")

-- クラス定義
CHaserConnect = {}
CHaserConnect.__index = CHaserConnect
CHaserConnect.LastMovements = {}

-- コンストラクタ
function CHaserConnect.new(name)

  -- インスタンス定義
  local self = setmetatable({}, CHaserConnect)

  -- 接続
  print("接続先IPアドレスを入力してください")
  local host = io.read()
  print("接続先ポート番号を入力してください")
  local port = io.read()

  -- 接続エラー処理
  self.socket, err = socket.tcp()
  if not self.socket then
    print("ソケットの作成に失敗: " .. err)
    return nil
  end

  -- 接続タイムアウト設定
  self.socket:settimeout(5)
  local success, err = self.socket:connect(host, tonumber(port))
  if not success then
    print('"' .. self.name .. '"はサーバに接続出来ませんでした')
    print("サーバが起動しているかどうか or ポート番号、IPアドレスを確認してください")
  else
    print('"' .. self.name .. '"はサーバに接続しました')
    self.socket:send(self.name .. "\n")
  end

  -- 接続成功時の処理
  return self
end

-- getReady
function CHaserConnect:getReady()
  print('"' .. self.name .. '"はgetReadyをサーバに送信')
  self.socket:send("gr\r")  -- grをサーバに送信
  local msg, err = self.socket:receive()
  if not msg then -- エラー処理
    print('"' .. self.name .. '"はgetReadyをサーバに送信できませんでした')
    return
  end
  return self:parseInt(msg) -- マップ情報を返す
end

-- 標準機能
-- walk 
function CHaserConnect:walk(dir)
  if dir == "Up" then
    return self:sendCommand("wu")
  elseif dir == "Down" then
    return self:sendCommand("wd")
  elseif dir == "Left" then
    return self:sendCommand("wl")
  elseif dir == "Right" then
    return self:sendCommand("wr")
  else
    error("Invalid direction")
  end
end

-- look
function CHaserConnect:look(dir)
  if dir == "Up" then
    return self:sendCommand("lu")
  elseif dir == "Down" then
    return self:sendCommand("ld")
  elseif dir == "Left" then
    return self:sendCommand("ll")
  elseif dir == "Right" then
    return self:sendCommand("lr")
  else
    error("Invalid direction")
  end
end

-- search
function CHaserConnect:search(dir)
  if dir == "Up" then
    return self:sendCommand("su")
  elseif dir == "Down" then
    return self:sendCommand("sd")
  elseif dir == "Left" then
    return self:sendCommand("sl")
  elseif dir == "Right" then
    return self:sendCommand("sr")
  else
    error("Invalid direction")
  end
end

-- put
function CHaserConnect:put(dir)
  if dir == "Up" then
    return self:sendCommand("pu")
  elseif dir == "Down" then
    return self:sendCommand("pd")
  elseif dir == "Left" then
    return self:sendCommand("pl")
  elseif dir == "Right" then
    return self:sendCommand("pr")
  else
    error("Invalid direction")
  end
end

-- AbleToMove
function CHaserConnect:AbleToMove(direction, grData)
  local directionMap = { Up = 2, Down = 8, Left = 4, Right = 6 }
  if directionMap[direction] then
    return grData[directionMap[direction]] ~= 0
  else
    return false
  end
end

function CHaserConnect:LastMove()
  -- insert last move to LastMovements
  local lastMove = CHaserConnect.LastMovements[#CHaserConnect.LastMovements]
  local lastMoveType = lastMove:sub(1, 1)
  local lastMoveDirection = lastMove:sub(2, 2)

  if lastMoveType == "w" then
    if lastMoveDirection == "u" then
      return "Down"
    elseif lastMoveDirection == "d" then
      return "Up"
    elseif lastMoveDirection == "l" then
      return "Right"
    elseif lastMoveDirection == "r" then
      return "Left"
    else
      return lastMoveType
    end
  else
    return lastMoveType
  end
end

-- RandomDirection
function CHaserConnect:RandomDirection()
  local directions = {"Up", "Down", "Left", "Right"}
  local lastMove = self:LastMove()
  
  -- Create a new table for valid directions
  local validDirections = {}
  for _, direction in ipairs(directions) do
    if direction ~= lastMove then
      table.insert(validDirections, direction)
    end
  end

  -- Return a random direction from the valid ones
  return validDirections[math.random(#validDirections)]
end

-- コマンド送信関数
function CHaserConnect:sendCommand(command)
  print('"' .. self.name .. '"は' .. command .. 'をサーバに送信')
  self.socket:send(command .. "\r\n") -- コマンドをサーバに送信
  -- insert last command to LastMovements
  table.insert(CHaserConnect.LastMovements, command)
  local msg, err = self.socket:receive()
  if not msg then -- エラー処理
    print('"' .. self.name .. '"は' .. command .. 'をサーバに送信できませんでした')
    return
  end
  self.socket:send("#\r\n") -- 終了コマンドをサーバに送信
  return self:parseInt(msg) -- マップ情報を返す
end

function CHaserConnect:parseInt(str)
  local results = {}
  for i = 1, 10 do
    results[i] = tonumber(str:sub(i, i)) or 9
    io.write(results[i] .. " ")
  end
  io.write("\n")
  return results 
end

function CHaserConnect:close()
  self.socket:close()
end

-- テスト用
if arg[0] == "CHaserConnect.lua" then
  local agent = CHaserConnect.new("test")

  local values = {}

    -- getReadyとsearchUPを繰り返すのみ
  while true do
    values = agent:getReady()
    if values[1] == 0 then
      break
    end

    values = agent:search("Up")

    if values[1] == 0 then
      break
    end
  end
  target:close()
end
