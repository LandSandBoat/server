-----------------------------------
--  Impalement
--
--  Description: Deals damage to a single target reducing their HP to 5%. Resets enmity.
--  Type: Physical
--  Utsusemi/Blink absorb: No
--  Range: Single Target
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    MobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 120)

    MobStatusEffectMove(mob, target, xi.effect.SLOW, 128, 0, 120)
    local currentHP = target:getHP()
    -- remove all by 5%
    local stab = currentHP * .95

    local dmg = MobFinalAdjustments(stab, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    mob:resetEnmity(target)
    return dmg
end

return mobskill_object
