-----------------------------------
-- Area: Hall of the Gods
--  NPC: Cermet Gate
-- Gives qualified players access to Ru'Aun Gardens.
-- !pos 0 -12 48 251
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.CERULEAN_CRYSTAL) then
        player:startEvent(1)
    else
        if player:getCurrentMission(ZILART) == xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL then
            player:startEvent(4) -- Zilart CS.
        else
            player:startEvent(2)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 1 and player:getCurrentMission(ZILART) == xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION then
        player:addTitle(xi.title.SEALER_OF_THE_PORTAL_OF_THE_GODS)
        player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION)
        player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_HALL_OF_THE_GODS)
    elseif csid == 4 then
        player:setCharVar("ZilartStatus", 0)
        player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)
        player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_GATE_OF_THE_GODS)
    end
end

return entity
