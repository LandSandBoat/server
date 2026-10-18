-----------------------------------
-- Area: Heavens Tower
--  NPC: Gamimi
-- Type: GOLD WORLD PASS ARBITER
-- !pos 4 0.1 32 242
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.worldPass.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.worldPass.onEventFinish(player, csid, option, npc)
end

return entity
