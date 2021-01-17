-----------------------------------
-- Area: Escha - Zi'Tah Island (288)
--  NPC: Undulating Confluence
-- !pos --344.275 1.659 -182.613 288
-----------------------------------
local ID = require("scripts/zones/Escha_ZiTah/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(4)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 4 and option == 1 then
        player:setPos(-203, -20, 81, 76, 126)
    end
end

return entity
