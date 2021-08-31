-----------------------------------
-- Area: Appolyon
--  NPC: Radiant_Aureole
-- !pos
-----------------------------------
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.RED_CARD) then
        player:setCharVar("ApollyonEntrance", 0)
        TradeBCNM(player, npc, trade)
    else
        player:messageSpecial(ID.text.NO_KEY)
    end
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.RED_CARD) then
        player:setCharVar("ApollyonEntrance", 0)
        EventTriggerBCNM(player, npc)
    else
        player:messageSpecial(ID.text.NO_KEY)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    if EventUpdateBCNM(player, csid, option, extras) then
        local alliance = player:getAlliance()
        for _, member in pairs(alliance) do
            if member:getZoneID() == player:getZoneID() and not member:hasStatusEffect(xi.effect.BATTLEFIELD) and not member:getBattlefield() then
                member:messageSpecial(ID.text.HUM)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option)
    if not EventFinishBCNM(player, csid, option) then
        player:setCharVar("ApollyonEntrance", 0)
    end
end
return entity
