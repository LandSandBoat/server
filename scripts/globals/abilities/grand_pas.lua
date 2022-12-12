-----------------------------------
-- Ability: Grand Pas
-- Description: Allows flourishes to be performed without finishing moves.
-- Obtained: DNC Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.GRAND_PAS, 19, 1, 30)
end

return abilityObject
