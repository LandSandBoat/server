-----------------------------------
-- Ability: Divine Caress
-- Description: If the next spell you cast cures a status ailment, your target will gain enhanced resistance to that ailment.
-- Obtained: WHM Level 83
-- Recast Time: 00:01:00
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
    player:addStatusEffect(xi.effect.DIVINE_CARESS_I, 3, 0, 60)
end

return ability_object
