-----------------------------------
-- Ability: Manafont
-- Eliminates the cost of magic spells.
-- Obtained: Black Mage Level 1
-- Recast Time: 1:00:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(tpz.effect.MANAFONT, 1, 0, 60)
end

return ability_object
