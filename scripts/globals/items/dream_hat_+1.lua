-----------------------------------
-- ID: 15179
-- Dream Hat +1
-- Dispenses Ginger Cookies
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
    target:addItem(xi.items.GINGER_COOKIE, math.random(1, 10))
end

itemObject.onItemDrop = function(target)
    target:setCharVar("[StarlightMisc]DreamHatHQ", 1)
end

return itemObject
