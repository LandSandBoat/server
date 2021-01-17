-----------------------------------
-- Ability: Cooldown
-- Description: Reduces the strain on your automaton.
-- Obtained: PUP Level 95
-- Recast Time: 00:05:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(tpz.effect.COOLDOWN, 18, 1, 1)
end

return ability_object
