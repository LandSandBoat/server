-----------------------------------
-- Area: Cape Teriggan
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Wind Headstone)
-- !pos -107 -8 450 113
-----------------------------------
local ID = require("scripts/zones/Cape_Teriggan/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
require("scripts/globals/quests")

function onTrade(player, npc, trade)

    -- WANDERING SOULS
    if (trade:hasItemQty(949, 1) and trade:getItemCount() == 1) then
        if (not player:hasCompletedQuest(OUTLANDS, tpz.quest.id.outlands.WANDERING_SOULS) and (player:hasCompletedMission(ZILART, tpz.mission.id.zilart.HEADSTONE_PILGRIMAGE) or player:hasKeyItem(tpz.ki.WIND_FRAGMENT))) then
             player:addQuest(OUTLANDS, tpz.quest.id.outlands.WANDERING_SOULS)
             player:startEvent(202, 949)
        else
             player:messageSpecial(ID.text.NOTHING_HAPPENS)
        end
    end
end

function onTrigger(player, npc)

    -- HEADSTONE PILGRIMAGE
    if (player:getCurrentMission(ZILART) == tpz.mission.id.zilart.HEADSTONE_PILGRIMAGE) then
        if (player:hasKeyItem(tpz.ki.WIND_FRAGMENT)) then
            player:messageSpecial(ID.text.ALREADY_OBTAINED_FRAG, tpz.ki.WIND_FRAGMENT)
        elseif (os.time() >= npc:getLocalVar("cooldown")) then
            if (not GetMobByID(ID.mob.AXESARION_THE_WANDERER):isSpawned()) then
                player:startEvent(200, tpz.ki.WIND_FRAGMENT)
            else
                player:messageSpecial(ID.text.SOMETHING_BETTER)
            end
        else
            player:addKeyItem(tpz.ki.WIND_FRAGMENT)
            if (
                player:hasKeyItem(tpz.ki.FIRE_FRAGMENT) and
                player:hasKeyItem(tpz.ki.ICE_FRAGMENT) and
                player:hasKeyItem(tpz.ki.EARTH_FRAGMENT) and
                player:hasKeyItem(tpz.ki.LIGHTNING_FRAGMENT) and
                player:hasKeyItem(tpz.ki.WATER_FRAGMENT) and
                player:hasKeyItem(tpz.ki.LIGHT_FRAGMENT)
            ) then
                player:messageSpecial(ID.text.FOUND_ALL_FRAGS, tpz.ki.WIND_FRAGMENT)
                player:addTitle(tpz.title.BEARER_OF_THE_EIGHT_PRAYERS)
                player:completeMission(ZILART, tpz.mission.id.zilart.HEADSTONE_PILGRIMAGE)
                player:addMission(ZILART, tpz.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
            else
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WIND_FRAGMENT)
            end
        end

    -- DEFAULT DIALOGS
    elseif (player:hasCompletedMission(ZILART, tpz.mission.id.zilart.HEADSTONE_PILGRIMAGE)) then
        player:messageSpecial(ID.text.ZILART_MONUMENT)
    else
        player:messageSpecial(ID.text.CANNOT_REMOVE_FRAG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    -- HEADSTONE PILGRIMAGE
    if (csid == 200 and option == 1) then
        SpawnMob(ID.mob.AXESARION_THE_WANDERER):updateClaim(player)

    -- WANDERING SOULS
    elseif (csid == 202) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13248)
        else
            player:tradeComplete()
            player:addItem(13248) -- Flagellant's Rope
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13248)
            player:addTitle(tpz.title.BEARER_OF_BONDS_BEYOND_TIME)
            player:completeQuest(OUTLANDS, tpz.quest.id.outlands.WANDERING_SOULS)
        end
    end
end
