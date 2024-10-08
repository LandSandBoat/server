-----------------------------------
-- Ability: Troubadour
-- Game Description: Increases the casting time of songs by 1.5 and doubles the effect duration
-- Obtained: Bard by Merit Points at Level 75
-- Recast Time: 0:10:00
-- Duration: 0:01:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.bard.useTroubadour(player, target, ability)
end

return abilityObject
