-----------------------------------
-- Area: Windurst Waters
--  NPC: Moogle (Vanaversary_Moogle)
-- Type: Vana'versary Campaign
-- !gotoid 17752428
-----------------------------------
require('scripts/globals/vanaversary')

local entity = {}
local csid = 1169

entity.onTrigger = function(player, npc)
    xi.vanaversary.cofferMoogle(player, csid)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.vanaversary.cofferMoogleEnd(player, csid)
end

return entity
