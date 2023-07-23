-----------------------------------
-- Area: South Gustaberg
--  NPC: qm1 (???)
-- Involved in Quest: The Cold Light of Day
-- !pos 744 0 -671 107
-----------------------------------
local ID = require("scripts/zones/South_Gustaberg/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        (npcUtil.tradeHas(trade, xi.items.QUUS) or npcUtil.tradeHas(trade, xi.items.QUUS_F2)) and
        npcUtil.popFromQM(player, npc, ID.mob.BUBBLY_BERNIE, { hide = 0 })
    then
        player:confirmTrade()
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.MONSTER_TRACKS)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
