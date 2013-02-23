surface.CreateFont( "BankFont", {
	font 		= "Default",
	size 		= 18,
	weight 		= 1000,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= true,
	additive 	= false,
	outline 	= false
} )

surface.CreateFont( "BankUpg", {
	font 		= "BebasNeue",
	size 		= 40,
	weight 		= 300,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= true,
	additive 	= false,
	outline 	= false
} )

surface.CreateFont( "BankUpgB", {
	font 		= "BebasNeue",
	size 		= 48,
	weight 		= 300,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= true,
	additive 	= false,
	outline 	= false
} )

bank.User = {}


net.Receive("AperUpd", function(len)
	local enum, var = tonumber(net.ReadString()), tonumber(net.ReadString())
	if enum == 1 then
		bank.User["Money"] = var
	elseif enum == 2 then
		bank.User["Rank"] = var
	end
end)

net.Receive("AperNeedUpd", function(len)
	chat.AddText(Color(255,0,0), "[Update] ",
	Color(255,255,255), "AperBank is currently out of date - ",
	Color(0,0,255), "Contact Your Admin To Update",
	Color(255,255,255),".")
end)


function NumToRank(num)
	if num == 0 then
		return "Bronze"
	elseif num == 1 then
		return "Silver"
	elseif num == 2 then
		return "Gold"
	else
		return "N/A"
	end
end