-----------------------------------
-- Area: VeLugannon Palace
-- NPC:  Monolith
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/status")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local offset = npc:getID() - ID.npc.Y_LITH_OFFSET
    if (offset >= 0 and offset <= 20) then
        local y = (offset <= 11) and tpz.anim.OPEN_DOOR or tpz.anim.CLOSE_DOOR
        local b = (offset <= 11) and tpz.anim.CLOSE_DOOR or tpz.anim.OPEN_DOOR
        for i = ID.npc.Y_DOOR_OFFSET,    ID.npc.Y_DOOR_OFFSET + 7, 1 do GetNPCByID(i):setAnimation(y); end  -- yellow doors
        for i = ID.npc.B_DOOR_OFFSET,    ID.npc.B_DOOR_OFFSET + 6, 1 do GetNPCByID(i):setAnimation(b); end  -- blue doors
        for i = ID.npc.Y_LITH_OFFSET -1, ID.npc.Y_LITH_OFFSET + 9, 2 do GetNPCByID(i):setAnimation(y); end  -- yellow monoliths
        for i = ID.npc.B_LITH_OFFSET -1, ID.npc.B_LITH_OFFSET + 9, 2 do GetNPCByID(i):setAnimation(b); end  -- blue monoliths
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
