-----------------------------------
-- Ability: Hagakure
-- Grants "Save TP" effect and a TP bonus to your next weapon skill.
-- Obtained: Samurai Level 95
-- Recast Time: 3:00
-- Duration: 1:00 or Next Weaponskill
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.samurai.useHagakure(player, target, ability)
end

return abilityObject
