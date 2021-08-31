-----------------------------------
-- Area: Navukgo Execution Chamber
--  NPC: Cast Bronze Gate (Inside BCNM)
-- !pos 282 -123 380 64
-----------------------------------
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (EventTriggerBCNM(player, npc)) then
        return
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
