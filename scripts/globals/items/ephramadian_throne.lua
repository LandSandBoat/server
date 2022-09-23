-----------------------------------
-- ID: 6409
-- Item: Ephramadian Throne
-- Item Effect: Grant Ephramadian throne key item
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

local keyItemId = xi.ki.EPHRAMADIAN_THRONE

item_object.onItemCheck = function(target)
    if target:hasKeyItem(keyItemId) then
        return xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(xi.basic.OBTAINED_KEY_ITEM, 6409, keyItemId)
end

return item_object
