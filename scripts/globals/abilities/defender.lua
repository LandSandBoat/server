-----------------------------------
-- Ability: Defender
-- Enhances defense but weakens attacks.
-- Obtained: Warrior Level 25
-- Recast Time: 3:00
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
    player:addStatusEffect(tpz.effect.DEFENDER, 1, 0, 180 + player:getMod(tpz.mod.DEFENDER_DURATION))
end

return ability_object
