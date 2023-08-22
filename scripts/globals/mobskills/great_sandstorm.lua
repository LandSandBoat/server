-----------------------------------
--  Great Sandstorm
--
--  Description: Deals Wind damage to single target. Additional effect: Blind
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Single target
--  Notes:
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 180)

    local damage = mob:getMainLvl() * 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end

return mobskillObject
