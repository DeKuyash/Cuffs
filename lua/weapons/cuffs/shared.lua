


if SERVER then
    AddCSLuaFile('shared.lua');
end

if CLIENT then
    SWEP.PrintName = 'Наручники';
    SWEP.Slot = 5;
    SWEP.SlotPos = 10;
    SWEP.DrawAmmo = false;
    SWEP.DrawCrosshair = false;
end

SWEP.Purpose = 'Наручники'
SWEP.Instructions = 'ЛКМ - Закольцевать \n ПКМ - Вести за собой \n R - Освободить'
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




sound.Add({ name = 'cuff', channel = CHAN_STATIC, volume = 0, level = 80, pitch = {85, 90}, sound = 'cuff.wav'})
sound.Add({ name = 'uncuff', channel = CHAN_STATIC, volume = 0, level = 80, pitch = {85, 90}, sound = 'uncuff.wav'})





-----Функции-----

function SWEP:Initialize()
    if CLIENT then
        self:SetWeaponHoldType('pistol') 
    end 

end




function SWEP:PrimaryAttack()
    if ( CurTime() < self.NextStrike) then return; end

    if SERVER then

        self.NextStrike = (CurTime() + 1);

        local ply = self.Owner
        local eyeTrace = ply:GetEyeTrace()
        local target = eyeTrace.Entity

        if target:IsPlayer() then
            target:Give('cuffed')
            target:SetActiveWeapon(cuffed)
            target:SetWalkSpeed(30)
            target:SetRunSpeed(30)
            target:EmitSound('cuff')
        end 

    end
end




local lever = false

function SWEP:SecondaryAttack()


    if ( CurTime() < self.NextStrike) then return; end

    if SERVER then
        self.NextStrike = (CurTime() + 1);

        local ply = self.Owner

        local eyeTrace = ply:GetEyeTrace()
        local target = eyeTrace.Entity

        if target:IsPlayer() and target:HasWeapon('cuffed') then

            if not lever then
                lever = true   

                local plyPos = ply:GetPos()
                local tPos = target:GetPos()

                target:SetMoveType(MOVETYPE_NOCLIP)

                hook.Add('Think', 'leadCuffed', function()

                    local dist = plyPos:Distance(tPos)        

                    if dist <= 110 then
                        local pos = ply:GetShootPos()
                        local ang = ply:EyeAngles()
                        ang.pitch = 0
                        local forward = ang:Forward()
                        local distance = 50

                        local newPos = pos + forward*distance

                        newPos.z = tPos.z

                        target:SetPos(newPos)
                    end
                end)

            else
                lever = false 
                hook.Remove('Think', 'leadCuffed')
                target:SetMoveType(MOVETYPE_WALK)
            end

        end
    end
end

function SWEP:Reload()
    if SERVER then
        local ply = self.Owner
        local eyeTrace = ply:GetEyeTrace()
        local target = eyeTrace.Entity

        if target:IsPlayer() and target:HasWeapon('cuffed') then
            lever = false 
            hook.Remove('Think', 'leadCuffed')
            target:StripWeapon('cuffed')
            target:SetWalkSpeed(240)
            target:SetRunSpeed(240)
            target:SetMoveType(MOVETYPE_WALK)
            target:EmitSound('uncuff')

        end
    end
end



