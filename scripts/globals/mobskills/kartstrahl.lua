-----------------------------------
-- Kartstrahl
--
-- Description: Single target damage with sleep.
-- Type: Physical
--
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLEEP_I, 1, 0, math.random(30, 90))

    return dmg
end

return mobskillObject
