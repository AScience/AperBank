BANK_BRONZE 	= 	0
BANK_SILVER 	= 	1
BANK_GOLD 		= 	2
UPD_CASH		=	1
UPD_RANK		=	2

bank.Database = {}
bank.Maps = {}
transfer = {}
database = {}

bank.Version = 1


function IDToStr(id)
	return string.gsub(id,":", "_")
end


function bank.AddATM(map, vec, ang)
	if !bank.Maps[map] then bank.Maps[map] = {} end
	table.insert(bank.Maps[map], {vec, ang})
end


function GetConfig()
	return file.Read("addons/AperBank/lua/Config/config.txt", "GAME") or ""
end