


if SERVER then
    AddCSLuaFile('shared.lua');
end

if CLIENT then
    SWEP.PrintName = 'В наручниках';
    SWEP.Slot = 5;
    SWEP.SlotPos = 10;
    SWEP.DrawAmmo = false;
    SWEP.DrawCrosshair = false;
end

SWEP.Purpose = 'В наручниках'
SWEP.Instructions = 'Терпи'
SWEP.Author = 'Kuyash'

SWEP.ViewModelFOV = 0
SWEP.ViewModelFlip  = false

SWEP.Category = 'Портфолио'
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.NextStrike  = 0;

SWEP.ViewModel = 'models/weapons/w_bugbait.mdl'
SWEP.WorldModel = 'models/weapons/w_bugbait.mdl'


-----Огонь по ЛКМ-----

SWEP.Primary.Delay = 0.01
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = 'none'



-----Огонь по ПКМ-----

SWEP.Secondary.Delay = 0.01
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = 'none'



-----Функции-----

function SWEP:Initialize()

    if CLIENT then
        self:SetWeaponHoldType('pistol') 
    end 
end