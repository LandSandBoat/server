-----------------------------------
-- Ability: Beast Roll
-- Enhances pet attacks for party members within area of effect
-- Optimal Job: Beastmaster
-- Lucky Number: 4
-- Unlucky Number: 8
-- Level: 34
-- Phantom Roll +1 Value: 3
--
-- Die Roll |No BST     |With BST
-- -------- --------    -----------
-- 1        |16         |41
-- 2        |20         |45
-- 3        |24         |49
-- 4        |64         |89
-- 5        |28         |53
-- 6        |32         |57
-- 7        |40         |65
-- 8        |8          |33
-- 9        |44         |69
-- 10       |48         |73
-- 11       |80         |105
-- Bust     |-25        |-25
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
