-----------------------------------
-- Ability: Grand Pas
-- Description: Allows flourishes to be performed without finishing moves.
-- Obtained: DNC Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.GRAND_PAS, 19, 1, 30)
end

return ability_object
