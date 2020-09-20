-----------------------------------
-- Ability: Dismiss
-- Sends the Wyvern away.
-- Obtained: Dragoon Level 1
-- Recast Time: 5.00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    -- Reset the Call Wyvern Ability.
    local pet = player:getPet()
    if pet:getHP() == pet:getMaxHP() then
        player:resetRecast(tpz.recast.ABILITY, 163) -- call_wyvern
    end
    target:despawnPet()
end
