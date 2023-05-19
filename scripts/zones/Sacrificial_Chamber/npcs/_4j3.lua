-----------------------------------
-- Area: Sacrificial Chamber
--  NPC: Mahogany Door
-- !pos 19 -1 -4 163
-----------------------------------
require("scripts/globals/bcnm")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startOptionalCutscene(32003)
end

entity.onEventUpdate = function(player, csid, option)
    xi.bcnm.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.bcnm.onEventFinish(player, csid, option)
end

return entity
