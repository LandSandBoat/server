-----------------------------------
-- Ability: Provoke
-- Goads an enemy into attacking you.
-- Obtained: Warrior Level 5
-- Recast Time: 0:30
-- Duration: 30 seconds
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(user, target, ability)
    --leave blank please! This file will be deleted when the core is updated.
end

return ability_object
