-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Fire Fragment)
-- !pos 491 20 301 123
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- WRATH OF THE OPO-OPOS
    if npcUtil.tradeHas(trade, 790) then
        if not player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.WRATH_OF_THE_OPO_OPOS) and (player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE) or player:hasKeyItem(xi.ki.FIRE_FRAGMENT)) then
            player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.WRATH_OF_THE_OPO_OPOS)
            player:startEvent(202, 790)
        else
            player:messageSpecial(ID.text.NOTHING_HAPPENS)
        end
    end
end

entity.onTrigger = function(player, npc)
    -- HEADSTONE PILGRIMAGE
    if player:getCurrentMission(ZILART) == xi.mission.id.zilart.HEADSTONE_PILGRIMAGE then
        if player:hasKeyItem(xi.ki.FIRE_FRAGMENT) then
            player:messageSpecial(ID.text.ALREADY_OBTAINED_FRAG, xi.ki.FIRE_FRAGMENT)
        elseif os.time() >= npc:getLocalVar("cooldown") then
            if not GetMobByID(ID.mob.TIPHA):isSpawned() and not GetMobByID(ID.mob.CARTHI):isSpawned() then
                player:startEvent(200, xi.ki.FIRE_FRAGMENT)
            else
                player:messageSpecial(ID.text.SOMETHING_BETTER)
            end
        else
            player:addKeyItem(xi.ki.FIRE_FRAGMENT)
            if
                player:hasKeyItem(xi.ki.ICE_FRAGMENT) and
                player:hasKeyItem(xi.ki.WIND_FRAGMENT) and
                player:hasKeyItem(xi.ki.EARTH_FRAGMENT) and
                player:hasKeyItem(xi.ki.LIGHTNING_FRAGMENT) and
                player:hasKeyItem(xi.ki.WATER_FRAGMENT) and
                player:hasKeyItem(xi.ki.LIGHT_FRAGMENT)
            then
                player:messageSpecial(ID.text.FOUND_ALL_FRAGS, xi.ki.FIRE_FRAGMENT)
                player:addTitle(xi.title.BEARER_OF_THE_EIGHT_PRAYERS)
                player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)
                player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
            else
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.FIRE_FRAGMENT)
            end
        end

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
        SpawnMob(ID.mob.TIPHA):updateClaim(player)
        SpawnMob(ID.mob.CARTHI):updateClaim(player)

    -- WRATH OF THE OPO-OPOS
    elseif csid == 202 and npcUtil.completeQuest(player, OUTLANDS, xi.quest.id.outlands.WRATH_OF_THE_OPO_OPOS, {item=13143, title= xi.title.FRIEND_OF_THE_OPOOPOS}) then
        player:confirmTrade()
    end
end

return entity
