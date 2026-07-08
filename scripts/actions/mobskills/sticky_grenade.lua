-----------------------------------
-- Sticky Grenade
-- Family: Orc Warmachine
-- Description: Applies Gravity to targets in area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 60)) -- TODO : Verify weight effect.

    return xi.effect.WEIGHT
end

return mobskillObject
