---------------------------------------------
-- Blaster
--
-- Description: Paralyzes enemy.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows.
-- Range: Melee?
-- Notes: Very potent paralysis tpz.effect. Is NOT a Gaze Attack, unlike Chaotic Eye.
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
    local typeEffect = tpz.effect.PARALYSIS


    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 50, 0, 60))

    return typeEffect
end

return mobskill_object
