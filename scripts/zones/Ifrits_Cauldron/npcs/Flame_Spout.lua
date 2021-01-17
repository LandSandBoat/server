-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: Flame Spout
-- !pos 193.967 -0.400 19.492 205
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 4105) then -- Ice Cluster Trade
        player:confirmTrade()
        GetNPCByID(npc:getID() + 5):openDoor(90)
    end
end

function onTrigger(player, npc)
    --[[ Commented out to preserve CSIDs for the quest, since the workaround was removed.
    local offset = npc:getID() - ID.npc.FLAME_SPOUT_OFFSET
    player:startEvent(11 + offset)
    --]]
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
