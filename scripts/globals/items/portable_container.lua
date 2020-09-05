-----------------------------------------
-- ID: 6408
-- Item: Portable Container
-- Item Effect: Grant Portable container key item
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/msg")

local keyItemId = tpz.ki.PORTABLE_CONTAINER

function onItemCheck(target)
    if target:hasKeyItem(keyItemId) then
        return tpz.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end
    return 0
end

function onItemUse(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(tpz.basic.OBTAINED_KEY_ITEM, 6408, keyItemId)
end
