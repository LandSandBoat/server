-----------------------------------
-- Ability: Deactivate
-- Deactivates your automaton.
-- Obtained: Puppetmaster Level 1
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    -- Reset the Activate ability.
    local pet = player:getPet()

    if pet:getHP() == pet:getMaxHP() then
        player:resetRecast(xi.recast.ABILITY, 205) -- activate
    end

    target:despawnPet()
end

return abilityObject
