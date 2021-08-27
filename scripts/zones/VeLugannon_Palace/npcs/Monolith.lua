-----------------------------------
-- Area: VeLugannon Palace
--  NPC: Monolith
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.Y_LITH_OFFSET
    if (offset >= 0 and offset <= 20) then
        local y = (offset <= 11) and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR
        local b = (offset <= 11) and xi.anim.CLOSE_DOOR or xi.anim.OPEN_DOOR
        for i = ID.npc.Y_DOOR_OFFSET,    ID.npc.Y_DOOR_OFFSET + 7, 1 do GetNPCByID(i):setAnimation(y); end  -- yellow doors
        for i = ID.npc.B_DOOR_OFFSET,    ID.npc.B_DOOR_OFFSET + 6, 1 do GetNPCByID(i):setAnimation(b); end  -- blue doors
        for i = ID.npc.Y_LITH_OFFSET -1, ID.npc.Y_LITH_OFFSET + 9, 2 do GetNPCByID(i):setAnimation(y); end  -- yellow monoliths
        for i = ID.npc.B_LITH_OFFSET -1, ID.npc.B_LITH_OFFSET + 9, 2 do GetNPCByID(i):setAnimation(b); end  -- blue monoliths
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
