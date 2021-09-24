-----------------------------------
-- Rot Gas
--
-- Description: Inflicts enemies in an area of effect with a disease.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial
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
    local typeEffect = xi.effect.DISEASE
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 180))

    return typeEffect
end

return mobskill_object
