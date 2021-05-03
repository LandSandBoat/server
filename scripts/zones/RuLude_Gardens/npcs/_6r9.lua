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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    currentMission = player:getCurrentMission(player:getNation())
    if ( player:getCurrentMission(COP) == xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS and player:getCharVar("PromathiaStatus")==1) then
        player:startEvent(10050)
    elseif (player:hasKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT) and currentMission == xi.mission.id.nation.NONE and player:getMissionStatus(player:getNation()) == 1) then
        player:startEvent(128)
    elseif (player:hasKeyItem(xi.ki.MAGICITE_OPTISTONE) and player:hasKeyItem(xi.ki.MAGICITE_AURASTONE) and player:hasKeyItem(xi.ki.MAGICITE_ORASTONE)) then
        if (player:hasKeyItem(xi.ki.AIRSHIP_PASS)) then
            player:startEvent(60, 1)
        else
            player:startEvent(60)
        end
    elseif (player:hasKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)) then
        player:messageSpecial(ID.text.SOVEREIGN_WITHOUT_AN_APPOINTMENT)
    else
        player:startEvent(138) -- you don't have a permit
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 128) then
        player:setMissionStatus(player:getNation(), 2)
        player:addMission(player:getNation(), 13)
        player:addKeyItem(xi.ki.LETTERS_TO_ALDO)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTERS_TO_ALDO)
    elseif (csid == 60) then
        player:delKeyItem(xi.ki.MAGICITE_OPTISTONE)
        player:delKeyItem(xi.ki.MAGICITE_AURASTONE)
        player:delKeyItem(xi.ki.MAGICITE_ORASTONE)
        if (player:hasKeyItem(xi.ki.AIRSHIP_PASS)) then
            player:addGil(GIL_RATE*20000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*20000)
            player:addTitle(xi.title.CONQUEROR_OF_FATE)
        else
            player:addKeyItem(xi.ki.AIRSHIP_PASS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.AIRSHIP_PASS)
            player:addTitle(xi.title.HAVE_WINGS_WILL_FLY)
        end
        player:setMissionStatus(player:getNation(), 6) -- all that's left is to go back to the embassy
    elseif (csid == 10050) then
        player:setCharVar("PromathiaStatus", 2)
    end

end

return entity
