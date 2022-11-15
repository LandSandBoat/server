-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: ??? (Spawn Tinnin(ZNM T4))
-- !pos 278 0 -703 51
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 2573) and
        npcUtil.popFromQM(player, npc, ID.mob.TINNIN)
    then
        -- Trade Monkey Wine
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.HEADY_FRAGRANCE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
