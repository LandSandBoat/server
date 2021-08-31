-----------------------------------
-- Area: Escha - Ru'Aun (289)
--  NPC: Undulating Confluence
-- !pos -0.163 -34.106 -471.971 289
-----------------------------------
local ID = require("scripts/zones/Escha_ZiTah/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 1 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.MISAREAUX_CONFLUENCE)
    end
end

return entity
