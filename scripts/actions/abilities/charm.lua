-----------------------------------
-- Ability: Charm a monster
-- Tames a monster to fight by your side.
-- Obtained: Beastmaster Level 1
-- Recast Time: 0:15
-- Duration: Varies
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.checkCharm(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.beastmaster.useCharm(player, target, ability)
end

return abilityObject
