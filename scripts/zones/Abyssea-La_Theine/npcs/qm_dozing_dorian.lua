-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_dozing_dorian (???)
-- Spawns Dozing Dorian
-- !pos 703 40 283 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_dozing_dorian.lua
entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.DOZING_DORIAN, { xi.items.DRIED_CHIGOE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.DRIED_CHIGOE })
========
entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Dried Chigo", 0xD);
	
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm1.lua
end



entity.onTrade = function(player, npc, trade)
	
	if(trade:hasItemQty(2891,1) and trade:getItemCount() == 1) then -- Dried Chigo
		player:tradeComplete();
		SpawnMob(17318434):updateEnmity(player);
	end
	
end;
return entity