-----------------------------------
-- Ability: Heady Artifice
-- Description: Allows automatons to perform a special ability that varies with the head used.
-- Obtained: PUP Level 96
-- Recast Time: 01:00:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityCheckHeadyArtiface(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityUseHeadyArtiface(player, target, ability)
end

return abilityObject
