-----------------------------------
-- Ability: Mikage
-- Grants a bonus to number of main weapon attacks that varies with the number of remaining Utsusemi Shadow Images.
-- Obtained: Ninja Level 96
-- Recast Time: 1:00:00
-- Duration: 45 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.MIKAGE, 0, 0, 45)
end

return ability_object
