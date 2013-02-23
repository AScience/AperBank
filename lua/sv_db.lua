--DO NOT BOTHER WITH THIS UNLESS UseMySQL is set to true in config.lua

bank.Database.User 		= 	"***"
bank.Database.Password 	= 	"***"
bank.Database.Host 		=	"***"
bank.Database.Database	=	"***"



function bank.IsSQL()
	return bank.Config.UseMySQL or false
end







if bank.IsSQL() then

	require("mysqloo")

	DatabaseConnected = false

	bank.Database.DB = mysqloo.connect(bank.Database.Host, bank.Database.User, bank.Database.Password, bank.Database.Database, 3306)
	local DB = bank.Database.DB


	function DB:onConnected()
		DatabaseConnected = true
		print("AperBank - Database Found, Connected.")
	end

	function DB:onConnectionFailed(err)
		bank.Config.UseMySQL = false
		print("AperBank - Connection Failed... Error: "..err)
	end

	DB:connect()


	function runQuery(str)
		local q = DB:query(str)
		local out = {}
		function q:onSuccess(data)
			out = data
		end
		function q:onError(err, sql)
			print("Database Query Error: "..err)
		end
		q:start()
		q:wait()
		return out
	end


	function database.IsSetup()


	end


















end












--[[if SERVER then

titles = {}
util.AddNetworkString("TitleUpd")

hook.Add("PlayerSay", "titles", function(ply, str, public)
	if (string.sub(str, 1, 9) == "/title on") and !titles[ply] then
		titles[ply] = true
		TitleUpd(ply)
	elseif (string.sub(str, 1, 10) == "/title off") and titles[ply] then
		titles[ply] = false
		TitleUpd(ply)
	end
end)

hook.Add("PlayerLoadout", "Title", function(ply)
	titles[ply] = true
	TitleUpd(ply)
end)


function TitleUpd(ply)
	net.Start("TitleUpd")
		net.WriteEntity(ply)
		net.WriteBool(titles[ply])
	net.Broadcast()
end


elseif CLIENT then

titles = {}

net.Receive("TitleUpd", function(len)
	local ply = net.ReadEntity()
	local bool = net.ReadBool()
	titles[ply] = bool
end)

surface.CreateFont( "TitleFo",
	{
		font      = "coolvetica",
		size      = 12,
		weight    = 700,
	}
)


hook.Add("PostPlayerDraw", "Titles", function(ply)
	if !ply:Alive() then return end 
	local offset = Vector(0,0,85)
	local ang = LocalPlayer():EyeAngles()
	local pos = ply:GetPos()+offset+ang:Up() 
	ang:RotateAroundAxis(ang:Forward(),90)
	ang:RotateAroundAxis(ang:Right(),90) 
	cam.Start3D2D(pos,Angle(0,ang.y,90),0.25)
		draw.DrawText( ply:GetName(), "TitleFo", 2, 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	cam.End3D2D()

end)







end
]]--