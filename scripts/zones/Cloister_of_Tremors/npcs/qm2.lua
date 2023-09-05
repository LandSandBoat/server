-----------------------------------
-- Area: Cloister of Tremors
--  NPC: qm2 (???)
-- Involved in Quest: Open Sesame
-- Notes: Used to obtain a Tremor Stone
-- !pos -545.184, 1.855, -495.693 209
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_ABYSSEA == 1 then
        npcUtil.giveItem(player, xi.items.TREMORSTONE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
