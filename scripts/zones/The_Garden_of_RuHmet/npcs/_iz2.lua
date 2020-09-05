-----------------------------------
-- Area: The Garden of RuHmet
--  NPC: _iz2 (Ebon_Panel)
-- !pos 422.351 -5.180 -100.000 35 | Hume Tower
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Race = player:getRace()

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.WHEN_ANGELS_FALL  and player:getCharVar("PromathiaStatus") == 1) then
        player:startEvent(202)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.WHEN_ANGELS_FALL  and player:getCharVar("PromathiaStatus") == 2) then
        if ( Race==tpz.race.HUME_M or Race==tpz.race.HUME_F) then
            player:startEvent(120)
        else
            player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
        end
    else
        player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 202) then
        player:setCharVar("PromathiaStatus", 2)
    elseif (120 and option ~=0) then -- Hume
        player:addTitle(tpz.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar("PromathiaStatus", 3)
        player:addKeyItem(tpz.ki.LIGHT_OF_VAHZL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIGHT_OF_VAHZL)
    end
end
