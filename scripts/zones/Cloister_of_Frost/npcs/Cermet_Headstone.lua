-----------------------------------
-- Area: Cloister of Frost
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Ice Fragment)
-- !pos 566 0 606 203
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/missions")
local ID = require("scripts/zones/Cloister_of_Frost/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(ZILART) == xi.mission.id.zilart.HEADSTONE_PILGRIMAGE) then
        if (player:hasKeyItem(xi.ki.ICE_FRAGMENT) == false) then
            player:startEvent(200, xi.ki.ICE_FRAGMENT);
        elseif
            player:hasKeyItem(xi.ki.FIRE_FRAGMENT) and
            player:hasKeyItem(xi.ki.ICE_FRAGMENT) and
            player:hasKeyItem(xi.ki.WIND_FRAGMENT) and
            player:hasKeyItem(xi.ki.EARTH_FRAGMENT) and
            player:hasKeyItem(xi.ki.LIGHTNING_FRAGMENT) and
            player:hasKeyItem(xi.ki.WATER_FRAGMENT) and
            player:hasKeyItem(xi.ki.LIGHT_FRAGMENT) and
            player:hasKeyItem(xi.ki.DARK_FRAGMENT)
        then
            player:messageSpecial(ID.text.ALREADY_HAVE_ALL_FRAGS)
        elseif (player:hasKeyItem(xi.ki.ICE_FRAGMENT)) then
            player:messageSpecial(ID.text.ALREADY_OBTAINED_FRAG, xi.ki.ICE_FRAGMENT)
        end
    elseif (player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)) then
        player:messageSpecial(ID.text.ZILART_MONUMENT)
    else
        player:messageSpecial(ID.text.CANNOT_REMOVE_FRAG)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 200 and option == 1) then
        player:addKeyItem(xi.ki.ICE_FRAGMENT)
        -- Check and see if all fragments have been found (no need to check ice and dark frag)
        if
            player:hasKeyItem(xi.ki.FIRE_FRAGMENT) and
            player:hasKeyItem(xi.ki.WIND_FRAGMENT) and
            player:hasKeyItem(xi.ki.EARTH_FRAGMENT) and
            player:hasKeyItem(xi.ki.LIGHTNING_FRAGMENT) and
            player:hasKeyItem(xi.ki.WATER_FRAGMENT) and
            player:hasKeyItem(xi.ki.LIGHT_FRAGMENT)
        then
            player:messageSpecial(ID.text.FOUND_ALL_FRAGS, xi.ki.ICE_FRAGMENT)
            player:addTitle(xi.title.BEARER_OF_THE_EIGHT_PRAYERS)
            player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
        else
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ICE_FRAGMENT)
        end
    end

end

return entity
