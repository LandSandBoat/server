-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_lugarhoo (???)
-- Spawns Lugarhoo
-- !pos -85 24 -513 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_lugarhoo.lua
entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LUGARHOO, { xi.items.FILTHY_GNOLE_CLAW })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.FILTHY_GNOLE_CLAW })
========
entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Filthy Gnole Claw", 0xD);
	
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm12.lua
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2902,1)) then -- Filthy Gnole Claw    
        player:tradeComplete();
        SpawnMob(17318445):updateClaim(player);
    end

end;
return entity