-----------------------------------
-- Ability: Relinquish
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    -- TODO: Block if being attacked
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:setPos(0, 0, 0, 0, xi.zone.FERETORY)
end

return abilityObject
