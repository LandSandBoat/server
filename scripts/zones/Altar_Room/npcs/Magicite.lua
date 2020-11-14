-----------------------------------
-- Area: Altar Room
--  NPC: Magicite
-- Involved in Mission: Magicite
-- !pos -344 25 43 152
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Altar_Room/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(player:getNation()) == tpz.mission.id.nation.MAGICITE and
        not player:hasKeyItem(tpz.ki.MAGICITE_ORASTONE) then
        if player:getCharVar("Magicite") == 2 then
            player:startEvent(44, 152, 3, 1743, 3) -- play Lion part of the CS (this is last magicite)
        else
            player:startEvent(44) -- don't play Lion part of the CS
        end
    else
        player:messageSpecial(ID.text.THE_MAGICITE_GLOWS_OMINOUSLY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 44 then
        if player:getCharVar("Magicite") == 2 then
            player:setCharVar("Magicite", 0)
        else
            player:setCharVar("Magicite", player:getCharVar("Magicite") + 1)
        end
        player:setCharVar("MissionStatus", 4)
        player:addKeyItem(tpz.ki.MAGICITE_ORASTONE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MAGICITE_ORASTONE)
    end
end
