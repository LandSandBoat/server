-----------------------------------
-- Area: Al'Taieu
--  NPC: Rubious Crystal (South Tower)
-- !pos 0 -6.250 -736.912 33
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
