-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Rodin-Comidin
-- Standard Info NPC
-- Involved in Missions: TOAU-41
-- !pos 17.205 -5.999 51.161 50
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(TOAU) == tpz.mission.id.toau.PATH_OF_DARKNESS and player:hasKeyItem(tpz.ki.NYZUL_ISLE_ROUTE) == false then
        player:startEvent(3141, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif player:getCurrentMission(TOAU) == tpz.mission.id.toau.LIGHT_OF_JUDGMENT then
        player:startEvent(3137, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    else
        player:startEvent(665)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 3137 then
        npcUtil.giveKeyItem(player, tpz.ki.NYZUL_ISLE_ROUTE)
        player:completeMission(TOAU, tpz.mission.id.toau.LIGHT_OF_JUDGMENT)
        player:addMission(TOAU, tpz.mission.id.toau.PATH_OF_DARKNESS)
    elseif csid == 3141 then
        npcUtil.giveKeyItem(player, tpz.ki.NYZUL_ISLE_ROUTE)
    end
end
