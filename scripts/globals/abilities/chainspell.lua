-----------------------------------
-- Ability: Chainspell
-- Allows rapid spellcasting.
-- Obtained: Red Mage Level 1
-- Recast Time: 1:00:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.CHAINSPELL, 1, 0, 60)
end

return ability_object
