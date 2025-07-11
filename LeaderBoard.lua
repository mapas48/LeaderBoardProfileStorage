local Leaderboard = {}
--Script para mostrar los datos en el leardBoard
local remoteEventLB = game:GetService("ReplicatedStorage").SyncEvent.UpdLeaderBoard
local ServerScriptService = game:GetService("ServerScriptService")
local template = workspace.leaderboards.template:GetChildren()
local DataManager = require(ServerScriptService.ProfileStore.Datamanager)
local rePosition = require(ServerScriptService.Leaderboard.Resize)
local players = game:GetService("Players")

	Leaderboard.CheckerPlayer = {}
function Leaderboard.UpdLeaderBoard(nameFolder,AvatarFolder,valueFolder)
	local childName = nameFolder:GetChildren()
	local childAvatar = AvatarFolder:GetChildren()
	local childValue = valueFolder:GetChildren()
	
	
	for _,child in childName  do
		child:Destroy()
	end
	for _,child in childAvatar  do
		child:Destroy()
	end
	for _,child in childValue  do
		child:Destroy()
	end
	
end

local function createNewPlayerBoard(nameId,number,index,name,NameFolder,avatarFolder,valueFolder,category)
	local key = tostring(nameId.UserId) .. "_" .. tostring(category)
	
	if Leaderboard.CheckerPlayer[key] then
		return
	end

	Leaderboard.CheckerPlayer[key] = true
	--avatar
	local userId = nameId.UserId
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size420x420
	local content, isReady = game.Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
	--name
	local nameLb = template[1]:Clone()
	nameLb.Parent = NameFolder
	nameLb.Visible = true
	nameLb.Name = "Name"..index
	nameLb.Text = name
	local posN = nameLb.Position
	nameLb.Position = UDim2.new(posN.X.Scale, posN.X.Offset, posN.Y.Scale, rePosition.rePositionName[index])
	--Avatar
	local avatarLb = template[2]:Clone()
	avatarLb.Parent = avatarFolder
	avatarLb.Visible = true
	avatarLb.Image = content
	avatarLb.Name = "avatar"..index
	local posA = avatarLb.Position
	avatarLb.Position = UDim2.new(posA.X.Scale, posA.X.Offset, posA.Y.Scale, rePosition.rePositionImg[index])
	--Value
	local valueLb = template[3]:Clone()
	valueLb.Parent = valueFolder
	valueLb.Visible = true
	valueLb.Name = "value"..index
	valueLb.Text = number
	local posV = valueLb.Position
	valueLb.Position = UDim2.new(posV.X.Scale, posV.X.Offset, posV.Y.Scale, rePosition.rePositionValue[index])
end

--Lograr que el numero se muestre en el formato de M, B, T
local function formatNumber(num)
	if num >= 1e9 then
		return string.format("%.1fB", num / 1e9)
	elseif num >= 1e6 then
		return string.format("%.1fM", num / 1e6)
	elseif num >= 1e3 then
		return string.format("%.1fK", num / 1e3)
	else
		return tostring(num)
	end
end




function Leaderboard.leaderBoard(stats,NameFolder,avatarFolder,valueFolder,category)
	--Reiniciar tabla en cada ejecución
	local LeaderBoardPlayers = {}
	--GetPlayerList function
	for Players,Value in DataManager.profiles do
		LeaderBoardPlayers[Players] = DataManager.profiles[Players].Data[stats]
	end
	-- Convertir a un array de pares clave-valor
	local temp = {}
	for name, number in pairs(LeaderBoardPlayers) do
		table.insert(temp, {name = name, number = number})
	end

	-- Ordenar de mayor a menor por el número
	table.sort(temp, function(a, b)
		return a.number > b.number
	end)
	-- Mostrar resultados ordenados
	for i, data in ipairs(temp) do
		local nameString = tostring(data.name)
		local formattedNumber = formatNumber(data.number)
		createNewPlayerBoard(data.name,formattedNumber,i,nameString,NameFolder,avatarFolder,valueFolder,category)

	end
end


return Leaderboard
