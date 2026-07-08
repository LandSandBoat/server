-----------------------------------
-- Ability: Maintenance
-- Cures your automaton of status ailments. Special items required
-- Obtained: Puppetmaster Level 30
-- Recast Time: 1:30
-- Duration: Instant
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityCheckMaintenance(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityUseMaintenance(player, target, ability)
end

return abilityObject
