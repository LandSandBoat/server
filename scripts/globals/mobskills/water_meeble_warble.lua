-----------------------------------
-- Water Meeble Warble
-- AOE Water Elemental damage, inflicts Poison and Drown (50 HP/tick).
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.magic.ele.WATER, dmgmod, TP_NO_EFFECT, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    MobStatusEffectMove(mob, target, xi.effect.POISON, 50, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.DROWN, 50, 3, 60)
    return dmg
end

return mobskill_object
