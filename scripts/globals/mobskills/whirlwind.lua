-----------------------------------
--  Whirlwind
--
--  Description: Deals wind damage to enemies within range. Additional effect: VIT Down.
--  Type: Magical (Wind)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 10, 10, 180)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end

return mobskillObject
