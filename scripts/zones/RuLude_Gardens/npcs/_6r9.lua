-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Audience Chamber
-- Involved in Mission: Magicite
-- !pos 0 -5 66 243
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/missions")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    CurrentMission = player:getCurrentMission(player:getNation())
    if ( player:getCurrentMission(COP) ==tpz.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS and player:getCharVar("PromathiaStatus")==1) then
        player:startEvent(10050)
    elseif (player:hasKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT) and CurrentMission == tpz.mission.id.nation.NONE and player:getCharVar("MissionStatus") == 1) then
        player:startEvent(128)
    elseif (player:hasKeyItem(tpz.ki.MAGICITE_OPTISTONE) and player:hasKeyItem(tpz.ki.MAGICITE_AURASTONE) and player:hasKeyItem(tpz.ki.MAGICITE_ORASTONE)) then
        if (player:hasKeyItem(tpz.ki.AIRSHIP_PASS)) then
            player:startEvent(60, 1)
        else
            player:startEvent(60)
        end
    elseif (player:hasKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT)) then
        player:messageSpecial(ID.text.SOVEREIGN_WITHOUT_AN_APPOINTMENT)
    else
        player:startEvent(138) -- you don't have a permit
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 128) then
        player:setCharVar("MissionStatus", 2)
        player:addMission(player:getNation(), 13)
        player:addKeyItem(tpz.ki.LETTERS_TO_ALDO)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LETTERS_TO_ALDO)
    elseif (csid == 60) then
        player:delKeyItem(tpz.ki.MAGICITE_OPTISTONE)
        player:delKeyItem(tpz.ki.MAGICITE_AURASTONE)
        player:delKeyItem(tpz.ki.MAGICITE_ORASTONE)
        if (player:hasKeyItem(tpz.ki.AIRSHIP_PASS)) then
            player:addGil(GIL_RATE*20000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*20000)
            player:addTitle(tpz.title.CONQUEROR_OF_FATE)
        else
            player:addKeyItem(tpz.ki.AIRSHIP_PASS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.AIRSHIP_PASS)
            player:addTitle(tpz.title.HAVE_WINGS_WILL_FLY)
        end
        player:setCharVar("MissionStatus", 6) -- all that's left is to go back to the embassy
    elseif (csid == 10050) then
        player:setCharVar("PromathiaStatus", 2)
    end

end
