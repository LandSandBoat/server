-----------------------------------
-- Area: Quicksand Caves
--  NPC: qm2
-- Note: Spawns Tribunus VII-I
-- !pos -49.944 -0.891 -139.485 208
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 1190) and
        npcUtil.popFromQM(player, npc, ID.mob.TRIBUNUS_VII_I)
    then
        -- Antican Tag
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
