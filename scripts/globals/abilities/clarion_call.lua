-----------------------------------
-- Ability: Clarion Call
-- Description: Increases the number of songs that can affect party members by one.
-- Obtained: BRD Level 96
-- Recast Time: 01:00:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.CLARION_CALL, 10, 0, 180)
end

return ability_object
