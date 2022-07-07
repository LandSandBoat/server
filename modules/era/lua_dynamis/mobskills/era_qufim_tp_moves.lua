---------------------------------------------
--        Dynamis-Qufim Mobskills          --
---------------------------------------------
---------------------------------------------
--        Module Required Scripts          --
---------------------------------------------
require("scripts/globals/dynamis")
require("modules/module_utils")
---------------------------------------------
local m = Module:new("era_qufim_tp_moves")

m:addOverride("xi.globals.mobskills.cross_attack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    if mob:getID() == mob:getZone():getLocalVar("Scolopendra") then
        numhits = 3
    end
    local accmod = 1
    local dmgmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.H2H, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.H2H)
    return dmg
end)

return m
