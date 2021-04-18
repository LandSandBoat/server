-----------------------------------
-- Area: Metalworks
--  NPC: Savae E Paleade
-- Involved In Mission: Journey Abroad
-- !pos 23.724 -17.39 -43.360 237
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.JOURNEY_TO_BASTOK and player:getMissionStatus(player:getNation()) == 5) then
        if (trade:hasItemQty(599, 1) and trade:getItemCount() == 1) then -- Trade Mythril Sand
            player:startEvent(205)
        end
    end

end

entity.onTrigger = function(player, npc)

    -- San d'Oria Mission 2-3 Part I - Bastok > Windurst
    if (player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.JOURNEY_ABROAD and player:getMissionStatus(player:getNation()) == 2) then
        player:startEvent(204)
    -- San d'Oria Mission 2-3 Part II - Windurst > Bastok
    elseif (player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.JOURNEY_ABROAD and player:getMissionStatus(player:getNation()) == 7) then
        player:startEvent(206)
    elseif (player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.JOURNEY_TO_BASTOK2 and player:getMissionStatus(player:getNation()) == 11) then
        player:startEvent(207)
    -----------------------------------
    elseif (player:getCurrentMission(SANDORIA) ~= xi.mission.id.sandoria.NONE) then
        player:startEvent(208)
    else
        player:startEvent(200)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 204) then
        player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK)
        player:setMissionStatus(player:getNation(), 3)
        player:delKeyItem(xi.ki.LETTER_TO_THE_CONSULS_SANDORIA)
    elseif (csid == 205) then
        player:tradeComplete()
        player:setMissionStatus(player:getNation(), 6)
        player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_ABROAD)
    elseif (csid == 206) then
        player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK2)
        player:setMissionStatus(player:getNation(), 8)
    elseif (csid == 207) then
        player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_ABROAD)
        player:delKeyItem(xi.ki.KINDRED_CREST)
        player:addKeyItem(xi.ki.KINDRED_REPORT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.KINDRED_REPORT)
    end

end

return entity
