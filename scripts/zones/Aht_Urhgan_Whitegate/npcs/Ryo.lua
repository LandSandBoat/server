-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ryo
-- Type: ZNM assistant
-- !pos -127.086 0.999 22.693 50
-----------------------------------
require("scripts/globals/besieged")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(913)
end

entity.onEventUpdate = function(player, csid, option)
    if option == 300 then
        player:updateEvent(player:getCurrency("zeni_point"), 0)
    else
        player:updateEvent(0, 0)
    end
end

entity.onEventFinish = function(player, csid, option)
end

return entity
