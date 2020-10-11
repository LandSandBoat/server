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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- HEADSTONE PILGRIMAGE
    if player:getCurrentMission(ZILART) == tpz.mission.id.zilart.HEADSTONE_PILGRIMAGE then
        if player:hasKeyItem(tpz.ki.LIGHT_FRAGMENT) then
            player:messageSpecial(ID.text.ALREADY_OBTAINED_FRAG, tpz.ki.LIGHT_FRAGMENT)
        elseif os.time() >= npc:getLocalVar("cooldown") then
            if not GetMobByID(ID.mob.DOOMED_PILGRIMS):isSpawned() then
                player:startEvent(200, tpz.ki.LIGHT_FRAGMENT)
            else
                player:messageSpecial(ID.text.SOMETHING_BETTER)
            end
        else
            player:addKeyItem(tpz.ki.LIGHT_FRAGMENT)
            if
                player:hasKeyItem(tpz.ki.FIRE_FRAGMENT) and
                player:hasKeyItem(tpz.ki.ICE_FRAGMENT) and
                player:hasKeyItem(tpz.ki.WIND_FRAGMENT) and
                player:hasKeyItem(tpz.ki.EARTH_FRAGMENT) and
                player:hasKeyItem(tpz.ki.LIGHTNING_FRAGMENT) and
                player:hasKeyItem(tpz.ki.WATER_FRAGMENT)
            then
                player:messageSpecial(ID.text.FOUND_ALL_FRAGS, tpz.ki.LIGHT_FRAGMENT)
                player:addTitle(tpz.title.BEARER_OF_THE_EIGHT_PRAYERS)
                player:completeMission(ZILART, tpz.mission.id.zilart.HEADSTONE_PILGRIMAGE)
                player:addMission(ZILART, tpz.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
            else
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIGHT_FRAGMENT)
            end
        end

    -- SOUL SEARCHING
    elseif player:hasCompletedMission(ZILART, tpz.mission.id.zilart.THE_CHAMBER_OF_ORACLES) and not player:hasCompletedQuest(OUTLANDS, tpz.quest.id.outlands.SOUL_SEARCHING) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.SOUL_SEARCHING)
        player:startEvent(202, tpz.ki.PRISMATIC_FRAGMENT)

    -- DEFAULT DIALOGS
    elseif player:hasCompletedMission(ZILART, tpz.mission.id.zilart.HEADSTONE_PILGRIMAGE) then
        player:messageSpecial(ID.text.ZILART_MONUMENT)
    else
        player:messageSpecial(ID.text.CANNOT_REMOVE_FRAG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- HEADSTONE PILGRIMAGE
    if csid == 200 and option == 1 then
        SpawnMob(ID.mob.DOOMED_PILGRIMS):updateClaim(player)

    -- SOUL SEARCHING
    elseif csid == 202 then
        npcUtil.completeQuest(player, OUTLANDS, tpz.quest.id.outlands.SOUL_SEARCHING, {item = 13416, title = tpz.title.GUIDER_OF_SOULS_TO_THE_SANCTUARY})
    end
end
