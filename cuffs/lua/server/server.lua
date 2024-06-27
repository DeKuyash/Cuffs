


hook.Add("PlayerSwitchWeapon", "PreventWeaponSwitch", function(ply, oldWeapon, newWeapon)
    if ply:HasWeapon('cuffed') == true then
        ply:SetActiveWeapon(cuffed)
        return true 
    end
end)