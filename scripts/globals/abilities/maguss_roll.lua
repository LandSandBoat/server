-----------------------------------
-- Ability: Magus's Roll
-- Enhances magic defense for party members within area of effect
-- Optimal Job: Blue Mage
-- Lucky Number: 2
-- Unlucky Number: 6
-- Level: 17
-- Phantom Roll +1 Value: 2
--
-- Die Roll    |No BLU  |With BLU
-----------    -------  -----------
-- 1           |+5      |+13
-- 2           |+20     |+28
-- 3           |+6      |+14
-- 4           |+8      |+16
-- 5           |+9      |+17
-- 6           |+3      |+11
-- 7           |+10     |+18
-- 8           |+13     |+21
-- 9           |+14     |+22
-- 10          |+15     |+23
-- 11          |+25     |+33
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
