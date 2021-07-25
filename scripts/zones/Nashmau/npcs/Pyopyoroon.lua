-----------------------------------
-- Area: Nashmau
--  NPC: Pyopyoroon
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
require("scripts/settings/main")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getCurrentMission(TOAU) == xi.mission.id.toau.ROYAL_PUPPETEER and player:getCharVar("AhtUrganStatus") == 1 and trade:hasItemQty(2307, 1)) then
        player:startEvent(279)
    end
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(TOAU) == xi.mission.id.toau.ROYAL_PUPPETEER and player:getCharVar("AhtUrganStatus") == 0) then
        player:startEvent(277)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.ROYAL_PUPPETEER and player:getCharVar("AhtUrganStatus") == 1) then
        player:startEvent(278)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.LOST_KINGDOM) then
        player:startEvent(280)
    else
        player:startEvent(275)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 277) then
        player:setCharVar("AhtUrganStatus", 1)
    elseif (csid == 279 and player:getCharVar("AhtUrganStatus") == 1) then
        player:setCharVar("AhtUrganStatus", 0)
        player:tradeComplete()
        player:addKeyItem(xi.ki.VIAL_OF_SPECTRAL_SCENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.VIAL_OF_SPECTRAL_SCENT)
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.ROYAL_PUPPETEER)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LOST_KINGDOM)
    end
end

return entity
