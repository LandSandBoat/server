-----------------------------------
-- Ability: Deactivate
-- Deactivates your automaton.
-- Obtained: Puppetmaster Level 1
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityCheckDeactivate(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityUseDeactivate(player, target, ability)
end

return abilityObject
