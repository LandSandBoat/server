-----------------------------------
-- Area: Zeruhn Mines
--  NPC: Makarim
-- Involved In Mission: The Zeruhn Report
-- !pos -58 8 -333 172
-----------------------------------
local ID = require("scripts/zones/Zeruhn_Mines/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_ZERUHN_REPORT then
        if player:hasKeyItem(tpz.ki.ZERUHN_REPORT) then
            player:messageSpecial(ID.text.MAKARIM_DIALOG_I)
        else
            player:startEvent(121)
        end
    else
        player:startEvent(104)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 121 then
        player:addKeyItem(tpz.ki.ZERUHN_REPORT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ZERUHN_REPORT)
    end
end
