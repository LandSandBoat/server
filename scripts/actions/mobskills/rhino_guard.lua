-----------------------------------
-- Rhino Guard
-- Description: Enhances evasion, duration scales with TP.
-- Range: Self
-- Notes: 25% evasion increase
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 180, 540)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 25, 0, duration, 1))

    return xi.effect.EVASION_BOOST
end

return mobskillObject
