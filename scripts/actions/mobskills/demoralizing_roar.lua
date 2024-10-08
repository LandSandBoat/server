-----------------------------------
-- Demoralizing Roar
-- Description: Inflicts Attack Down (-50%) to players within a 10' area of effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not target:isBeside(mob, 64) then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 500
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 30, 90)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, power, 0, duration)
end

return mobskillObject
