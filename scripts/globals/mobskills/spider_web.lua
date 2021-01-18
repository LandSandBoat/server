---------------------------------------------
-- Spider Web
-- Entangles all targets in an area of effect.
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
    local typeEffect = tpz.effect.SLOW
    local power = 3000

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, 90))

    return typeEffect
end

return mobskill_object
