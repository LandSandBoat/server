-----------------------------------
-- ID: 4565
-- Item: Sobbing Fungus
-- Food Effect: 3 Mins, All Races
-- Silence
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 180, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
    if not target:hasStatusEffect(xi.effect.SILENCE) then
        target:addStatusEffect(xi.effect.SILENCE, { power = 1, duration = 180, origin = user, tick = 3 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
