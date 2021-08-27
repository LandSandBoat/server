-----------------------------------
-- Area: Caedarva Mire
-- Door: Heavy Iron Gate
-- !pos -299 -6 -80 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) then
        player:messageSpecial(ID.text.CANNOT_LEAVE, xi.ki.PERIQIA_ASSAULT_ORDERS)
    elseif player:getZPos() <= -79.1 and player:getZPos() >= -82 then
        player:messageSpecial(ID.text.STAGING_POINT_DVUCCA)
        player:messageSpecial(ID.text.IMPERIAL_CONTROL)
        player:startEvent(122)
    elseif player:getZPos() >= -77.8 and player:getZPos() <= -75 then
        player:messageSpecial(ID.text.STAGING_POINT_DVUCCA)
        player:messageSpecial(ID.text.IMPERIAL_CONTROL)
        player:startEvent(123)
    else
        player:messageSpecial(ID.text.MOVE_CLOSER)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
--[[    if csid == 122 and option == 0 then
        Todo add function that when entering staging point that a player looses all agro on mobs
    end]]
end

return entity
