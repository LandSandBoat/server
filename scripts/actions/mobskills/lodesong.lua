-----------------------------------
-- Lodesong
-- Description: Weighs down targets in an area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- can only used if not silenced
    if mob:hasStatusEffect(xi.effect.SILENCE) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 75, 0, 30))

    return xi.effect.WEIGHT
end

return mobskillObject
