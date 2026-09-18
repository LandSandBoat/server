-----------------------------------
-- Quake Stomp
-- Family: Troll
-- Description: Stomps the ground to boost the base damage of its next attack by 2x.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local subPower = 1 -- Special formula for boost increasing base damage

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BOOST, 200, 0, 30, nil, subPower))

    return xi.effect.BOOST
end

return mobskillObject
