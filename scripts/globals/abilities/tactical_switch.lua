-----------------------------------
-- Ability: Tactical Switch
-- Description: Swaps TP of master and automaton.
-- Obtained: PUP Level 79
-- Recast Time: 00:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    -- target:addStatusEffect(xi.effect.TACTICAL_SWITCH, 18, 1, 1) -- TODO: implement xi.effect.TACTICAL_SWITCH
end

return ability_object
