-----------------------------------
--  NPC: _0s8 (Wooden Gate)
-- Area: Sacrarium
-- Involved in Mission: Secrets of Worship
-- !pos 45.500 -1.500 10.000 28
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrigger(player, npc)

    if (player:getXPos() > 45) then
        if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP and player:getCharVar("PromathiaStatus") == 2) then
            player:startEvent(6, 0, 582)
        elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP and player:getCharVar("PromathiaStatus") == 4 and player:hasKeyItem(tpz.ki.RELIQUIARIUM_KEY) == true) then
            player:startEvent(5)
        elseif (player:hasKeyItem(tpz.ki.RELIQUIARIUM_KEY) == true) then
            player:startEvent(110)
        end
    else
        player:messageSpecial(ID.text.CANNOT_OPEN_SIDE)
    end
    return 1
end

function onTrade(player, npc, trade)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 6) then
        player:setCharVar("PromathiaStatus", 3)
    elseif (csid == 5) then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP)
        player:addMission(COP, tpz.mission.id.cop.SLANDEROUS_UTTERINGS)
    end
end
