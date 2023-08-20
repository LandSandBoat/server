-----------------------------------
-- Ability: Earth Maneuver
-- Enhances the effect of earth attachments. Must have animator equipped.
-- Obtained: Puppetmaster level 1
-- Recast Time: 10 seconds (shared with all maneuvers)
-- Duration: 1 minute
-----------------------------------
require("scripts/globals/automaton")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.automaton.onManeuverCheck(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.automaton.onUseManeuver(player, target, ability, action)
end

return abilityObject
