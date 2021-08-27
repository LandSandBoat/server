-----------------------------------
-- ID: 6378
-- Item: Decorative Chair
-- Item Effect: Grant Decorative chair key item
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

local keyItemId = xi.ki.DECORATIVE_CHAIR

item_object.onItemCheck = function(target)
    if target:hasKeyItem(keyItemId) then
        return xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(xi.msg.basic.OBTAINED_KEY_ITEM, 6378, keyItemId)
end

return item_object
