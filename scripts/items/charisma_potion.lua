-----------------------------------
--  ID: 4211
--  Item: Charisma Potion
--  Charisma 7
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
    target:addStatusEffect(xi.effect.CHR_BOOST, { power = 7, duration = 180, origin = user })
    target:addStatusEffect(xi.effect.MEDICINE, { duration = 900, origin = user })
end

return itemObject
