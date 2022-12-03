-----------------------------------
-- Ability: Burst Affinity
-- Makes it possible for your next "magical" blue magic spell to be used in a Magic Burst.
-- Obtained: Blue Mage Level 25
-- Recast Time: 2 minutes
-- Duration: 30 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.BURST_AFFINITY, 1, 0, 30)

    return xi.effect.BURST_AFFINITY
end

return abilityObject
