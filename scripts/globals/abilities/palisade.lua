-----------------------------------
-- Ability: Palisade
-- Description: Increases chance of blocking with shield, and eliminates enmity loss.
-- Obtained: PLD Level 95
-- Recast Time: 00:05:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.PALISADE, 7, 0, 60)
end

return ability_object
