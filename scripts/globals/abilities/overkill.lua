-----------------------------------
-- Ability: Overkill
-- Description: Increases ranged attack speed and the chance of activating Double/Triple Shot.
-- Obtained: RNG Level 96
-- Recast Time: 01:00:00
-- Duration: 00:01:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.OVERKILL, 11, 1, 60)
end

return abilityObject
