-----------------------------------
-- Ability: Spur
-- Grants "Store TP" effect to pets.
-- Obtained: Beastmaster Level 83
-- Recast Time: 3 Minutes
-- Duration: 1:30
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    -- same requirements as snarl: pet exists and is attacking a target
    return xi.job_utils.beastmaster.checkSnarl(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.beastmaster.useSpur(player)
end

return abilityObject
