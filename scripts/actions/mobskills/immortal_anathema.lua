-----------------------------------
-- Immortal Anathema
-- Description: Inflicts a curse on all targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: AoE
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Potency from 25 at 1000 tp to 30 at 3000 tp
    local potency = 25 + math.floor((mob:getTP() - 1000) / 200)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, potency, 0, 30))

    return xi.effect.CURSE_I
end

return mobskillObject
