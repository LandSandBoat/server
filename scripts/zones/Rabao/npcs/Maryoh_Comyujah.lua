-----------------------------------
-- Area: Rabao
--  NPC: Maryoh Comyujah
-- Involved in Mission: The Mithra and the Crystal (Zilart 12)
-- !pos 0 8 73 247
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Rabao/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL) then
        if (player:getCharVar("ZilartStatus") == 0) then
            player:startEvent(81) -- Start
        elseif (player:hasKeyItem(tpz.ki.SCRAP_OF_PAPYRUS)) then
            player:startEvent(83) -- Finish
        elseif (player:getCharVar("ZilartStatus") == 2) then
            player:startEvent(84) -- Go to hall of the gods
        else
            player:startEvent(82)
        end
    elseif (player:hasCompletedMission(ZILART, tpz.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)) then
        player:startEvent(85) -- New standard dialog after ZM12
    else
        player:startEvent(43) -- Standard dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 81 and option == 1) then
        player:setCharVar("ZilartStatus", 1)
    elseif (csid == 83) then
        player:setCharVar("ZilartStatus", 2)
        player:delKeyItem(tpz.ki.SCRAP_OF_PAPYRUS)
        player:addKeyItem(tpz.ki.CERULEAN_CRYSTAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CERULEAN_CRYSTAL)
    end

end
