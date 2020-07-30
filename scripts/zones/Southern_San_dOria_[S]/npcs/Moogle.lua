-----------------------------------
-- Area: Southern San d'Oria [S]
--  NPC: Moogle
-----------------------------------
require("scripts/globals/moghouse")
-----------------------------------

function onTrade(player, npc, trade)
    moogleTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not moogleTrigger(player, npc) then
        player:startEvent(61)
    end
end

function onEventUpdate(player, csid, option)
    moogleEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    moogleEventFinish(player, csid, option)
end
