-----------------------------------
--  Cold Wave
--  Description: Deals ice damage that lowers Agility and gradually reduces HP of enemies within range.
--  Type: Magical (Ice)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, 14, 3, 60))

    return xi.effect.FROST
end

return mobskillObject
