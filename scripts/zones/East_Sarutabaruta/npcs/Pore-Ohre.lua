-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Pore-Ohre
-- Involved In Mission: The Heart of the Matter
-- !pos 261 -17 -458 116
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    -- Check if we are on Windurst Mission 1-2
    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_HEART_OF_THE_MATTER) then
        MissionStatus = player:getCharVar("MissionStatus")
        if (MissionStatus == 1) then
            player:startEvent(46)
        elseif (MissionStatus == 2) then
            player:startEvent(47)
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 46) then
        player:setCharVar("MissionStatus", 2)
        player:addKeyItem(tpz.ki.SOUTHEASTERN_STAR_CHARM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SOUTHEASTERN_STAR_CHARM)
    end

end
