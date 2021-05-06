-----------------------------------
-- Area: Sacrificial Chamber
--  NPC: Mahogany Door
-- !pos 19 -1 -4 163
-----------------------------------
require("scripts/globals/bcnm")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (EventTriggerBCNM(player, npc)) then
        return 1
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
