-----------------------------------
-- Ability: Saboteur
-- If the next spell you cast is enfeebling magic, its effect and duration will be enhanced.
-- Obtained: Red Mage Level 83
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.SABOTEUR, 0, 0, 60)
end

return ability_object
