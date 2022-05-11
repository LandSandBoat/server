-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_toppling_tuber (???)
-- Spawns Toppling Tuber
-- !pos -325 38 201 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_toppling_tuber.lua
entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TOPPLING_TUBER, { xi.items.GIANT_AGARICUS_MUSHROOM })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.GIANT_AGARICUS_MUSHROOM })
========
entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Giant Agaricus  ", 0xD);
	
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm11.lua
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2901,1)) then -- Giant Agaricus  
        player:tradeComplete();
        SpawnMob(17318444):updateClaim(player);
    end

end;
return entity