-----------------------------------
-- Ability: Dark Seal
-- Enhances the accuracy of your next dark magic spell.
-- Obtained: Dark Knight Level 75
-- Recast Time: 0:05:00
-- Duration: 1 Spell or 60 seconds, whichever occurs first.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local merits = player:getMerit(xi.merit.DARK_SEAL)
    player:addStatusEffect(xi.effect.DARK_SEAL, merits, 0, 60)
end

return ability_object
