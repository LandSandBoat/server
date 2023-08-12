-----------------------------------
-- ID: 6377
-- Item: Imperial Chair
-- Item Effect: Grant Imperial chair key item
-----------------------------------
local itemObject = {}

local keyItemId = xi.ki.IMPERIAL_CHAIR

itemObject.onItemCheck = function(target)
    if target:hasKeyItem(keyItemId) then
        return xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(xi.msg.basic.OBTAINED_KEY_ITEM, 6377, keyItemId)
end

return itemObject
