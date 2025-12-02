-----------------------------------
-- Actinic Burst
-- Family: Ghrah
-- Description: Greatly lowers the accuracy of enemies within range for a brief period of time.
-- Type: Magical (Light)
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Flash needs a decay
    -- 66% Accuracy reduction
    local targetAcc = target:getMod(xi.mod.ACC)
    local power = math.floor(targetAcc * 0.66)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, power, 0, math.random(15, 30)))

    return xi.effect.FLASH
end

return mobskillObject
