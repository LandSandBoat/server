-----------------------------------
-- Area: Hazhalm Testing Grounds
--  NPC: Entry Gate (TOAU-36)
-----------------------------------
local ID = require("scripts/zones/Hazhalm_Testing_Grounds/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.GAZE_OF_THE_SABOTEUR and player:getCharVar("AhtUrganStatus") == 1) then
        player:startEvent(7)
    end
end

function onEventUpdate(player, csid, option)

end

function onEventFinish(player, csid, option)

    if (csid == 7) then
        player:completeMission(TOAU, tpz.mission.id.toau.GAZE_OF_THE_SABOTEUR)
        player:setCharVar("AhtUrganStatus", 0)
        player:setTitle(tpz.title.EMISSARY_OF_THE_EMPRESS)
        player:addKeyItem(tpz.ki.LUMINIAN_DAGGER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LUMINIAN_DAGGER)
        player:addMission(TOAU, tpz.mission.id.toau.PATH_OF_BLOOD)
    end

end
