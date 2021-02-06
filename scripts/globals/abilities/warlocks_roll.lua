-----------------------------------
-- Ability: Warlock's Roll
-- Enhances magic accuracy for party members within area of effect
-- Optimal Job: Red Mage
-- Lucky Number: 4
-- Unlucky Number: 8
-- Level: 46
-- Phantom Roll +1 Value: 1
--
-- Die Roll    |No RDM  |With RDM
-- --------    -------- -----------
-- 1           |+2      |+7
-- 2           |+3      |+8
-- 3           |+4      |+9
-- 4           |+12     |+17
-- 5           |+5      |+10
-- 6           |+6      |+11
-- 7           |+7      |+12
-- 8           |+1      |+6
-- 9           |+8      |+13
-- 10          |+9      |+14
-- 11          |+15     |+20
-- Bust        |-5      |-5
-----------------------------------
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return corsair.onRollAbilityCheck(player, target, ability)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    return corsair.onRollUseAbility(caster, target, ability, action)
end

return ability_object
