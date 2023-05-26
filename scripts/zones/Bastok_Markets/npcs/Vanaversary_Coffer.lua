-----------------------------------
-- Area: Bastok Markets
--  NPC: Treasure Coffer (Vanaversary_Coffer)
-- Type: Vana'versary Campaign
-- !gotoid 17740080
-----------------------------------
require('scripts/globals/vanaversary')

local entity = {}
local csid = 560

entity.onTrigger = function(player, npc)
    xi.vanaversary.treasureCoffer(player, csid)
end

entity.onEventUpdate = function(player, csid, option)
    xi.vanaversary.treaureCofferGoods(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
