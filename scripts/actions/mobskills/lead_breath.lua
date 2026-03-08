-----------------------------------
-- Lead Breath
-- Description: Weighs down players.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 300))

    return xi.effect.WEIGHT
end

return mobskillObject
