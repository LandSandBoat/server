-----------------------------------
-- Ability: Chain Affinity
-- Makes it possible for your next "physical" blue magic spell to be used in a skillchain. Effect varies with TP.
-- Obtained: Blue Mage Level 40
-- Recast Time: 2 minutes
-- Duration: 30 seconds or one Blue Magic spell
-- May be used with Sneak Attack and Trick Attack.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(tpz.effect.CHAIN_AFFINITY, 1, 0, 30)

    return tpz.effect.CHAIN_AFFINITY
end

return ability_object
