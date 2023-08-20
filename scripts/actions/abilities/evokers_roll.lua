-----------------------------------
-- Ability: Evoker's Roll
-- Gradually restores MP for party members within area of effect
-- Optimal Job: Summoner
-- Lucky Number: 5
-- Unlucky Number: 9
-- Level: 40
-- Phantom Roll +1 Value: 1
--
-- Die Roll    |No SMN  |With SMN
-- --------    -------  -----------
-- 1           |+1      |+2
-- 2           |+1      |+2
-- 3           |+1      |+2
-- 4           |+1      |+2
-- 5           |+3      |+4
-- 6           |+2      |+3
-- 7           |+2      |+3
-- 8           |+2      |+3
-- 9           |+1      |+2
-- 10          |+3      |+4
-- 11          |+4      |+5
-- Bust        |-1      |-1
--
-- Busting on Evoker's Roll will give you -1MP/tick less on your own total MP refreshed i.e. you do not actually lose MP
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.onRollAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(caster, target, ability, action)
    return xi.job_utils.corsair.onRollUseAbility(caster, target, ability, action)
end

return abilityObject
