-----------------------------------
-- Shock_Wave
-- Deals damage in a frontal area of effect. Additional effect: Knockback
--
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN) * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    local typeEffect = xi.effect.SLEEP_I

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, math.random(20, 40), 3, 60)
    return dmg
end

return mobskillObject
