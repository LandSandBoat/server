-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_adamastor (???)
-- Spawns Adamastor
-- !pos -716 15 639 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    
    if(trade:hasItemQty(2894,1)) then -- Trophy Shield
        player:tradeComplete();
        SpawnMob(17318437):updateClaim(player);
    end
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2894 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
