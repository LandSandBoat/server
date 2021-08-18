-----------------------------------
-- ID: 6377
-- Item: Imperial Chair
-- Item Effect: Grant Imperial chair key item
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

local keyItemId = xi.ki.IMPERIAL_CHAIR

item_object.onItemCheck = function(target)
    if target:hasKeyItem(keyItemId) then
        return xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(xi.msg.basic.OBTAINED_KEY_ITEM, 6377, keyItemId)
end

return item_object
