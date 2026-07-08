-----------------------------------
-- Area: Tavnazian_Safehold
--  NPC: Hieroglyphics
-- Notes: Dynamis Tavnazia Enter
-- !pos 3.674 -7.278 -27.856 26
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.dynamis.entryNpcOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.dynamis.entryNpcOnEventFinish(player, csid, option, npc)
end

return entity
