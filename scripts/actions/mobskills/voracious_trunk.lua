-----------------------------------
-- Voracious Trunk
-- Steal one effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobDrainStatusEffectMove(mob, target))

    return 1
end

return mobskillObject
