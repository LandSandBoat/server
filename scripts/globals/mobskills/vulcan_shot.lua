-----------------------------------
-- Vulcan Shot
--
-- Description: Fires an explosive bullet at targets in an area of effect.
-- Type: Magical
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: Wipes shadows?
-- Range: 14' radial
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    mob:messageBasic(xi.msg.basic.READIES_WS, 0, 254)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 8
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*4, xi.magic.ele.FIRE, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskill_object
