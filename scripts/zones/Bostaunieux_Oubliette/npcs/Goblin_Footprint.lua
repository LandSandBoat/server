-----------------------------------
-- Area: Bostaunieux Oubliette
--  NPC: Goblin Footprint
-- Type: NPC
-- !pos  111.806 -24.007 57.266 167
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
