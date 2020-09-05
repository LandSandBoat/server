-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: Goblin Footprint
-- Type: NPC
-- !pos  -129.021 -25.127 -601.431 119
-----------------------------------
require("scripts/globals/goblinfootprint")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.goblinfootprint.rewatch(player)
end

function onTrigger(player, npc)
    tpz.goblinfootprint.rewatch(player, true)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.goblinfootprint.startEvent(player, csid, option)
end
