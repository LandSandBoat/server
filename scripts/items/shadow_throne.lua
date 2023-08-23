-----------------------------------
-- ID: 6410
-- Item: Shadow Throne
-- Item Effect: Grant Leaf bench key item
-----------------------------------
local itemObject = {}

local keyItemId = xi.ki.SHADOW_THRONE

itemObject.onItemCheck = function(target)
    if target:hasKeyItem(keyItemId) then
        return xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(xi.basic.OBTAINED_KEY_ITEM, 6410, keyItemId)
end

return itemObject
