-----------------------------------
-- Ability: Chain Affinity
-- Makes it possible for your next "physical" blue magic spell to be used in a skillchain. Effect varies with TP.
-- Obtained: Blue Mage Level 40
-- Recast Time: 2 minutes
-- Duration: 30 seconds or one Blue Magic spell
-- May be used with Sneak Attack and Trick Attack.
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.blue_mage.checkChainAffinity(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.blue_mage.useChainAffinity(player, target, ability, action)
end

return abilityObject
