-----------------------------------
-- Area: Meriphataud Mountains [S]
--  NPC: ???
-- !pos 757 -16 -446 97
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains_[S]/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 2566) and
        npcUtil.popFromQM(player, npc, ID.mob.BLOODLAPPER, { hide = 0 })
    then
        -- Gnat Pellets
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
