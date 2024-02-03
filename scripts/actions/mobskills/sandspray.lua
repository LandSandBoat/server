-----------------------------------
-- Sandspray
-- Family: Qiqurn
-- Description: Blinds enemies within a fan-shaped area originating from the user.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 25
    local duration = 90

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, power, 0, duration))

    return xi.effect.BLINDNESS
end

return mobskillObject
