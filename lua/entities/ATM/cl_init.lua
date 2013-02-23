
include('shared.lua')

function ENT:Initialize()
	
	self.Color = Color( 255, 255, 255, 255 )
	self.IsATM = true
	
end

function ENT:Draw()
	self.Entity:DrawModel()
	if self.InUse then
		self:SetBodygroup(1,1)
	else
		self:SetBodygroup(1,0)
	end
end
