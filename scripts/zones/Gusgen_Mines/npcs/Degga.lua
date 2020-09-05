-----------------------------------
-- Area: Gusgen Mines
--  NPC: Degga
-- Type: Standard Info NPC
-- !pos 40 -68 -259
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)

end

function onTrigger(player, npc)
    player:startEvent(12) -- i have nothing to say to you standar dialog
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
