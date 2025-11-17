-----------------------------------
-- Venom Spray
-- Family: Antlions
-- Description: Poisons enemies in a frontal cone.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 15
    local duration = 120
    if mob:isNM() then
        power = 25
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, duration))

    return xi.effect.POISON
end

return mobskillObject
