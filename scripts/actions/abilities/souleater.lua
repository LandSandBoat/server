-----------------------------------
-- Ability: Souleater
-- Description: Consumes your own HP to enhance attacks.
-- Obtained: Dark Knight Level 30
-- Recast Time: 00:06:00
-- Duration: 00:01:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useSouleater(player, target, ability)
end

return abilityObject
