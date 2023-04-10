-- Area: Bhaflau Thickets
--  NPC: ??? (Spawn Lividroot Amooshah(ZNM T2))
-- !pos 334 -10 184 52
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_THICKETS]
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 2578) and
        npcUtil.popFromQM(player, npc, ID.mob.LIVIDROOT_AMOOSHAH)
    then
        -- Trade Oily Blood
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.BLOOD_STAINS)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
