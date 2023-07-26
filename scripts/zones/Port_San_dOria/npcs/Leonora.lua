-----------------------------------
-- Area: Port San d'Oria
--  NPC: Leonora
-- Involved in Quest:
-- !pos -24 -8 15 232
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getZPos() >= 12 then
        player:startEvent(518)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
