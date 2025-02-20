-----------------------------------
-- Blackout
-- Description: AoE Silence, Paralysis, Blind.
-- Attack Type: Magical
-- Shadows: Ignores
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.random(10, 20)
    local duration = math.random(60, 180)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, power, 0, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, duration)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, power, 0, duration))

    return xi.effect.BLINDNESS
end

return mobskillObject
