-----------------------------------
-- Ability: Cascade
-- Description: Grants a damage bonus to the next elemental magic spell cast based on TP consumed.
-- Obtained: BLM Level 85
-- Recast Time: 00:01:00
-- Duration: 0:01:00 or the next spell cast
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.CASCADE, 4, 0, 60)
end

return ability_object
