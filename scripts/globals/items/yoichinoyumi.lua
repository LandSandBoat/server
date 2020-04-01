-----------------------------------------
-- ID: 18348, 18349, 18650, 18664, 18678, 19759, 19852, 21210, 21211, 22115
-- Item: Yoichinoyumi
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/npc_util")
-----------------------------------

function onItemCheck(target)
    if target:getFreeSlotsCount() == 0 then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

function onItemUse(target)
    npcUtil.giveItem(target, { { 21299, 99 } })
end
