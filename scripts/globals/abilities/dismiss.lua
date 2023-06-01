-----------------------------------
-- Ability: Dismiss
-- Sends the Wyvern away.
-- Obtained: Dragoon Level 1
-- Recast Time: 5.00
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    -- Reset the Call Wyvern Ability.
    local pet = player:getPet()

    if pet:getHP() == pet:getMaxHP() then
        player:resetRecast(xi.recast.ABILITY, 163) -- call_wyvern
    end

    target:despawnPet()
end

return abilityObject
