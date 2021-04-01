-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Light Headstone)
-- !pos 235 0 280 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- HEADSTONE PILGRIMAGE
    if player:getCurrentMission(ZILART) == xi.mission.id.zilart.HEADSTONE_PILGRIMAGE then
        if player:hasKeyItem(xi.ki.LIGHT_FRAGMENT) then
            player:messageSpecial(ID.text.ALREADY_OBTAINED_FRAG, xi.ki.LIGHT_FRAGMENT)
        elseif os.time() >= npc:getLocalVar("cooldown") then
            if not GetMobByID(ID.mob.DOOMED_PILGRIMS):isSpawned() then
                player:startEvent(200, xi.ki.LIGHT_FRAGMENT)
            else
                player:messageSpecial(ID.text.SOMETHING_BETTER)
            end
        else
            player:addKeyItem(xi.ki.LIGHT_FRAGMENT)
            if
                player:hasKeyItem(xi.ki.FIRE_FRAGMENT) and
                player:hasKeyItem(xi.ki.ICE_FRAGMENT) and
                player:hasKeyItem(xi.ki.WIND_FRAGMENT) and
                player:hasKeyItem(xi.ki.EARTH_FRAGMENT) and
                player:hasKeyItem(xi.ki.LIGHTNING_FRAGMENT) and
                player:hasKeyItem(xi.ki.WATER_FRAGMENT)
            then
                player:messageSpecial(ID.text.FOUND_ALL_FRAGS, xi.ki.LIGHT_FRAGMENT)
                player:addTitle(xi.title.BEARER_OF_THE_EIGHT_PRAYERS)
                player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)
                player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
            else
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_FRAGMENT)
            end
        end

    -- SOUL SEARCHING
    elseif player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES) and not player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.SOUL_SEARCHING) then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.SOUL_SEARCHING)
        player:startEvent(202, xi.ki.PRISMATIC_FRAGMENT)

    -- DEFAULT DIALOGS
    elseif player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE) then
        player:messageSpecial(ID.text.ZILART_MONUMENT)
    else
        player:messageSpecial(ID.text.CANNOT_REMOVE_FRAG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- HEADSTONE PILGRIMAGE
    if csid == 200 and option == 1 then
        SpawnMob(ID.mob.DOOMED_PILGRIMS):updateClaim(player)

    -- SOUL SEARCHING
    elseif csid == 202 then
        npcUtil.completeQuest(player, OUTLANDS, xi.quest.id.outlands.SOUL_SEARCHING, {item = 13416, title = xi.title.GUIDER_OF_SOULS_TO_THE_SANCTUARY})
    end
end

return entity
