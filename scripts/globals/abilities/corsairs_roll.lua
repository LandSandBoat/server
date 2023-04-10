-----------------------------------
-- Ability: Corsair's Roll
-- Increases the amount of experience points earned by party members within area of effect
-- Optimal Job: Corsair
-- Lucky Number: 5
-- Unlucky Number: 9
-- Level: 5
-- Phantom Roll +1 Value: 2
--
-- Die Roll    |Exp Bonus%
-- --------    -----------
-- 1           |10%
-- 2           |11%
-- 3           |11%
-- 4           |12%
-- 5           |20%
-- 6           |13%
-- 7           |15%
-- 8           |16%
-- 9           |8%
-- 10          |17%
-- 11          |24%
-- 12+         |-6%
--
-- Bust for Corsair set as subjob is also -6%.
-- Corsair set as subjob is 7% on Lucky roll (5) and 1% on Unlucky roll (9).
-- The EXP bonus afforded by Corsair's Roll does not apply within Abyssea.
-----------------------------------
require("scripts/globals/job_utils/corsair")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.onRollAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(caster, target, ability, action)
    return xi.job_utils.corsair.onRollUseAbility(caster, target, ability, action)
end

return abilityObject
