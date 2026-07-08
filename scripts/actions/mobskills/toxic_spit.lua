-----------------------------------
-- Toxic Spit
-- Family: Eft
-- Description: Inflicts poison on targets hit.
-- Notes: Single/AoE hit varies between individuals.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local power    = math.floor(mob:getMainLvl() / 5 + 3) -- TODO: Capture power at different levels to verify.
    local duration = 180

    -- TODO: Jug pet: Duration scales with TP.

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, duration)

    return xi.effect.POISON
end

return mobskillObject
