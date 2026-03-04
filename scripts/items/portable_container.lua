-----------------------------------
-- ID: 6408
-- Item: Portable Container
-- Item Effect: Grant Portable container key item
-----------------------------------
---@type TItem
local itemObject = {}

local keyItemId = xi.ki.PORTABLE_CONTAINER

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasKeyItem(keyItemId) then
        return xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(xi.msg.basic.OBTAINED_KEY_ITEM, xi.item.PORTABLE_CONTAINER, keyItemId)
end

return itemObject
