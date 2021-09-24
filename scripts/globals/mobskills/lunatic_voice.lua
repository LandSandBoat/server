-----------------------------------
-- Lunatic Voice
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target,mob,skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.MUTE

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 60))

    return typeEffect
end

return mobskill_object
