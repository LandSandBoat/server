-----------------------------------
-- Ability: Avenger's Roll
-- Increases chance of countering for party members within area of effect.
-- Optimal Job: None
-- Lucky Number: 4
-- Unlucky Number: 8
-- Level: 97
--
-- No community data available. Substituting Fighters Roll %
-- Phantom Roll +1 Value: 1
--
-- Die Roll    |Counter
-- --------    --------
-- 1           |2%
-- 2           |2%
-- 3           |3%
-- 4           |12%
-- 5           |4%
-- 6           |5%
-- 7           |6%
-- 8           |1%
-- 9           |7%
-- 10          |9%
-- 11          |18%
-- 12+         |-6%
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.onRollAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(caster, target, ability, action)
    return xi.job_utils.corsair.onRollUseAbility(caster, target, ability, action)
end

return abilityObject
