-----------------------------------
-- Phase Shift
-- A shockwave deals damage to targets in an area of effect. Additional effect: Stun + Bind
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 7
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 4, 4, 4)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, MOBPARAM_2_SHADOW)
    MobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 15)
    MobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 30)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    mob:setUnkillable(false)
    return dmg
end

return mobskill_object
