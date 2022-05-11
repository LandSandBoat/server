-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_la_theine_liege (???)
-- Spawns La Theine Liege
-- !pos 80 15 199 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_la_theine_liege.lua
entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LA_THEINE_LIEGE, { xi.items.TRANSPARENT_INSECT_WING })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.TRANSPARENT_INSECT_WING })
========
entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Transparent Insect Wing", 0xD);
	
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm7.lua
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2897,1)) then -- Transparent Insect Wing
        player:tradeComplete();
        SpawnMob(17318440):updateClaim(player);
    end

end;
return entity