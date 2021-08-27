-----------------------------------
-- Ability: Scarlet Delirium
-- Description: Channels damage taken into enhanced attack and magic attack.
-- Obtained: DRK Level 95
-- Recast Time: 00:01:30
-- Duration: 00:01:30
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.SCARLET_DELIRIUM, 8, 1, 90)
end

return ability_object
