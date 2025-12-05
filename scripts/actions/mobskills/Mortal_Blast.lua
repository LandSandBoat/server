-----------------------------------
-- Mortal Blast
-- Description: Inflicts Death on a single target (Gaze)
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- TODO : Capture Animation, Range & Death message from Abyssea
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.KO, 1, 0, 1))

    target:setHP(0)

    return xi.effect.KO
end

return mobskillObject
