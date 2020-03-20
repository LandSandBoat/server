-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: ??? (Spawn Nosferatu(ZNM T3))
-- !pos -199 8 -62 68
-----------------------------------
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player,npc,trade)
    if npcUtil.tradeHas(trade, 2584) and not GetMobByID(ID.mob.NOSFERATU):isSpawned() then -- Pure Blood
        player:confirmTrade()
        SpawnMob(ID.mob.NOSFERATU):updateClaim(player)
    end
end

function onTrigger(player,npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end
