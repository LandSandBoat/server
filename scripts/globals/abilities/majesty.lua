-----------------------------------
-- Ability: Majesty
-- Description: Increases Cure potency and reduces Cure recast time. Additionally, causes Cure and Protect spells to affect party members in area of effect.
-- Obtained: PLD Level 70
-- Recast Time: 00:01:00
-- Duration: 00:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    -- player:addStatusEffect(xi.effect.MAJESTY, 7, 0, 180) -- TODO: implement xi.effect.MAJESTY
end

return ability_object
