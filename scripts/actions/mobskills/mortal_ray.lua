-----------------------------------
-- Mortal Ray
-- Description: Inflicts Doom upon an enemy.
-- Type: Magical (Dark)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.DOOM, 10, 3, 30))

    return xi.effect.DOOM
end

return mobskillObject
