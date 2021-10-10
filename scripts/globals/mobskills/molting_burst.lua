-----------------------------------
--  Molting Burst
--
--  Description: Deals Light damage and drains HP. Transfers any negative status effects to the target.
--  Type: Magical
--  Utsusemi/Blink absorb: Unknown
--  Range: Unknown
--  Notes: Used by Limules affiliated with light element.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*5, xi.magic.ele.LIGHT, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, MOBPARAM_2_SHADOW)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end

return mobskill_object
