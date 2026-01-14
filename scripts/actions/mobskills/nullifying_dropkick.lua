-----------------------------------
--  Nullifying Dropkick
--  Description: Removes Physical and Magical Shields from Promathia.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    target:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
    target:delStatusEffect(xi.effect.MAGIC_SHIELD)

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
