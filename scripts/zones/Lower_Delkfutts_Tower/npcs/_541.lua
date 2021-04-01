-----------------------------------
-- Area: Lower Delkfutt's Tower
--  NPC: Cermet Door
-- Cermet Door for Sandy Ambassador
-- San d'Orian Mission 3.3 "Appointment to Jeuno"
-- !pos 636 16 20 184
-----------------------------------
local ID = require("scripts/zones/Lower_Delkfutts_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.APPOINTMENT_TO_JEUNO and
        player:getCharVar("MissionStatus") == 4 and
        npcUtil.tradeHas(trade, 549) -- Delkfutt Key
    then
        player:startEvent(0)
    end
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(SANDORIA)

    if currentMission == xi.mission.id.sandoria.APPOINTMENT_TO_JEUNO and player:getCharVar("MissionStatus") == 4 and not player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
        player:messageSpecial(ID.text.THE_DOOR_IS_FIRMLY_SHUT_OPEN_KEY)
    elseif currentMission == xi.mission.id.sandoria.APPOINTMENT_TO_JEUNO and player:getCharVar("MissionStatus") == 4 and player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
        player:startEvent(0)
    else
        player:messageSpecial(ID.text.DOOR_FIRMLY_SHUT)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 0 then
        player:setCharVar("MissionStatus", 5)

        if not player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
            npcUtil.giveKeyItem(player, xi.ki.DELKFUTT_KEY)
            player:confirmTrade()
        end
    end
end

return entity
