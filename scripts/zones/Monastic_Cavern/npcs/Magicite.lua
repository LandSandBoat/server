-----------------------------------
-- Area: Monastic Cavern
--  NPC: Magicite
-- Involved in Mission: Magicite
-- !pos -22 1 -66 150
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Monastic_Cavern/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(player:getNation()) == tpz.mission.id.nation.MAGICITE and not player:hasKeyItem(tpz.ki.MAGICITE_OPTISTONE) then
        if player:getCharVar("Magicite") == 2 then
            player:startEvent(0, 1, 1, 1, 1, 1, 1, 1, 1) -- play Lion part of the CS (this is last magicite)
        else
            player:startEvent(0) -- don't play Lion part of the CS
        end
    else
        player:messageSpecial(ID.text.THE_MAGICITE_GLOWS_OMINOUSLY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 0 then
        if player:getCharVar("Magicite") == 2 then
            player:setCharVar("Magicite", 0)
        else
            player:setCharVar("Magicite", player:getCharVar("Magicite")+1)
        end
        player:setCharVar("MissionStatus", 4)
        player:addKeyItem(tpz.ki.MAGICITE_OPTISTONE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MAGICITE_OPTISTONE)
    end
end
