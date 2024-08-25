-----------------------------------
-- Ability: Clarion Call
-- Description: Increases the number of songs that can affect party members by one.
-- Obtained: BRD Level 96
-- Recast Time: 01:00:00
-- Duration: 0:03:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.bard.checkClarionCall(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.bard.useClarionCall(player, target, ability)
end

return abilityObject
