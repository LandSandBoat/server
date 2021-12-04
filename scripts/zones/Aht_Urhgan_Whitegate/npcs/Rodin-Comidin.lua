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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(TOAU) == xi.mission.id.toau.PATH_OF_DARKNESS and player:hasKeyItem(xi.ki.NYZUL_ISLE_ROUTE) == false then
        player:startEvent(3141, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    else
        player:startEvent(665)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 3141 then
        npcUtil.giveKeyItem(player, xi.ki.NYZUL_ISLE_ROUTE)
    end
end

return entity
