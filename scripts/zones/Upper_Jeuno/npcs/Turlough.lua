-----------------------------------
-- Area: Upper Jeuno
--  NPC: Turlough
-- Mission NPC
-- !pos
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(WOTG) == tpz.mission.id.wotg.THE_QUEEN_OF_THE_DANCE and player:getCharVar("QueenOfTheDance") == 1) then
        player:startEvent(10172)
    else
        player:startEvent(10158) --default dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 10172) then
        player:setCharVar("QueenOfTheDance", 2)
        player:addKeyItem(tpz.ki.MAYAKOV_SHOW_TICKET)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MAYAKOV_SHOW_TICKET)
    end
end

return entity
