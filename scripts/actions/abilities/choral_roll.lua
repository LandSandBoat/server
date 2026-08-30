-----------------------------------
-- Ability: Choral Roll
-- Decreases spell interruption rate for party members within area of effect
-- Optimal Job: Bard
-- Lucky Number: 2
-- Unlucky Number: 6
-- Level: 26
-- Phantom Roll +1 Value: 4
--
-- Die Roll     |No BRD     |With BRD
-- --------     --------    -------
-- 1            |-8         |-33
-- 2            |-42        |-67
-- 3            |-11        |-36
-- 4            |-15        |-40
-- 5            |-19        |-44
-- 6            |-4         |-29
-- 7            |-23        |-48
-- 8            |-27        |-52
-- 9            |-31        |-56
-- 10           |-35        |-60
-- 11           |-50        |-75
-- Bust         |+25        |+25
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
