-----------------------------------
-- Ability: Scholar's Roll
-- Enhances Conserve MP effect for party members within area of effect
-- Optimal Job: Scholar
-- Lucky Number: 2
-- Unlucky Number: 6
-- Level: 64
-- Phantom Roll +1 Value: 1
--
--
-- Die Roll    | Conserve MP+
-- --------    ------------
-- 1           |+2%
-- 2           |+10%
-- 3           |+3%
-- 4           |+4%
-- 5           |+4%
-- 6           |+1%
-- 7           |+5%
-- 8           |+6%
-- 9           |+7%
-- 10          |+7%
-- 11          |+12%
-- Bust        |-4%
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.onRollAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(caster, target, ability, action)
    return xi.job_utils.corsair.onRollUseAbility(caster, target, ability, action)
end

return abilityObject
