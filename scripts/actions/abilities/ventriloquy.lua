-----------------------------------
-- Ability: Ventriloquy
-- Swaps the enmity of master and automaton for target.
-- Obtained: Puppetmaster Level 75
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityCheckVentriloquy(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.puppetmaster.onAbilityUseVentriloquy(player, target, ability)
end

return abilityObject
