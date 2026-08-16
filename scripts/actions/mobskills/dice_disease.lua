-----------------------------------
-- Goblin Dice
-- Description: Disease
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DISEASE, 1, 0, 90))

    return xi.effect.DISEASE
end

return mobskillObject
