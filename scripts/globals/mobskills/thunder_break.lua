-----------------------------------
-- Thunder Break
-- Channels the power of Thunder toward targets in an area of effect. Additional effect: Stun

-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.STUN

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(10, 20))

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.THUNDER, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end

return mobskillObject
