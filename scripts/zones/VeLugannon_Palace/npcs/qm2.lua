-----------------------------------
-- Area: VeLugannon Palace
--  NPC: qm2 (???)
-- Note: Used to spawn Brigandish Blade
-- !pos 0.1 0.1 -286 177
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.CURTANA) and
        npcUtil.popFromQM(player, npc, ID.mob.BRIGANDISH_BLADE)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.EVIL_PRESENCE)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
