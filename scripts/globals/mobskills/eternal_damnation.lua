-----------------------------------
-- Eternal Damnation
-- Description: Inflicts Doom upon an enemy.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.DOOM, 10, 3, 30))

    return xi.effect.DOOM
end

return mobskill_object
