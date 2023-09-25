-----------------------------------
-- Ability: Release
-- Sends the avatar away.
-- Obtained: Summoner Level 1
-- Recast Time: 10 seconds (shared by all avatars)
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:despawnPet()
end

return abilityObject
