-----------------------------------
-- Rhino Guard
-- Description: Enhances evasion, duration scales with TP.
-- Range: Self
-- Notes: Very sharp evasion increase.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 180, 480)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 25, 0, duration))

    return xi.effect.EVASION_BOOST
end

return mobskillObject
