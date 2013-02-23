bank.Players = {}

function bank.Create(ply, enum)
	if bank.Exists(ply) then return false end
	local id = IDToStr(ply:SteamID())
	if bank.IsSQL() then
		local data = runQuery("INSERT INTO `Bank` (`id` , `Money` , `Rank` , `Stock`) VALUES ('"..id.."', '0', '"..enum.."', '');")
		bank.Update(ply, UPD_RANK, enum)
		bank.Read(ply)
		return true
	else
		local ref = {}
		ref["id"], ref["Money"], ref["Rank"], ref["Stock"] = id, 0, enum or 0, {}
		local txt = util.TableToJSON(ref)
		file.Write("AperBank/"..id..".txt", txt)
		bank.Update(ply, UPD_RANK, enum)
		bank.Read(ply)
		return true
	end
end

function bank.Exists(ply)
	local id = IDToStr(ply:SteamID())
	if bank.IsSQL() then
		local data = runQuery("SELECT * FROM `Bank` WHERE id= '"..id.."'")
		if !data or !data[1] then
			bank.Create(ply, 0)
			return false
		else
			return true
		end
	else
		if file.Exists("AperBank/"..id..".txt", "DATA") then
			return true
		else
			return false
		end
	end
end

function bank.Read(ply)
	if !bank.Exists(ply) then bank.Create(ply, 0) end
	local id = IDToStr(ply:SteamID())
	if bank.IsSQL() then
		local data = runQuery("SELECT * FROM `Bank` WHERE id= '"..id.."'")
		bank.Players[ply] = data[1]
		return data
	else
		local ref = {}
		local data = util.JSONToTable(file.Read("AperBank/"..id..".txt")) or {}
		ref["id"], ref["Money"], ref["Rank"], ref["Stock"] = data[1], data[2], data[3], data[4]
		bank.Players[ply] = data or ref
		return data or ref

	end
end


function bank.Upgrade(ply, enum)
	if !bank.Exists(ply) then return false end
	if !ply or !enum then return false end
	local id = IDToStr(ply:SteamID())
	if bank.IsSQL() then	
		local data = runQuery("UPDATE `Bank` SET Rank='"..enum.."' WHERE id= '"..id.."'")
		bank.Update(ply, UPD_RANK, enum)
		bank.Players[ply]["Rank"] = enum
		return true
	else
		local cont = util.JSONToTable(file.Read("AperBank/"..id..".txt"))
		cont[3] = enum
		local txt = util.TableToJSON(cont)
		file.Write(id..".txt", txt)
		bank.Update(ply, UPD_RANK, enum)
		bank.Players[ply]["Rank"] = enum
		return true
	end
end

function bank.SetCash(ply, var)
	if !bank.Exists(ply) then return false end
	if !ply or !var then return false end
	local id = IDToStr(ply:SteamID())
	if bank.IsSQL() then
		local data = runQuery("UPDATE `Bank` SET Money='"..var.."' WHERE id= '"..id.."'")
		bank.Update(ply, UPD_CASH, var)
		bank.Players[ply]["Money"] = var
		return true
	else
		local cont = bank.Players[ply]
		cont["Money"] = var
		PrintTable(cont)
		local txt = util.TableToJSON(cont)
		file.Write("AperBank/"..id..".txt", txt)
		bank.Update(ply, UPD_CASH, var)
		bank.Players[ply]["Money"] = var
		return true
	end
end











function transfer.ToBank(ply, amt)
	if tonumber(ply.DarkRPVars.money) <= amt then return false end
	ply:AddMoney(-amt)
	local var = 0
	if bank.Players[ply] then
		bank.Players[ply]["Money"] = bank.Players[ply]["Money"]+amt
		var = bank.Players[ply]["Money"]
	else
		local data = bank.Read(ply)
		bank.Players[ply]["Money"] = bank.Players[ply]["Money"]+amt
		var = bank.Players[ply]["Money"]
	end

	bank.Update(ply, UPD_CASH, var)
	return true
end

function transfer.ToPly(ply, amt)
	ply:AddMoney(amt)
	local var = 0
	if bank.Players[ply] then
		if bank.Players[ply]["Money"] < amt then return false end
		bank.Players[ply]["Money"] = bank.Players[ply]["Money"]-amt
		var = bank.Players[ply]["Money"]
	else
		local data = bank.Read(ply)
		if bank.Players[ply]["Money"] < amt then return false end
		bank.Players[ply]["Money"] = bank.Players[ply]["Money"]-amt
		var = bank.Players[ply]["Money"]

	end

	bank.Update(ply, UPD_CASH, var)
	return true
end

function transfer.SetCash(ply, amt)
	if bank.Players[ply] then
		bank.Players[ply]["Money"] = amt
		var = bank.Players[ply]["Money"]
	else
		local data = bank.Read(ply)
		bank.Players[ply]["Money"] = amt
		var = bank.Players[ply]["Money"]

	end

	bank.Update(ply, UPD_CASH, var)
	return true
end


function bank.SpawnATMs()
	local map = game.GetMap()
	if !bank.Maps[map] then return end
	for k,v in pairs(bank.Maps[map]) do
		local ent = ents.Create("ATM")
		ent:SetPos(v[1] or Vector(0,0,0))
		ent:SetAngles(v[2] or Angle(0,0,0))
		ent:Spawn()
		print(ent)
	end
end

