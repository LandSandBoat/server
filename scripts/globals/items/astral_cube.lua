-----------------------------------
-- ID: 6413
-- Item: Astral Cube
-- Item Effect: Grant Astral cube key item
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

local keyItemId = xi.ki.ASTRAL_CUBE

item_object.onItemCheck = function(target)
    if target:hasKeyItem(keyItemId) then
        return xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(xi.basic.OBTAINED_KEY_ITEM, 6413, keyItemId)
end

return item_object
