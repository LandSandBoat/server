-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: ??? (Spawn Vulpangue(ZNM T1))
-- !pos -697 -7 -123 51
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.HELLCAGE_BUTTERFLY) and
        npcUtil.popFromQM(player, npc, ID.mob.VULPANGUE)
    then
        -- Trade Hellcage Butterfly
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.BROKEN_SHARDS)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
