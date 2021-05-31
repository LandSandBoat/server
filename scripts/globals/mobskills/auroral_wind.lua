-----------------------------------
-- Auroral Wind
--
-- Family: Aern
-- Type: Magical
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown cone
-- Notes:
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SILENCE

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 60)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, xi.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg

end

return mobskill_object
