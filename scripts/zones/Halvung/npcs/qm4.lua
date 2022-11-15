-----------------------------------
-- Area: Halvung
--  NPC: ??? (Spawn Achamoth(ZNM T3))
-- !pos -34 10 336 62
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 2586) and
        npcUtil.popFromQM(player, npc, ID.mob.ACHAMOTH)
    then
        -- Trade Rock Juice
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SICKLY_SWEET)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
