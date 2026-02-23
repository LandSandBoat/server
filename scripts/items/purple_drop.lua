-----------------------------------
--  ID: 4262
--  Item: Purple Drop
--  Dexterity 5
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
    target:addStatusEffect(xi.effect.DEX_BOOST, { power = 5, duration = 900, origin = user })
    target:addStatusEffect(xi.effect.MEDICINE, { duration = 3600, origin = user })
end

return itemObject
