-----------------------------------
-- Area: Metalworks
--  NPC: Patt-Pott
-- Type: Consulate Representative
-- !pos 23 -17 42 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK and player:getMissionStatus(player:getNation()) == 5 then
        if (trade:hasItemQty(599, 1) and trade:getItemCount() == 1) then -- Trade Mythril Sand
            player:startEvent(255)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(250)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 255 then
        player:tradeComplete()
        player:setMissionStatus(player:getNation(), 7)
        player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)
    end
end

return entity
