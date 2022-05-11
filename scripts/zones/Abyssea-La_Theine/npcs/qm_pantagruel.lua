-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_pantagruel (???)
-- Spawns Pantagruel
-- !pos -356 8 163 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_pantagruel.lua
entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.PANTAGRUEL, { xi.items.OVERSIZED_SOCK })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.OVERSIZED_SOCK })
========
entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Oversized Sock", 0xD);
	
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm5.lua
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2895,1)) then -- Oversized Sock
        player:tradeComplete();
        SpawnMob(17318438):updateClaim(player);
    end

end;
return entity