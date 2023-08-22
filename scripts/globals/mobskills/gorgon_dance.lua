-----------------------------------
-- Gorgon Dance
--
-- Description: Petrifies all targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial?
-- Notes: Used only by Medusa. Starts using it at 25%.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local mobhp = mob:getHPP()
    if mobhp <= 25 then -- She's under 25%, it's okay to use this.
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, math.random(60, 180)))
    return typeEffect
end

return mobskillObject
