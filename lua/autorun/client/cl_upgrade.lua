bank.UpgLabels = {}

function retConfCash(tab)
	if tab == 0 then
		return "Unlimited"
	else
		return "£"..FNumber(tab)
	end
end

table.insert(bank.UpgLabels, {"Maximum Storage", 60,146})
table.insert(bank.UpgLabels, {"Interest Rate", 99,240})
table.insert(bank.UpgLabels, {"Robbery Protection", 37,340})
table.insert(bank.UpgLabels, {"Bonus And Extras", 63,460})

--Pricing
table.insert(bank.UpgLabels, {"£1000", 380,65})
table.insert(bank.UpgLabels, {"£5000", 675,65})
table.insert(bank.UpgLabels, {"£10000", 962,65})

--MaxStore
table.insert(bank.UpgLabels, {retConfCash(bank.Config.Bronze.MaxStore), 396,143, true})
table.insert(bank.UpgLabels, {retConfCash(bank.Config.Silver.MaxStore), 690,143, true})
table.insert(bank.UpgLabels, {retConfCash(bank.Config.Gold.MaxStore) , 976,143, true})

--Interest
table.insert(bank.UpgLabels, {bank.Config.Bronze.Interest.."%", 396,229, true})
table.insert(bank.UpgLabels, {bank.Config.Silver.Interest.."%", 690,229, true})
table.insert(bank.UpgLabels, {bank.Config.Gold.Interest.."%", 986,229, true})

--Robery
table.insert(bank.UpgLabels, {bank.Config.Bronze.Protected.."%", 396,325, true})
table.insert(bank.UpgLabels, {bank.Config.Silver.Protected.."%", 690,325, true})
table.insert(bank.UpgLabels, {bank.Config.Gold.Protected.."%", 986,325, true})




net.Receive("UpgOpen", function(len)
	local ent = net.ReadEntity()
	OpenBuyBank()
	ent.InUse = true
	CurMachine = ent
end)



function OpenBuyBank()
	if UpgMenu then return end
	UpgMenu = true

DPB = vgui.Create("DFrame")
DPB:SetSize(1200,620)
DPB:Center()
DPB:SetTitle(" ")
DPB:ShowCloseButton(false)
DPB:SetDraggable(false)
DPB:MakePopup()
DPB.Paint = function()
	draw.RoundedBox( 10, 0, 0, 1170, 620, Color(150, 150, 150, 70))
end

local ImgB = vgui.Create("DImage", DPB)
ImgB:SetImage("aperbank/bronze")
ImgB:SetSize(290,600)
ImgB:SetPos(270,10)
local ImgS = vgui.Create("DImage", DPB)
ImgS:SetImage("aperbank/silver")
ImgS:SetSize(290,600)
ImgS:SetPos(565,10)
local ImgG = vgui.Create("DImage", DPB)
ImgG:SetImage("aperbank/gold")
ImgG:SetSize(290,600)
ImgG:SetPos(860,10)

local BC = vgui.Create("DButton", DPB)
	BC:SetSize(190,40)
	BC:SetPos(30,565)
	BC:SetTextColor(Color(255,255,255))
	BC:SetFont("BankUpg")
	BC:SetText("Close Bank")
	BC.DoClick = function()
		DPB:Close()
		UpgMenu = false
		CurMachine.InUse = false
	end
	BC.Paint = function()
	draw.RoundedBox( 4, 0, 0, 190, 40, Color( 50, 50, 50, 200 ))
	end


for k,v in pairs(bank.UpgLabels) do
	local MaxS = vgui.Create("DLabel", DPB)
	MaxS:SetText(v[1])
	local wid, hei = surface.GetTextSize(v[1])
	if !v[4] then
		MaxS:SetFont("BankUpg")
		MaxS:SetPos(v[2],v[3])
	else
		MaxS:SetFont("BankUpgB")
		MaxS:SetPos(v[2]-(wid/2),v[3])
	end
	MaxS:SetColor(Color(255,255,255))
	MaxS:SizeToContents()
	MaxS:SetExpensiveShadow(0, Color(0,0,0))
end

end