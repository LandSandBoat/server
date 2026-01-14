-----------------------------------
-- Impale (Bind version)
-- Description: Inflicts Bind on a single target
-- TODO: Check if this is supposed to ignore shadows or not & exact range.
-- NOTE: Does not deal damage, a miss returns "no effect".
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 15))

    return xi.effect.BIND
end

return mobskillObject
