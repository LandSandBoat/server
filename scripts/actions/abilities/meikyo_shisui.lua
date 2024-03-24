-----------------------------------
-- Ability: Meikyo Shisui
-- Reduces cost of weapon skills.
-- Obtained: Samurai Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:30
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.MEIKYO_SHISUI, 1, 0, 30)
    player:addTP(3000)
end

return abilityObject
