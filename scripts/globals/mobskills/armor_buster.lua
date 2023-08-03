-----------------------------------
-- Armor Buster
-- Description:
-- Type: Magical Light Damage
-- additional effect: WEIGHT
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 2.5
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.WEIGHT, 20, 3, 45)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return dmg
end

return mobskillObject
