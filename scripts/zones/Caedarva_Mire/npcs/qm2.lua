-----------------------------------
-- Area: Caedarva Mire
--  NPC: ??? (Spawn Experimental Lamia(ZNM T3))
-- !pos -773 -11 322 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player,npc,trade)
    if npcUtil.tradeHas(trade, 2595) and not GetMobByID(ID.mob.EXPERIMENTAL_LAMIA):isSpawned() then -- Myrrh
        player:confirmTrade()
        SpawnMob(ID.mob.EXPERIMENTAL_LAMIA):updateClaim(player)
    end
end

function onTrigger(player,npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end
