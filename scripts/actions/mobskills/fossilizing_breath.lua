-----------------------------------
-- Fossilizing Breath
-- Description: Petrifies targets within a fan-shaped area.
-- Type: Breath
-- Ignores Shadows
-- Range: Unknown cone
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, 60))

    return xi.effect.PETRIFICATION
end

return mobskillObject
