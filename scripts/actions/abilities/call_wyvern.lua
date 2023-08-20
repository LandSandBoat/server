-----------------------------------
-- Ability: Call Wyvern
-- Summons a Wyvern to fight by your side.
-- Obtained: Dragoon Level 1
-- Recast Time: 20:00
-- Duration: Instant
-- Special: Only available if Dragoon is your main class.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dragoon.abilityCheckCallWyvern(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dragoon.useCallWyvern(player, target, ability)
end

return abilityObject
