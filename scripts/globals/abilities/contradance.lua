-----------------------------------
-- Ability: Contradance
-- Description: Increases the amount of HP restored by your next Waltz.
-- Obtained: DNC Level 50
-- Recast Time: 00:05:00
-- Duration: 00:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    -- player:addStatusEffect(xi.effect.CONTRADANCE, 19, 1, 60) -- TODO: implement xi.effect.CONTRADANCE
end

return ability_object
