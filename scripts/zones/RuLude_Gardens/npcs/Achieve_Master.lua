-----------------------------------
-- Area: Ru'Lude Gardens
-- NPC: Achieve Master
-- !pos -13.2891 1.99960 132.3310
-----------------------------------
require("modules/custom/lua/Fail_Badge_Quest")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.failBadge.onTriggerRulude(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity