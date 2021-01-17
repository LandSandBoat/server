---------------------------------------------
-- Asthenic Fog
--
-- Description: A mist drowns all nearby targets.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-- Notes:
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
    local typeEffect = tpz.effect.DROWN

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 25, 3, 120))

    return typeEffect
end

return mobskill_object
