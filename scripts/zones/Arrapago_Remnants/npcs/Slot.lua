-----------------------------------
-- Area: Arrapago Remnants
-- NPC: Slot
-- trade card to pop NM
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/npc_util")

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2377) then
        local instance = npc:getInstance()
        SpawnMob(ID.mob[2][2].princess, instance):updateClaim(player)
        player:confirmTrade()
    end
end

function onTrigger(entity, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(entity, eventid, result)
end
