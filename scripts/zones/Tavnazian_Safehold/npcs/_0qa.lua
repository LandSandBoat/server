-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: walnut door
-- Involved in mission 2-4
-- !pos 111 -41 41 26
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.AN_ETERNAL_MELODY and player:getCharVar("PromathiaStatus") == 0) then
        player:startEvent(104)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP and player:getCharVar("PromathiaStatus") == 0) then
        player:startEvent(111)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.CHAINS_AND_BONDS and player:getCharVar("PromathiaStatus")==4) then
        player:startEvent(115)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus")==5) then
        player:startEvent(543)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 104 then
        player:setCharVar("PromathiaStatus", 1)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MYSTERIOUS_AMULET_DRAINED)
        player:addKeyItem(tpz.ki.MYSTERIOUS_AMULET_DRAINED)
    elseif csid == 111 then
        player:setCharVar("PromathiaStatus", 1)
    elseif (csid == 115) then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.CHAINS_AND_BONDS)
        player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.FLAMES_IN_THE_DARKNESS)
    elseif (csid == 543) then
        player:setCharVar("PromathiaStatus", 6)
    end

end
