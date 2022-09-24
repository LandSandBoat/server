-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm1 (???)
-- !pos 238.524 2.661 -148.784 103
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- NOTE: The NPC is despawned when weather is not up, we do NOT need to check weather.
    npcUtil.giveItem(player, xi.items.PINCH_OF_VALKURM_SUNSAND)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
