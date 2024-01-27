-----------------------------------
-- Actinic Burst
-- Family: Ghrah
-- Description: Greatly lowers the accuracy of enemies within range for a brief period of time.
-- Type: Magical (Light)
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 200
    local duration = 20

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, power, 0, duration))

    return xi.effect.FLASH
end

return mobskillObject
