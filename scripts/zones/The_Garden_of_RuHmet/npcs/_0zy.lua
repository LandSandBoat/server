-----------------------------------
-- Area: The Garden of Ru'Hmet
--  NPC: Cermet Portal
-- !pos -419 0.1 356 35
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL) then
        if player:getZPos() <= 360 then
            player:startEvent(140)
        else
            player:startEvent(141)
        end
    else
        if player:getZPos() <= 360 then
            player:messageSpecial(ID.text.PORTAL_SEALED)
        else 
            player:startEvent(141)
        end
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
