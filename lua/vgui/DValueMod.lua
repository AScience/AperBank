local PANEL = {}


function PANEL:Init()

	self.Buttons = {1000, 100, 50, 10, 1, -1, -10, -50, -100, -1000}
	self.Value = 0
	self.Symb = "£"
	self.Bs = {}
	self.Elems = {}

	self.Elems.Text = vgui.Create("DLabel", self)
	self.Elems.Text:Dock(TOP)
	self.Elems.Text:SetSize(150)
	self.Elems.Text:SetPos(50,50)
	self.Elems.Text:SetText(self.Symb..tostring(self.Value))



	for k,v in pairs(self.Buttons) do
		self.Bs[v] = vgui.Create("DButton", self)
		local str = v
			if v > 0 then
				str = "+"..tostring(v)
			end
		self.Bs[v]:SetText(tostring(str))
		self.Bs[v]:Dock(NODOCK)
		self.Bs[v]:SetSize(45,30)
		self.Bs[v]:SetPos((k*48)-48)
		self.Bs[v].Val = v
		self.Bs[v].DoClick = function(but) self:AddTo(but.Val) end
	end

	self.Elems.Sub = vgui.Create("DButton", self)
	self.Elems.Sub:SetText("Submit")
	self.Elems.Sub:Dock(BOTTOM)
	self.Elems.Sub:SetWide(100)

	self:SetTall(60)
	self:SetWide(480)




end



function PANEL:AddTo( i )
	self.Value = self.Value + i
	if self.Value < 0 then
		self.Value = 0
	end
	self:UpdateValue()
end

function PANEL:SetValue( i )
	self.Value = i
	self:UpdateValue()
end

function PANEL:SetSymbol( str )
	self.Symb = str
	self:UpdateValue()
end

function PANEL:UpdateValue()
	self.Elems.Text:SetText(self.Symb..tostring(self.Value))
end

function PANEL:GetValue()
	return self.Value or 0
end























derma.DefineControl( "DValueMod", "A 10 point derma element", PANEL, "Panel" )