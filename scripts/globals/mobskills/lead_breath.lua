-----------------------------------
-- Lead Breath
--
-- Description: Weighs down players.
--
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
    local typeEffect = xi.effect.WEIGHT

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 50, 0, 300))

    return typeEffect
end

return mobskill_object
