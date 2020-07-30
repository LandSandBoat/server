-----------------------------------
-- Ability: Super Climb
-- Used by the Wyvern when the Dragoon uses Super Jump.
-- Does not shed hate, but allows the wyvern to dodge any attack like the Dragoon.
-- Obtained: Dragoon Level 50
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(pet, target, ability)
    pet:queue(0, function(pet)
        pet:stun(5000)
    end)
end
