-----------------------------------
-- Area: Windurst Waters
--  NPC: Treasure Coffer (Vanaversary_Coffer)
-- Type: Vana'versary Campaign
-- !gotoid 17752486
-----------------------------------
require('scripts/globals/vanaversary')

local entity = {}

entity.onTrigger = function(player, npc)
    local csid = 1033
    xi.vanaversary.treasureCoffer(player, csid)
end

entity.onEventUpdate = function(player, csid, option)
    xi.vanaversary.treaureCofferGoods(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
