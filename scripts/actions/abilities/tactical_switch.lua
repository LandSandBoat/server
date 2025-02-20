-----------------------------------
-- Ability: Tactical Switch
-- Description: Swaps TP of master and automaton.
-- Obtained: PUP Level 79
-- Recast Time: 00:03:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityCheckTacticalSwitch(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityUseTacticalSwitch(player, target, ability)
end

return abilityObject
