-----------------------------------
-- Area: Sacrificial Chamber
--  NPC: Mahogany Door
-- !pos 299 0.1 349 163
-----------------------------------
require("scripts/globals/bcnm")
require("scripts/globals/missions")
local ID = require("scripts/zones/Sacrificial_Chamber/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (EventTriggerBCNM(player, npc)) then
        return 1
    else
        player:messageSpecial(ID.text.DOOR_SHUT)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if (EventFinishBCNM(player, csid, option)) then
        return
    end
end

return entity
