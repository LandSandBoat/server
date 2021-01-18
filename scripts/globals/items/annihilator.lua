-----------------------------------
-- ID: 18336, 18337, 18649, 18663, 18677, 19758, 19851, 21260, 21261, 21267
-- Item: Annihilator
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/npc_util")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getFreeSlotsCount() == 0 then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

item_object.onItemUse = function(target)
    npcUtil.giveItem(target, { { 21327, 99 } })
end

return item_object
