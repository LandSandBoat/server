-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_grandgousier (???)
-- Spawns Grandgousier
-- !pos -398 .010 -322 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_grandgousier.lua
entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.GRANDGOUSIER, { xi.items.MASSIVE_ARMBAND })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.MASSIVE_ARMBAND })
========
entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Massive Armband", 0xD);
	
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm6.lua
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2896,1)) then -- Massive Armband
        player:tradeComplete();
        SpawnMob(17318439):updateClaim(player);
    end

end;
return entity
