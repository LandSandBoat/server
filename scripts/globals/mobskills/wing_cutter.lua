-----------------------------------
-- Wing Cutter
-- Deals Wind damage to targets in a fan-shaped area of effect.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1

    local ftp = 2
    if mob:getTP() >= 2000 then
        ftp = 2.5
    elseif mob:getTP() == 3000 then
        ftp = 3
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * ftp, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end

return mobskillObject
