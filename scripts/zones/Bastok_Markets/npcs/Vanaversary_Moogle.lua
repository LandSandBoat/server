-----------------------------------
-- Area: Bastok Markets
--  NPC: Moogle (Vanaversary_Moogle)
-- Type: Vana'versary Campaign
-- !gotoid 17740022
-----------------------------------
require('scripts/globals/vanaversary')

local entity = {}

entity.onTrigger = function(player, npc)
    local csid = 689
    xi.vanaversary.cofferMoogle(player, csid)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.vanaversary.cofferMoogleEnd(player, csid)
end

return entity
