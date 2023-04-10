-----------------------------------
-- Area: Port Jeuno
--  NPC: Treasure Coffer
-- !pos -52 0 -11 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if
        xi.settings.main.ENABLE_ABYSSEA == 1 and
        not player:hasItem(xi.items.PRISHE_STATUE)
    then
        player:startEvent(350, 0xFFFFFFFC)
    else
        player:messageSpecial(ID.text.CHEST_IS_EMPTY)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 350 and option == 2 then
        npcUtil.giveItem(player, xi.items.PRISHE_STATUE)
    end
end

return entity
