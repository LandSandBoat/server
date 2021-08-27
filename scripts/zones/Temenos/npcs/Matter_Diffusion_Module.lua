-----------------------------------
-- Area: temenos
--  NPC: Matter diffusion module
-- !pos
-----------------------------------
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Temenos/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD) then
        TradeBCNM(player, npc, trade)
    else
        player:messageSpecial(ID.text.NO_KEY)
    end
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD) then
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
    EventFinishBCNM(player, csid, option)
end

return entity
