-----------------------------------
-- Sweet Breath
--
-- Description: Deals water damage to enemies within a fan-shaped area originating from the caster.
-- Type: Magical Water (Element)
--
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.125, 3, xi.magic.ele.WATER, 500)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    MobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 30)

    return dmg
end

return mobskill_object
