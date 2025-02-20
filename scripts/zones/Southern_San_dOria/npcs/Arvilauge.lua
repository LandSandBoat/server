-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Arvilauge
-- Optional Involvement in Quest: A Squire's Test II
-- !pos -11 1 -94 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO: Use enum, verify this message is relevant
    player:showText(npc, 11076)
end

return entity
