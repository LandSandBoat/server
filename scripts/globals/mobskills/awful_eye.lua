-----------------------------------
-- Awful Eye
-- 15' Reduces STR of players in area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.STR_DOWN, 10, 10, 180))
    if skill:getID() == 1862 then -- Nightmare Bugard - Adds PETRIFICATION
        skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.PETRIFICATION, 1, 0, 60))
        return xi.effect.PETRIFICATION
    end

    return xi.effect.STR_DOWN
end

return mobskillObject
