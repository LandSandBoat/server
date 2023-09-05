-----------------------------------
-- Ability: Soul Voice
-- Enhances the effects of your songs.
-- Obtained: Bard Level 1
-- Recast Time: 1:00:00
-- Duration: 0:03:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.SOUL_VOICE, 1, 0, 180)
end

return abilityObject
