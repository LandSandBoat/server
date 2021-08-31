-----------------------------------
-- Area: AlTaieu
--  NPC: Dimensional Portal
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.DIMENSIONAL_PORTAL_OFFSET
    if (offset >= 0 and offset <=2) then
        player:startEvent(151 + offset)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if ( csid == 151 and option == 1) then
        player:setPos(420, 19, -140, 63, 102)     -- To La Theine Plateau {R}
    elseif ( csid == 152 and option == 1) then
        player:setPos(220, 19, 140, 64, 108)        -- To Konschtat Highlands {R}
    elseif ( csid == 153 and option == 1) then
        player:setPos(260, 35, 340, 255, 117)     -- To Tahrongi Canyon {R}
    end
end

return entity
