-----------------------------------
-- Ability: Provoke
-- Job: Warrior
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(user, target, ability)
    --Leave blank.
end

return ability_object
