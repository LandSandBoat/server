-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_trudging_thomas (???)
-- Spawns Trudging Thomas
-- !pos 278 24 -82 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
     if(trade:hasItemQty(2892,1)) then -- Mutton Chop
        player:tradeComplete();
        SpawnMob(17318435):updateClaim(player);
    end
end
entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2892 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
