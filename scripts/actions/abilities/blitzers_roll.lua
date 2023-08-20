-----------------------------------
-- Ability: Blitzer's Roll
-- Reduces melee attack delay for party members within area of effect.
-- Optimal Job: None
-- Lucky Number: 4
-- Unlucky Number: 9
-- Level: 83
-- Phantom Roll +1 Value: 1
--
-- Die Roll    | Delay Reduction %
-- --------    -------
-- 1           |+2
-- 2           |+3
-- 3           |+4
-- 4           |+11
-- 5           |+5
-- 6           |+6
-- 7           |+7
-- 8           |+8
-- 9           |+1
-- 10          |+10
-- 11          |+12
-- Bust        |-5
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.onRollAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(caster, target, ability, action)
    return xi.job_utils.corsair.onRollUseAbility(caster, target, ability, action)
end

return abilityObject
