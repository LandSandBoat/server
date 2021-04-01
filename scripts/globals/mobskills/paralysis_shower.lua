-----------------------------------
-- Paralysis Shower
-- Range: 10' cone
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
    local typeEffect = xi.effect.PARALYSIS

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 20, 0, 120))


    return typeEffect
end

return mobskill_object
