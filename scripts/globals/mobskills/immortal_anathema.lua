-----------------------------------
-- Immortal Anathema
--
-- Description: Inflicts a curse on all targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: AoE
-- Notes:
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
    local typeEffect = tpz.effect.CURSE_I

    local msg = MobStatusEffectMove(mob, target, typeEffect, 25, 0, 300)

    skill:setMsg(msg)

    return typeEffect
end

return mobskill_object
