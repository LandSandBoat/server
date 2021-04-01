-----------------------------------
-- Area: Ordelles Caves
--  NPC: Ruillont
-- Involved in Mission: The Rescue Drill
-- !pos -70 1 607 193
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.THE_RESCUE_DRILL and
        player:getCharVar("MissionStatus") == 9 and
        npcUtil.tradeHas(trade, 16535) -- bronze sword
    then
        player:startEvent(2)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.THE_RESCUE_DRILL then
        local missionStatus = player:getCharVar("MissionStatus")

        if missionStatus >= 2 and missionStatus <= 7 then
            player:startEvent(1)
        elseif missionStatus >= 10 or player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_RESCUE_DRILL) then
            player:showText(npc, ID.text.RUILLONT_INITIAL_DIALOG + 9)
        elseif missionStatus >= 8 then
            player:showText(npc, ID.text.RUILLONT_INITIAL_DIALOG)
        elseif player:getNation() == xi.nation.SANDORIA then
            player:showText(npc, ID.text.RUILLONT_INITIAL_DIALOG + 2)
        else
            player:showText(npc, ID.text.RUILLONT_INITIAL_DIALOG + 1)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:setCharVar("theRescueDrillRandomNPC", math.random(1, 3))
        player:setCharVar("MissionStatus", 8)
    elseif csid == 2 then
        player:setCharVar("MissionStatus", 10)
        player:confirmTrade()
    end
end

return entity
