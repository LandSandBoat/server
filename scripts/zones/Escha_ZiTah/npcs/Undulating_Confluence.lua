-----------------------------------
-- Area: Escha - Zi'Tah Island (288)
--  NPC: Undulating Confluence
-- !pos --344.275 1.659 -182.613 288
-----------------------------------
local ID = require("scripts/zones/Escha_ZiTah/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(4)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 4 and option == 1 then
        player:setPos(-203, -20, 81, 76, 126)
    end
end
