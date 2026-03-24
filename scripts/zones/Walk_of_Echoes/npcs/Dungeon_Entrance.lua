-----------------------------------
-- Area: Walk of Echoes
--  NPC: Dungeon Master (dynamic entity)
-- Pos:  -406.906, 14.000, -60.399  rotation 194  zone 182
-- Role: Entry gate for the First Walk battlefield (id 3000).
--
-- NOTE: This NPC is spawned via zone:insertDynamicEntity() in Zone.lua.
--       The Battlefield engine (echoes_challenge.lua) registers 'Dungeon Master'
--       as the entryNpc for xi.battlefield.id.FIRST_WALK.
--       Handlers here are kept for reference; Zone.lua's inline handlers take effect.
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    Battlefield.onEntryTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    Battlefield.onEntryTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
