-----------------------------------
-- Area: Al'Taieu
--  NPC: Rubious Crystal (East Tower)
-- !pos 683.718 -6.250 -222.167 33
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
