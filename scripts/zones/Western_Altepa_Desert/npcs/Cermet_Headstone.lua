-----------------------------------
-- Area: Western Altepa Desert
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Earth Fragment)
-- !pos -108 10 -216 125
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local function hasAllFragments(player)
    return
        player:hasKeyItem(xi.ki.FIRE_FRAGMENT) and
        player:hasKeyItem(xi.ki.ICE_FRAGMENT) and
        player:hasKeyItem(xi.ki.WIND_FRAGMENT) and
        player:hasKeyItem(xi.ki.EARTH_FRAGMENT) and
        player:hasKeyItem(xi.ki.LIGHTNING_FRAGMENT) and
        player:hasKeyItem(xi.ki.WATER_FRAGMENT) and
        player:hasKeyItem(xi.ki.LIGHT_FRAGMENT) and
        player:hasKeyItem(xi.ki.DARK_FRAGMENT)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(ZILART) == xi.mission.id.zilart.HEADSTONE_PILGRIMAGE then
        if not player:hasKeyItem(xi.ki.EARTH_FRAGMENT) then
            player:startEvent(200, xi.ki.EARTH_FRAGMENT)
        elseif hasAllFragments(player) then
            player:messageSpecial(ID.text.ALREADY_HAVE_ALL_FRAGS)
        elseif player:hasKeyItem(xi.ki.EARTH_FRAGMENT) then
            player:messageSpecial(ID.text.ALREADY_OBTAINED_FRAG, xi.ki.EARTH_FRAGMENT)
        end
    elseif player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE) then
        player:messageSpecial(ID.text.ZILART_MONUMENT)
    else
        player:messageSpecial(ID.text.CANNOT_REMOVE_FRAG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 200 and option == 1 then
        player:addKeyItem(xi.ki.EARTH_FRAGMENT)

        -- Check and see if all fragments have been found (no need to check earth and dark frag)
        if hasAllFragments(player) then
            player:messageSpecial(ID.text.FOUND_ALL_FRAGS, xi.ki.EARTH_FRAGMENT)
            player:addTitle(xi.title.BEARER_OF_THE_EIGHT_PRAYERS)
            player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
        else
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.EARTH_FRAGMENT)
        end
    end
end

return entity
