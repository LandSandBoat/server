-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_baba_yaga (???)
-- Spawns Baba Yaga
-- !pos -74 18 137 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_baba_yaga.lua
entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BABA_YAGA, { xi.items.PICEOUS_SCALE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.PICEOUS_SCALE })
========
entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Piceous Scale", 0xD);
	
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm8.lua
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2898,1)) then -- Piceous Scale
        player:tradeComplete();
        SpawnMob(17318441):updateClaim(player);
    end

end;
return entity
