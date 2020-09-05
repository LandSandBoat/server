-----------------------------------
-- Area: The Garden of Ru'Hmet
--  NPC: Cermet Portal
-- !pos -419 0.1 356 35
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- the door breaks during the CS in Al'Taieu after receiving the Dawn mission, which sets the var to 1. Also checking for The Last Verse mission for whenever that gets implemented.
    if ((player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus") > 0) or player:getCurrentMission(COP) > tpz.mission.id.cop.DAWN) then
        if (player:getZPos() <= 360) then
            player:startEvent(140)
        else
            player:startEvent(141)
        end
    else
        if (player:getZPos() <= 360) then
            player:messageSpecial(ID.text.PORTAL_SEALED)
        else
            player:startEvent(139)
        end
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
