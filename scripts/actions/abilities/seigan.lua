-----------------------------------
-- Ability: Seigan
-- Grants a bonus to Third Eye when using two-handed weapons.
-- Obtained: Samurai Level 35
-- Recast Time: 1:00
-- Duration: 5:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.samurai.checkSeigan(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.samurai.useSeigan(player, target, ability)
end

return abilityObject
