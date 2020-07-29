-----------------------------------
-- Area: The Garden of RuHmet
--  NPC: Ebon_Panel
-- !pos 100.000 -5.180 -337.661 35 | Mithra Tower
-- !pos 740.000 -5.180 -342.352 35 | Elvaan Tower
-- !pos 257.650 -5.180 -699.999 35 | Tarutaru Tower
-- !pos 577.648 -5.180 -700.000 35 | Galka Tower
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
    local xPos = npc:getXPos()

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.WHEN_ANGELS_FALL  and player:getCharVar("PromathiaStatus") == 1) then
        player:startEvent(202)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.WHEN_ANGELS_FALL  and player:getCharVar("PromathiaStatus") == 2) then
        if (xPos > 99 and xPos < 101) then -- Mithra Tower
            if ( Race==tpz.race.MITHRA ) then
                player:startEvent(124)
            else
                player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
            end
        elseif (xPos > 739 and xPos < 741) then -- Elvaan Tower
            if ( Race==tpz.race.ELVAAN_M or Race==tpz.race.ELVAAN_F) then
                player:startEvent(121)
            else
                player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
            end
        elseif (xPos > 256 and xPos < 258) then -- Tarutaru Tower
            if ( Race==tpz.race.TARU_M or Race==tpz.race.TARU_F  ) then
                player:startEvent(123)
            else
                player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
            end
        elseif (xPos > 576 and xPos < 578) then -- Galka Tower
            if ( Race==tpz.race.GALKA) then
                player:startEvent(122)
            else
                player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
            end
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
    elseif (124 and option ~=0) then -- Mithra
        player:addTitle(tpz.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar("PromathiaStatus", 3)
        player:addKeyItem(tpz.ki.LIGHT_OF_DEM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIGHT_OF_DEM)
    elseif (121 and option ~=0) then -- Elvaan
        player:addTitle(tpz.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar("PromathiaStatus", 3)
        player:addKeyItem(tpz.ki.LIGHT_OF_MEA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIGHT_OF_MEA)
    elseif (123 and option ~=0) then -- Tarutaru
        player:addTitle(tpz.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar("PromathiaStatus", 3)
        player:addKeyItem(tpz.ki.LIGHT_OF_HOLLA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIGHT_OF_HOLLA)
    elseif (122 and option ~=0) then -- Galka
        player:addTitle(tpz.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar("PromathiaStatus", 3)
        player:addKeyItem(tpz.ki.LIGHT_OF_ALTAIEU)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIGHT_OF_ALTAIEU)
    end
end
