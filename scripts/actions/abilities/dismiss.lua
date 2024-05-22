-----------------------------------
-- Ability: Dismiss
-- Sends the Wyvern away.
-- Obtained: Dragoon Level 1
-- Recast Time: 5.00
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    -- You can't actually use dismiss on retail unless your wyvern is up
    -- This is on the pet menu, but just in case...
    return xi.job_utils.dragoon.abilityCheckRequiresPet(player, target, ability, false)
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
