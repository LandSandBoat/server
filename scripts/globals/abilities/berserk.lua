-----------------------------------
-- Ability: Berserk
-- Enhances attacks but weakens defense.
-- Obtained: Warrior Level 15
-- Recast Time: 5:00
-- Duration: 3:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.BERSERK, 25 + player:getMod(xi.mod.BERSERK_EFFECT), 0, 180 + player:getMod(xi.mod.BERSERK_DURATION))

    return xi.effect.BERSERK
end

return ability_object
