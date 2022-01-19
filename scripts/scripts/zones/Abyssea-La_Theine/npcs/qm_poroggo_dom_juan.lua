-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_poroggo_dom_juan (???)
-- Spawns Poroggo Dom Juan
-- !pos 405.785 26.404 -543.056 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
   if(trade:hasItemQty(2900,1)) then -- Bug-eaten Hat
        player:tradeComplete();
        SpawnMob(17318443):updateClaim(player);
    end

end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2900 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
