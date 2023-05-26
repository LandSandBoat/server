-----------------------------------
-- Area: Bastok Markets
--  NPC: Moogle (History_Moogle)
-- Type: Vana'versary Campaign
-- !gotoid 17740020
-----------------------------------
require('scripts/globals/vanaversary')

local entity = {}
local csid = 32757

entity.onTrigger = function(player, npc)
    xi.vanaversary.historyMoogle(player, csid)
end

entity.onEventUpdate = function(player, csid, option)
    xi.vanaversary.historyMoogleUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
