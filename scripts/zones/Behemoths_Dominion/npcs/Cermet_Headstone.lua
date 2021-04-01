-----------------------------------
-- Area: Behemoth's Dominion
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Lightning Headstone)
-- !pos -74 -4 -87 127
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    -- HEADSTONE PILGRIMAGE
    if (player:getCurrentMission(ZILART) == xi.mission.id.zilart.HEADSTONE_PILGRIMAGE) then
        if (player:hasKeyItem(xi.ki.LIGHTNING_FRAGMENT)) then
            player:messageSpecial(ID.text.ALREADY_OBTAINED_FRAG, xi.ki.LIGHTNING_FRAGMENT)
        elseif (os.time() >= npc:getLocalVar("cooldown")) then
            if (not GetMobByID(ID.mob.ANCIENT_WEAPON):isSpawned() and not GetMobByID(ID.mob.LEGENDARY_WEAPON):isSpawned()) then
                player:startEvent(200, xi.ki.LIGHTNING_FRAGMENT)
            else
                player:messageSpecial(ID.text.SOMETHING_BETTER)
            end
        else
            player:addKeyItem(xi.ki.LIGHTNING_FRAGMENT)
            if (
                player:hasKeyItem(xi.ki.FIRE_FRAGMENT) and
                player:hasKeyItem(xi.ki.ICE_FRAGMENT) and
                player:hasKeyItem(xi.ki.WIND_FRAGMENT) and
                player:hasKeyItem(xi.ki.EARTH_FRAGMENT) and
                player:hasKeyItem(xi.ki.WATER_FRAGMENT) and
                player:hasKeyItem(xi.ki.LIGHT_FRAGMENT)
            ) then
                player:messageSpecial(ID.text.FOUND_ALL_FRAGS, xi.ki.LIGHTNING_FRAGMENT)
                player:addTitle(xi.title.BEARER_OF_THE_EIGHT_PRAYERS)
                player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)
                player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
            else
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHTNING_FRAGMENT)
            end
        end

    -- DEFAULT DIALOGS
    elseif (player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)) then
        player:messageSpecial(ID.text.ZILART_MONUMENT)
    else
        player:messageSpecial(ID.text.CANNOT_REMOVE_FRAG)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    -- HEADSTONE PILGRIMAGE
    if (csid == 200 and option == 1) then
        SpawnMob(ID.mob.ANCIENT_WEAPON):updateClaim(player)
        SpawnMob(ID.mob.LEGENDARY_WEAPON):updateClaim(player)
    end
end

return entity
