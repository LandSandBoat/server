-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_baba_yaga (???)
-- Spawns Baba Yaga
-- !pos -74 18 137 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
if(trade:hasItemQty(2898,1)) then -- Piceous Scale
        player:tradeComplete();
        SpawnMob(17318441):updateClaim(player);
    end
	end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2898 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
