-----------------------------------
-- Battery Charge
-- Description: Gradually restores MP.
-- Type: Magical (Light)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = utils.clamp(skill:getTP() / 1000, 1, 3)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REFRESH, power, 3, 198))

    return xi.effect.REFRESH
end

return mobskillObject
