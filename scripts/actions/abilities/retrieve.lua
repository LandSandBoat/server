-----------------------------------
-- Ability: Retrieve
-- Orders your automaton to return to your side.
-- Obtained: Puppetmaster Level 10
-- Recast Time: 10 seconds
-- Duration: Instant
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityCheckRetrieve(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityUseRetrieve(player, target, ability)
end

return abilityObject
