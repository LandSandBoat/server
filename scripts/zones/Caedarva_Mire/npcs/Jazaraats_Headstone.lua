-----------------------------------
-- Area: Caedarva Mire
--  NPC: Jazaraat's Headstone
-- Involved in mission: The Lost Kingdom (TOAUM 13)
-- !pos -389 6 -570 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasCompletedMission(TOAU, tpz.mission.id.toau.LOST_KINGDOM)) then
        if (not player:hasKeyItem(tpz.ki.EPHRAMADIAN_GOLD_COIN)) then
            player:addKeyItem(tpz.ki.EPHRAMADIAN_GOLD_COIN)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.EPHRAMADIAN_GOLD_COIN)
        end
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.LOST_KINGDOM) then
        if (player:hasKeyItem(tpz.ki.VIAL_OF_SPECTRAL_SCENT) and player:getCharVar("AhtUrganStatus") == 0) then
            player:startEvent(8)
        elseif (player:getCharVar("AhtUrganStatus") == 1) then
            if (not GetMobByID(ID.mob.JAZARAAT):isSpawned()) then
                SpawnMob(ID.mob.JAZARAAT):updateEnmity(player)
            end
        elseif (player:getCharVar("AhtUrganStatus") == 2) then
            player:startEvent(9)
        elseif (player:getCharVar("AhtUrganStatus") == 3) then
            player:setCharVar("AhtUrganStatus", 0)
            player:addKeyItem(tpz.ki.EPHRAMADIAN_GOLD_COIN)
            player:completeMission(TOAU, tpz.mission.id.toau.LOST_KINGDOM)
            player:addMission(TOAU, tpz.mission.id.toau.THE_DOLPHIN_CREST)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.EPHRAMADIAN_GOLD_COIN)
        else
            player:messageSpecial(ID.text.JAZARAATS_HEADSTONE)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 8) then
        player:setCharVar("AhtUrganStatus", 1)
    elseif (csid == 9) then
        player:setCharVar("AhtUrganStatus", 3)
    end
end
