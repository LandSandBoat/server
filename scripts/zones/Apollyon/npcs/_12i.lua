-----------------------------------
-- Area: Appolyon
--  NPC: Radiant_Aureole
-- !pos
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
        player:hasKeyItem(xi.ki.BLACK_CARD)
    then
        player:setCharVar("ApollyonEntrance", 1)
        xi.bcnm.onTrade(player, npc, trade)
    else
        player:messageSpecial(ID.text.NO_KEY)
    end
end

entity.onTrigger = function(player, npc)
    if
        player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
        player:hasKeyItem(xi.ki.BLACK_CARD)
    then
        player:setCharVar("ApollyonEntrance", 1)
        xi.bcnm.onTrigger(player, npc)
    else
        player:messageSpecial(ID.text.NO_KEY)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    if xi.bcnm.onEventUpdate(player, csid, option, extras) then
        local alliance = player:getAlliance()

        for _, member in pairs(alliance) do
            if
                member:getZoneID() == player:getZoneID() and
                not member:hasStatusEffect(xi.effect.BATTLEFIELD) and
                not member:getBattlefield()
            then
                member:messageSpecial(ID.text.HUM)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option)
    if not xi.bcnm.onEventFinish(player, csid, option) then
        player:setCharVar("ApollyonEntrance", 0)
    end
end

return entity
