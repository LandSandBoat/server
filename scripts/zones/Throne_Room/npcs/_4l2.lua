-----------------------------------
-- Area: Throne Room
--  NPC: Ore Door
-----------------------------------
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventUpdate = function(player, csid, option)
    if (EventUpdateBCNM(player, csid, option)) then
        return
    end
end

entity.onEventFinish = function(player, csid, option)
    if (EventFinishBCNM(player, csid, option)) then
        return
    end
end

return entity
