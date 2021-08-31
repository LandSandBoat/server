-----------------------------------
-- Area: Misareaux Coast (25)
--  NPC: Undulating Confluence
-- !pos --48.908 -23.302 572.269 25
-----------------------------------
local ID = require("scripts/zones/Misareaux_Coast/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(14)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 14 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.ESCHA_RUAUN)
    end
end

return entity
