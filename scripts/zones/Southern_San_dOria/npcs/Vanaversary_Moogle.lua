-----------------------------------
-- Area: Southern San dOria
--  NPC: Moogle (Vanaversary_Moogle)
-- Type: Vana'versary Campaign
-- !gotoid 17719721
-----------------------------------
require('scripts/globals/vanaversary')

local entity = {}
local csid = 3630

entity.onTrigger = function(player, npc)
    xi.vanaversary.cofferMoogle(player, csid)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.vanaversary.cofferMoogleEnd(player, csid)
end

return entity
