-----------------------------------
-- Area: Caedarva Mire
--  NPC: Jazaraat's Headstone
-- Involved in mission: The Lost Kingdom (TOAUM 13)
-- !pos -389 6 -570 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LOST_KINGDOM)) then
        if (not player:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)) then
            player:addKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.EPHRAMADIAN_GOLD_COIN)
        end
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.LOST_KINGDOM) then
        if (player:hasKeyItem(xi.ki.VIAL_OF_SPECTRAL_SCENT) and player:getCharVar("AhtUrganStatus") == 0) then
            player:startEvent(8)
        elseif (player:getCharVar("AhtUrganStatus") == 1) then
            if (not GetMobByID(ID.mob.JAZARAAT):isSpawned()) then
                SpawnMob(ID.mob.JAZARAAT):updateEnmity(player)
            end
        elseif (player:getCharVar("AhtUrganStatus") == 2) then
            player:startEvent(9)
        elseif (player:getCharVar("AhtUrganStatus") == 3) then
            player:setCharVar("AhtUrganStatus", 0)
            player:addKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
            player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LOST_KINGDOM)
            player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_DOLPHIN_CREST)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.EPHRAMADIAN_GOLD_COIN)
        else
            player:messageSpecial(ID.text.JAZARAATS_HEADSTONE)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 8) then
        player:setCharVar("AhtUrganStatus", 1)
    elseif (csid == 9) then
        player:setCharVar("AhtUrganStatus", 3)
    end
end

return entity
