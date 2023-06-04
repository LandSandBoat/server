-----------------------------------
-- ID: 6412
-- Item: Leaf Bench
-- Item Effect: Grant Leaf bench key item
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

local keyItemId = xi.ki.LEAF_BENCH

itemObject.onItemCheck = function(target)
    if target:hasKeyItem(keyItemId) then
        return xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(xi.msg.basic.OBTAINED_KEY_ITEM, 6412, keyItemId)
end

return itemObject
