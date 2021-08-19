-----------------------------------
--  Wild Oats
--
--  Description: Additional effect: Vitality Down. Duration of effect varies on TP.
--  Type: Physical (Piercing)
--
--
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.VIT_DOWN

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 10, 3, 120))

    return typeEffect
end

return mobskill_object
