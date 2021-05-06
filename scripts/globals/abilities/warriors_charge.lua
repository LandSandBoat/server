-----------------------------------
-- Ability: Warrior's Charge
-- Will double your next attack.
-- Obtained: Warrior Level 75 (Merit)
-- Recast Time: 5:00
-- Duration: 1:00 or next attack
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local merits = player:getMerit(xi.merit.WARRIORS_CHARGE)
    player:addStatusEffect(xi.effect.WARRIORS_CHARGE, merits-5, 0, 60)
end

return ability_object
