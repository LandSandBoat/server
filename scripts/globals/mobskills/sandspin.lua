-----------------------------------
-- Sandspin
-- Deals earth damage to enemies within range. Additional Effect: Accuracy Down.
-- Area of Effect is centered around caster.
-- The Additional Effect: Accuracy Down may not always process.
-- Duration: Three minutes ?
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, 25, 0, 180)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.EARTH, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskillObject
