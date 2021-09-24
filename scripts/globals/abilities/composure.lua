-----------------------------------
-- Ability: Composure
-- Increases accuracy and lengthens recast time. Enhancement effects gained through white and black magic you cast on yourself last longer.
-- Obtained: Red Mage Level 50
-- Recast Time: 5:00
-- Duration: 120 minutes
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:delStatusEffect(xi.effect.COMPOSURE)
    player:addStatusEffect(xi.effect.COMPOSURE, 1, 0, 7200)
end

return ability_object
