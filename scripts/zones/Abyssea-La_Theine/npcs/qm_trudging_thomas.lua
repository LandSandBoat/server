-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_trudging_thomas (???)
-- Spawns Trudging Thomas
-- !pos 278 24 -82 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_trudging_thomas.lua
entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TRUDGING_THOMAS, { xi.items.RAW_MUTTON_CHOP })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.RAW_MUTTON_CHOP })
========
entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Mutton Chop", 0xD);
	
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm2.lua
end




entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2892,1)) then -- Mutton Chop
        player:tradeComplete();
        SpawnMob(17318435):updateClaim(player);
    end

end;
return entity
