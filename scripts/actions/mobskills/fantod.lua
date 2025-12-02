-----------------------------------
-- Fantod
-- Gives special boost ability
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local subPower = 1 -- Special formula for boost increasing base damage

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BOOST, 400, 0, 180, nil, subPower))

    return xi.effect.BOOST
end

return mobskillObject
