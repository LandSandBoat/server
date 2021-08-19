-----------------------------------
--  Thunderbolt
--
--  Description: Deals thunder damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical (Thunder)
--
--
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    -- not used in Uleguerand_Range
    if (mob:getZoneID() == 5) then
        return 1
    end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local typeEffect = xi.effect.STUN

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 7)

    local dmgmod = MobBreathMove(mob, target, 0.333, 0.625, xi.magic.ele.THUNDER, 500)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHTNING, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHTNING)
    return dmg
end

return mobskill_object
