-----------------------------------
-- Ability: Super Climb
-- Used by the Wyvern when the Dragoon uses Super Jump.
-- Does not shed hate, but allows the wyvern to dodge any attack like the Dragoon.
-- Obtained: Dragoon Level 50
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(pet, target, ability)
    pet:queue(0, function(petArg)
        petArg:untargetableAndUnactionable(5000)
    end)
end

return abilityObject
