-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Faurie
-- Chat Text and Zone Exit Menu
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(506)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if option == 0 then
        player:setPos(0, 0, 100, 64, 231)
    end
end

return entity
