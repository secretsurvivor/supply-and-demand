AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local model = "models/Items/ammoCrate_Rockets.mdl"

function ENT:Initialize()
	self:SetModel(model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	S_D.DropOff.RegisterEntity(self)
end
local active,entity,validuse = false
local function Active(bool) active = bool return active end
function ENT:DropEntity(class,t)
	Active(true)
	entity = class
	validuse = t
end
function ENT:DisableEntity()
	Active(false)
	entity = nil
	validuse = nil
end
local function Valid(t,ply)
	for k,v in pairs(t)
		if ply == v then
			return true
		end
	end
end
function ENT:SpawnEntity(class)
	local pos,angle = self:GetPos(),self:GetAngles()
	pos = pos + 100 * angle:Forward()
	local product = ents.Create(class)
	if !IsValid(product) then error(string.format("%s failed to create.",class)) return end
	product:SetPos(pos)
	product:Spawn()
end
function ENT:Use(activator,caller)
	if active and Valid(validuse,caller) and  then
		self:SpawnEntity(entity)
	end
end
function ENT:VisibleSet(bool)
	self:SetNoDraw(bool)
	self:SetNotSolid(bool)
end