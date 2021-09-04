-----------------------------------
-- Area: Abyssea - Grauberg
--  NPC: Dominion Sergeant
-----------------------------------
require("scripts/globals/abyssea/dominion")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

-- onTrigger Parameters
-- Parameter 1:
-- Parameter 2:
-- Parameter 3:
-- Parameter 4:
-- Parameter 5: bit.rshift(param, 1) -> Bitmask, 1 disables, 0 enables (1..14)

entity.onTrigger = function(player, npc)
    xi.abyssea.sergeantOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.sergeantOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.sergeantOnEventFinish(player, csid, option, npc)
end

return entity
