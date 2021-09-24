-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Chupaile
-- Standard Info NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- This NPC is relevant only to San d'Orians on missions
    player:startEvent(514)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
