-----------------------------------
-- Ability: Deactivate
-- Deactivates your automaton.
-- Obtained: Puppetmaster Level 1
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    -- Reset the Activate ability.
    local pet = player:getPet()
    if pet:getHP() == pet:getMaxHP() then
        player:resetRecast(tpz.recast.ABILITY, 205) -- activate
    end
    target:despawnPet()
end
