bank.Pages = {"Account Details", "Withdraw/Deposit", "Stocks", "Manage Account"}
bank.Vars = {1000, 100, 50, 10, 1, -1, -10, -50, -100, -1000}

net.Receive("BankOpen", function(len)
	OpenBank()
	BankOpen = true
end)



function OpenBank()
	if BankOpen then return end
	BankOpen = true

net.Start("AperCardRem")
net.WriteString("r")
net.SendToServer()

DP = vgui.Create("DFrame")
DP:SetSize(700,480)
DP:Center()
DP:SetTitle(" ")
DP:ShowCloseButton(false)
DP:SetDraggable(false)
DP:MakePopup()
DP.Cur = nil
DP.Upd = nil
DP.Paint = function()
	draw.RoundedBox( 0, 0, 0, 700, 480, Color(50, 50, 50, 220))
	draw.RoundedBox( 0, 0, 0, 210, 480, Color(50, 50, 50, 255))
	draw.RoundedBox( 0, 210, 0, 2, 480, Color(0, 0, 0, 220))
	draw.RoundedBox( 0, 0, 400, 210, 2, Color(0, 0, 0, 220))
end

local BFr = vgui.Create("DPanelList", DP)
BFr:SetSize(190,480)
BFr:SetPos(10,10)
BFr:SetSpacing(20)

local DPM = vgui.Create("DPanel", DP)
DPM:SetSize(488,480)
DPM:SetPos(212,0)
DPM.Paint = nil


function DPM:Think()
if DP.Cur == DP.Upd then return end
DP.Upd = DP.Cur
local md = DP.Upd:GetText()
for k,v in pairs(DPM:GetChildren()) do
	v:Remove()
end

if md == "Account Details" then
	local Tx = vgui.Create("DLabel",DPM)
	Tx:SetText("Current Balance: ")
	Tx:SetFont("CloseCaption_Bold")
	Tx:SetPos(10,10)
	Tx:SetColor(Color(255,255,255))
	Tx:SizeToContents()
	Cash = vgui.Create("DLabel",DPM)
	Cash:SetText("£"..FNumber(bank.User["Money"] or 0))
	Cash.Cur = Money
	Cash:SetFont("CloseCaption_Bold")
	Cash:SetPos(250,10)
	Cash:SizeToContents()
	Cash.Think = function(l)
	if Money != l.Cur then
		l:SetText("£"..FNumber(Money))
		l.Cur = Money
	end
	end

	local Tx2 = vgui.Create("DLabel",DPM)
	Tx2:SetText("Interest Rate: ")
	Tx2:SetFont("CloseCaption_Bold")
	Tx2:SetPos(10,60)
	Tx2:SetColor(Color(255,255,255))
	Tx2:SizeToContents()
	Int = vgui.Create("DLabel",DPM)
	Int:SetText("0.04%")
	Int:SetFont("CloseCaption_Bold")
	Int:SetPos(250,60)
	Int:SizeToContents()


elseif md == "Withdraw/Deposit" then
local Tx = vgui.Create("DLabel",DPM)
	Tx:SetText("Withdraw")
	Tx:SetFont("CloseCaption_Bold")
	Tx:SetPos(10,10)
	Tx:SetColor(Color(255,255,255))
	Tx:SizeToContents()

local DValueMod = vgui.Create("DPanel", DPM)
	DValueMod:SetSize(400,150)
	DValueMod:SetPos(44,50)

local DValueVal = 1000
local amtstr = surface.GetTextSize("£"..tostring(DValueVal))

local DValueV = vgui.Create("DLabel", DValueMod)
	DValueV:SetText("£1000")
	DValueV:Center()
	DValueV:SetFont("CloseCaption_Bold")
	DValueV:SizeToContents()
	DValueV:SetPos(190-(amtstr/2), 10)

local DValB = {}
	for k,v in pairs(bank.Vars) do
		local But = vgui.Create("DButton", DValueVal)






local Tx = vgui.Create("DLabel",DPM)
	Tx:SetText("Deposit")
	Tx:SetFont("CloseCaption_Bold")
	Tx:SetPos(10,230)
	Tx:SetColor(Color(255,255,255))
	Tx:SizeToContents()



end


end


for k,v in pairs(bank.Pages) do
	local B = vgui.Create("DButton")
	B:SetSize(190,75)
	B:SetText(v)
	B:SetTextColor(Color(255,255,255))
	B:SetFont("BankFont")
	if k == 1 then
		B.Sel = true
		DP.Cur = B
	end
	B.Paint = function(b)
		if b.Sel then
			draw.RoundedBox( 0, 0, 0, 190, 75, Color( 0, 0, 0, 255 ))
			draw.RoundedBox( 0, 2, 2, 186, 71, Color( 225, 154, 28, 255 ))
		else
			draw.RoundedBox( 0, 0, 0, 190, 75, Color( 0, 0, 0, 255 ))
			draw.RoundedBox( 0, 2, 2, 186, 71, Color( 200, 139, 3, 255 ))
		end
	end
	B.DoClick = function(b)
		DP.Cur.Sel = false
		DP.Cur = b
		b.Sel = true
	end
	BFr:AddItem(B)
end

	local BC = vgui.Create("DButton", DP)
	BC:SetSize(190,40)
	BC:SetPos(10,425)
	BC:SetTextColor(Color(255,255,255))
	BC:SetFont("BankFont")
	BC:SetText("Close Bank")
	BC.DoClick = function()
		DP:Close()
		BankOpen = false
		CurMachine.InUse = false
		net.Start("AperCardRem")
		net.WriteString("a")
		net.SendToServer()
	end
	BC.Paint = function()
	draw.RoundedBox( 0, 0, 0, 190, 40, Color( 0, 0, 0, 255 ))
	draw.RoundedBox( 0, 2, 2, 186, 36, Color( 223, 90, 3, 200 ))
	end


end