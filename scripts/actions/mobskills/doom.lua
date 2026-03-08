-----------------------------------
-- Doom
-- Description: Inflicts Doom upon an enemy.
-- Type: Magical (Dark)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DOOM, 10, 3, 30))

    return xi.effect.DOOM
end

return mobskillObject
