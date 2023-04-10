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
    -- the door breaks during the CS in Al'Taieu after receiving the Dawn mission, which sets the var to 1. Also checking for The Last Verse mission for whenever that gets implemented.
    if
        (player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus") > 0) or
        player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.DAWN
    then
        if player:getZPos() <= 360 then
            player:startEvent(140)
        else
            player:startEvent(141)
        end
    else
        if player:getZPos() <= 360 then
            player:messageSpecial(ID.text.PORTAL_SEALED)
        else
            player:startEvent(139)
        end
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
