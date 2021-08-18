-----------------------------------
-- Ability: Sacrosanctity
-- Description: Enhances magic defense for party members within area of effect.
-- Obtained: WHM Level 95
-- Recast Time: 00:10:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.SACROSANCTITY, 3, 0, 60)
end

return ability_object
