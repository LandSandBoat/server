-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_nguruvilu (???)
-- Spawns Nguruvilu
-- !pos 311 23 -524 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_nguruvilu.lua
entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.NGURUVILU, { xi.items.WINTER_PUK_EGG })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.WINTER_PUK_EGG })
========

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Winter Puk Egg", 0xD);
	
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm9.lua
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2899,1)) then -- Winter Puk Egg
        player:tradeComplete();
        SpawnMob(17318442):updateEnmity(player);
    end

end;
return entity
