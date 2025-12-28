-----------------------------------
-- Ink Cloud
-- Description: Blinds nearby targets with ink.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 50 + 5 * math.floor((skill:getTP() - 1000) / 1000)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, power, 0, math.random(30, 60)))

    return xi.effect.BLINDNESS
end

return mobskillObject
