-----------------------------------
-- Royal Savior
-- Grants effect of Protect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, 175, 0, 300))

    return xi.effect.PROTECT
end

return mobskillObject
