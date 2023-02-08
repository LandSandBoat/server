-----------------------------------
--  ID: 16224
--  Apple au lait Tank
--  When used, you will obtain one Apple au lait
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addItem(xi.items.FLASK_OF_APPLE_AU_LAIT, 1)
end

return itemObject
