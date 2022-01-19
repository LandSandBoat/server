-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_megantereon (???)
-- Spawns Megantereon
-- !pos -764 -8 121 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
  if(trade:hasItemQty(2893,1)) then -- Black Tiger Fang
        player:tradeComplete();
        SpawnMob(17318436):updateClaim(player);
    end
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2893 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
