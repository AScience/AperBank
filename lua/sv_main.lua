hook.Add("Initialize", "Directory", function()
	if !file.IsDir("AperBank", "DATA") && !bank.IsSQL() then
	    file.CreateDir("AperBank")
	end
end)

util.AddNetworkString("AperUpd")
util.AddNetworkString("AperNeedUpd")
util.AddNetworkString("UpgOpen")
util.AddNetworkString("AperCardRem")


NextSave = CurTime()+300


function bank.Update(ply, enum, var)
	net.Start("AperUpd")
		net.WriteString(tostring(enum))
		net.WriteString(tostring(var))
	net.Send(ply)
end



hook.Add("PlayerLoadout", "SetupAper", function(ply)
	local dat = bank.Read(ply)
	if !dat then data = bank.Read(ply) end
	if !dat then return end
	bank.Update(ply, UPD_CASH, dat.Money)
	bank.Update(ply, UPD_RANK, dat.Rank)
end)

hook.Add("Think", "UpdateAper", function()
	if NextSave > CurTime() then return end
	NextSave = CurTime()+300

	for k,v in pairs(bank.Players) do
		bank.SetCash(k, math.Round(v["Money"]+v["Money"]*bank.Config.Bronze.Interest))
	end
end)

hook.Add("PlayerDisconnected", "DiscAper", function(ply)
	if bank.Players[ply] then
		bank.SetCash(ply, bank.Players[ply]["Money"])
	end
end)

net.Receive("AperCardRem", function(len, ply)
	local id = net.ReadString()
	if id == "r" then
		ply:StripWeapon("AperCard")
	else
		ply:Give("AperCard")
	end
end)


function bank.CheckVersion()
	http.Fetch("http://www.gultsgorge.com/ver.txt?unndeed="..math.random(1,10000), function(cont)
		if tonumber(cont) > bank.Version then
			net.Start("AperNeedUpd")
			net.Broadcast()
		end
	end)
end


hook.Add("PlayerInitialSpawn", "ATM Spawn", function(ply)
	if ATMSpawned then return end
	ATMSpawned = true
	bank.SpawnATMs()
end)

hook.Add("PlayerLoadout", "GiveCard", function(ply)
	ply:Give("AperCard")
end)


hook.Add("PlayerDeath", "DropCash", function(ply, wep, kill)
if ply == kill or !bank.Config.DropCash then return end
local pos = ply:GetPos()
local amt = math.Round(ply.DarkRPVars.money*bank.Config.DropAmt)

GAMEMODE:Notify(activator, 0, 4, "Your wallet fell to the floor as you died, you lost $"..amt.."!")
DarkRPCreateMoneyBag(pos, amt)
ply:AddMoney(-amt)

end)