-----------------------------------
-- Area: Southern San d'Oria [S]
--  NPC: Moogle
-----------------------------------
require("scripts/globals/moghouse")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    moogleTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not moogleTrigger(player, npc) then
        player:startEvent(61)
    end
end

entity.onEventUpdate = function(player, csid, option)
    moogleEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    moogleEventFinish(player, csid, option)
end

return entity
