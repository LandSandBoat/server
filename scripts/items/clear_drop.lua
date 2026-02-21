-----------------------------------
--  ID: 4259
--  Item: Clear Drop
--  Intelligence 5
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasStatusEffect(xi.effect.MEDICINE) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.INT_BOOST, { power = 5, duration = 600, origin = user })
    target:addStatusEffect(xi.effect.MEDICINE, { duration = 3600, origin = user })
end

return itemObject
