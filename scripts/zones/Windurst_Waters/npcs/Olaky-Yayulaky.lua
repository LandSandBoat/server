-----------------------------------
-- Area: Windurst Waters
--  NPC: Olaky-Yayulaky
-- Type: Event Storage NPC
--  !pos -60 -3.5 71 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.eventStorage.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.eventStorage.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.eventStorage.onEventFinish(player, csid, option, npc)
end

return entity
