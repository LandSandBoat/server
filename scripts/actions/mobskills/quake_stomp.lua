-----------------------------------
-- Quake Stomp
-- Description: Stomps the ground to boost next attack.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 100
    local duration = 60

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BOOST, power, 0, duration))
    return xi.effect.BOOST
end

return mobskillObject
