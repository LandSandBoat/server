-----------------------------------------
-- ID: 6378
-- Item: Decorative Chair
-- Item Effect: Grant Decorative chair key item
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/msg")

local keyItemId = tpz.ki.DECORATIVE_CHAIR

function onItemCheck(target)
    if target:hasKeyItem(keyItemId) then
        return tpz.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end
    return 0
end

function onItemUse(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(tpz.msg.basic.OBTAINED_KEY_ITEM, 6378, keyItemId)
end
