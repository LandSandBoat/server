-----------------------------------
--  Impact Stream
--
--  Description: 50% Defense Down, Stun
--  Type: Magical
--  Wipe Shadows
--  Range: 10.0' AoE
--  Notes:
-----------------------------------
local mobskillObject = {}

require("scripts/globals/mobskills")

-----------------------------------
mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 60, 0, 60)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.LIGHT, 1, 0, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskillObject
