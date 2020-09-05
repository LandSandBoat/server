-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Coullene
-- Type: Involved in Quest (Flyers for Regine)
-- !pos 146.420 0.000 127.601 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/quests/flyers_for_regine")
-----------------------------------

function onTrade(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 5) -- FLYERS FOR REGINE
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.COULLENE_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
