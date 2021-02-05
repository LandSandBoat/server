-----------------------------------
-- Ability: Bolter's Roll
-- Increases Movement speed for party members with area of effect.
-- Optimal Job: None
-- Lucky Number: 3
-- Unlucky Number: 9
-- Level: 76
-- Phantom Roll +1 Value: 4
--
-- Die Roll    | %
-- --------    -------
-- 1           |+6
-- 2           |+6
-- 3           |+16
-- 4           |+8
-- 5           |+8
-- 6           |+10
-- 7           |+10
-- 8           |+12
-- 9           |+4
-- 10          |+14
-- 11          |+20
-- Bust        |0
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
