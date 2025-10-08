-----------------------------------
-- Venom Breath
-- Family: Scorpions
-- Description: Poisons enemies in a frontal cone.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 50
    local duration = 60
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, duration)
end

return mobskillObject
