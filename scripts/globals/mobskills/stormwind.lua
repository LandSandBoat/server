-----------------------------------
--  Stormwind
--
--  Description: Creates a whirlwind that deals Wind damage to targets in an area of effect.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Unknown radial
--  Notes: Kreutzet damage mods need to be checked
-----------------------------------
local mobskillObject = {}

require("scripts/globals/mobskills")

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1

    if mob:getName() == "Kreutzet" then
        local stormwindDamage = mob:getLocalVar("stormwindDamage")
        if stormwindDamage == 2 then
            dmgmod = 1.1
        elseif stormwindDamage == 3 then
            dmgmod = 1.15
        end
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end

return mobskillObject
