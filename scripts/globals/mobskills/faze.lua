-----------------------------------
-- Faze
-- Family: Qiqurn
-- Description: Scares a single target.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-- Notes: Target has to be facing user
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
    local typeEffect = xi.effect.TERROR
    local duration = 5

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end

return mobskill_object
