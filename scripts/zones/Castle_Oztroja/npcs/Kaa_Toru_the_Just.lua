-----------------------------------
-- Area: Castle Oztroja
--  NPC: Kaa Toru the Just
-- Type: Mission NPC [ Windurst Mission 6-2 NPC ]~
-- !pos -100.188 -62.125 145.422 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.SAINTLY_INVITATION and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(45, 0, 200)
    else
        player:startEvent(46)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 45) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13134)
        else
            player:delKeyItem(tpz.ki.HOLY_ONES_INVITATION)
            player:addKeyItem(tpz.ki.HOLY_ONES_OATH)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HOLY_ONES_OATH)
            player:addItem(13134) -- Ashura Necklace
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13134)
            player:setCharVar("MissionStatus", 3)
        end
    end
end
