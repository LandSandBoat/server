-----------------------------------
-- Area: Al'Taieu
--  NPC: Rubious Crystal (West Tower)
-- !pos -683.709 -6.250 -222.142 33
-----------------------------------
local ALTAIEU = require("scripts/zones/AlTaieu/globals")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    ALTAIEU.rubiousCrystalOnTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    ALTAIEU.rubiousCrystalOnEventFinish(player, csid, option)
end
