-----------------------------------
-- Ability: Barrage
-- Fires multiple shots at once.
-- Obtained: Ranger Level 30
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
    player:addStatusEffect(xi.effect.BARRAGE, 0, 0, 60)
end

return ability_object
