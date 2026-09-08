-----------------------------------
-- Berserk
-- Berserk Ability
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, 50, 0, 180)) -- Does not reduce defense
    return xi.effect.BERSERK
end

return mobskillObject
