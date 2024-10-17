-----------------------------------
-- Ability: Deploy
-- Orders your automaton to attack.
-- Obtained: Puppetmaster Level 1
-- Recast Time: 10 seconds
-- Duration: Instant
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityCheckDeploy(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityUseDeploy(player, target, ability)
end

return abilityObject
