-----------------------------------
-- Hysteroanima
-- Used by Trust: Prishe II
-- Grants a temporary magic shield
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_SHIELD, 1, 0, 10)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
