-----------------------------------
-- Viscid Secretion
-- Reduces the attack speed and movement speed of enemies within a fan-shaped area originating from the caster.
-- Applies a 25% haste effect to the caster.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if not mob:hasStatusEffect(xi.effect.HASTE) then
        mob:addStatusEffect(xi.effect.HASTE, { power = 2500, duration = 90, origin = mob })
    end

    local effectTable =
    {
        [1] = { effectId = xi.effect.SLOW,   power = 5000, duration = 120, tier = 8 },
        [2] = { effectId = xi.effect.WEIGHT, power =   50, duration = 120           },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
