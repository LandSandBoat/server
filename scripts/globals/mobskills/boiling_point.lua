---------------------------------------------
-- Boiling Point
--
-- Description: Reduces magic defense in a fan-shaped area of effect.
-- Type: Magical
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.MAGIC_DEF_DOWN
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 20, 0, 180))
    return typeEffect
end

return mobskill_object
