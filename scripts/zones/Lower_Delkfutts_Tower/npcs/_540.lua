-----------------------------------
-- Area: Lower Delkfutt's Tower
--  NPC: Cermet Door
-- Cermet Door for Windy Ambassador
-- Windurst Mission 3.3 "A New Journey"
-- !pos 636 16 59 184
-----------------------------------
local ID = require("scripts/zones/Lower_Delkfutts_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCurrentMission(WINDURST) == xi.mission.id.windurst.A_NEW_JOURNEY and
        player:getCharVar("MissionStatus") == 2 and
        npcUtil.tradeHas(trade, 549) -- Delkfutt Key
    then
        player:startEvent(2)
    end
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(WINDURST)

    if currentMission == xi.mission.id.windurst.A_NEW_JOURNEY and player:getCharVar("MissionStatus") == 2 and not player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
        player:messageSpecial(ID.text.THE_DOOR_IS_FIRMLY_SHUT_OPEN_KEY)
    elseif currentMission == xi.mission.id.windurst.A_NEW_JOURNEY and player:getCharVar("MissionStatus") == 2 and player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
        player:startEvent(2)
    else
        player:messageSpecial(ID.text.DOOR_FIRMLY_SHUT)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 2 then
        player:setCharVar("MissionStatus", 3)

        if not player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
            npcUtil.giveKeyItem(player, xi.ki.DELKFUTT_KEY)
            player:confirmTrade()
        end
    end
end

return entity
