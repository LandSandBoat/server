-----------------------------------
-- Ability: Deus Ex Automata
-- Calls forth your automaton in an unsound state.
-- Obtained: Puppetmaster Level 5
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityCheckDeuxExAutomata(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityUseDeuxExAutomata(player, target, ability)
end

return abilityObject
