-----------------------------------
-- Faze
-- Family: Qiqurn
-- Description: Scares a single target.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-- Notes: Target has to be facing user
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.TERROR, 1, 0, 5))

    return xi.effect.TERROR
end

return mobskillObject
