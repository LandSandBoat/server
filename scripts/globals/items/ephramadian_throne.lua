-----------------------------------------
-- ID: 6409
-- Item: Ephramadian Throne
-- Item Effect: Grant Ephramadian throne key item
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/msg")

local keyItemId = tpz.ki.EPHRAMADIAN_THRONE

function onItemCheck(target)
    if target:hasKeyItem(keyItemId) then
        return tpz.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end
    return 0
end

function onItemUse(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(tpz.basic.OBTAINED_KEY_ITEM, 6409, keyItemId)
end
