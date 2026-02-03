-----------------------------------
-- Ability: Sic
-- Commands the charmed Pet to make a random special attack.
-- Obtained: Beastmaster Level 25
-- Recast Time: 2 minutes
-- Duration: N/A
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.checkSic(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.beastmaster.useSic(player, target, ability)
end

return abilityObject
