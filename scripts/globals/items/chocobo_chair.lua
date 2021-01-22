-----------------------------------
-- ID: 6411
-- Item: Chocobo Chair
-- Item Effect: Grant Chocobo chair key item
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

local keyItemId = tpz.ki.CHOCOBO_CHAIR

item_object.onItemCheck = function(target)
    if target:hasKeyItem(keyItemId) then
        return tpz.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(tpz.basic.OBTAINED_KEY_ITEM, 6411, keyItemId)
end

return item_object
