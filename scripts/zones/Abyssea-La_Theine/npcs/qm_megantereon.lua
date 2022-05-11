-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_megantereon (???)
-- Spawns Megantereon
-- !pos -764 -8 121 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_megantereon.lua
entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.MEGANTEREON, { xi.items.GARGANTUAN_BLACK_TIGER_FANG })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.GARGANTUAN_BLACK_TIGER_FANG })
========
entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Black Tiger Fang", 0xD);
	
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm3.lua
end


entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2893,1)) then -- Black Tiger Fang
        player:tradeComplete();
        SpawnMob(17318436):updateClaim(player);
    end

end;
return entity

