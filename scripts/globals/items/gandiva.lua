-----------------------------------------
-- ID: 19468
-- Item: Gandiva
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
    npcUtil.giveItem(target, { { 21298, 99 } }) -- Artemis' Arrow x99
end
