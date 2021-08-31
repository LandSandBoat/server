-----------------------------------
-- Ability: Divine Emblem
-- Description: Enhances the accuracy of your next divine magic spell and increases enmity.
-- Obtained: PLD Level 78
-- Recast Time: 00:03:00
-- Duration: 00:01:00 or the next spell cast
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.DIVINE_EMBLEM, 7, 0, 60)
end

return ability_object
