-----------------------------------
-- Familiar
-- pet powers increase.
-- Note: can use even without a pet
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.pet.applyFamiliarBuffs(mob, mob:getPet())

    skill:setMsg(xi.msg.basic.FAMILIAR_MOB)

    return 0
end

return mobskillObject
