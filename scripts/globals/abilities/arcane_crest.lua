-----------------------------------
-- Ability: Arcane Crest
-- Description: Lowers accuracy, evasion, magic accuracy, magic evasion and TP gain for arcana.
-- Obtained: DRK Level 87
-- Recast Time: 00:05:00
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
    target:addStatusEffect(xi.effect.ARCANE_CREST, 8, 1, 30)
end

return ability_object
