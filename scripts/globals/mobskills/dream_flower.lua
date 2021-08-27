-----------------------------------
-- Dream Flower
-- 15' AoE sleep
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
    local typeEffect = xi.effect.SLEEP_I

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(20, 30)))

    return typeEffect
end

return mobskill_object
