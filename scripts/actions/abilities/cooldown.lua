-----------------------------------
-- Ability: Cooldown
-- Description: Reduces the strain on your automaton.
-- Obtained: PUP Level 95
-- Recast Time: 00:05:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityCheckCooldown(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityUseCooldown(player, target, ability)
end

return abilityObject
