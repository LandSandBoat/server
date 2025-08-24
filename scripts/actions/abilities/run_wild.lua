-----------------------------------
-- Ability: Run Wild
-- Your familiar will gain heightened powers, but will disappear when the effect expires.
-- Obtained: Beastmaster Level 93
-- Recast Time: 15 Minutes
-- Duration: 5:00
-- Notes: despawns your pet when the effect wears
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    -- same requirements as snarl: pet exists and is attacking a target
    return xi.job_utils.beastmaster.onAbilityCheckSnarl(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.beastmaster.onUseAbilityRunWild(player, target, ability, action)
end

return abilityObject
