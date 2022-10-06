-----------------------------------
-- Ability: Samurai Roll
-- Enhances "Store TP" effect for party members within area of effect
-- Optimal Job: Samurai
-- Lucky Number: 2
-- Unlucky Number: 6
-- Level 37
-- Phantom Roll +1 Value: 4
--
-- Die Roll    |No SAM  |With SAM
-- 1           |+8      |+18
-- 2           |+32     |+42
-- 3           |+10     |+20
-- 4           |+12     |+22
-- 5           |+14     |+24
-- 6           |+4      |+14
-- 7           |+16     |+26
-- 8           |+20     |+30
-- 9           |+22     |+32
-- 10          |+24     |+34
-- 11          |+40     |+50
-- Bust        |-5      |-5
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
