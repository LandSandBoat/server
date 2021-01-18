-----------------------------------
--
-- Venom Storm
--
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
    local typeEffect = tpz.effect.POISON

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, math.random(20, 30), 3, 60))
    return typeEffect
end

return mobskill_object
