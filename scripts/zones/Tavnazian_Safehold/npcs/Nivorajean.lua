-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Nivorajean
-- !pos 15.890 -22.999 13.322 26
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.PARADISE_SALVATION_AND_MAPS) then
        player:startEvent(221) -- cycles between 221 and 382(Default)
    else
        player:startEvent(222) -- cycles between 222 and 382(Default) after Paradise, Salvation, and Maps
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
