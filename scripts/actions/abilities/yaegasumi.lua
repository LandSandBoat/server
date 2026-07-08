-----------------------------------
-- Ability: Yaegasumi
-- Description: Allows you to evade special attacks. Grants a weapon skill damage bonus that varies with the number of special attacks evaded.
-- Obtained: SAM Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:45
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.samurai.checkYaegasumi(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.samurai.useYaegasumi(player, target, ability)
end

return abilityObject
