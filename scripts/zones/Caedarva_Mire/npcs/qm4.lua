-----------------------------------
-- Area: Caedarva Mire
--  NPC: ??? (Spawn Tyger(ZNM T4))
-- !pos -766 -12 632 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player,npc,trade)
    if npcUtil.tradeHas(trade, 2593) and not GetMobByID(ID.mob.TYGER):isSpawned() then -- Singed Buffalo
        player:confirmTrade()
        SpawnMob(ID.mob.TYGER):updateClaim(player)
    end
end

function onTrigger(player,npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end
