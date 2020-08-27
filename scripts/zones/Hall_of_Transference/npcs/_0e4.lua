-----------------------------------
-- Area: Hall of Transference
--  NPC: Large Apparatus (Right) - Holla
-- !pos -242.301 -1.849 269.867 14
-----------------------------------
local ID = require("scripts/zones/Hall_of_Transference/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if
        player:getCharVar("HollaChipRegistration") == 0 and
        player:getCharVar("skyShortcut") == 1 and
        trade:hasItemQty(478, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(166)
    end
end

function onTrigger(player, npc)
    if player:getCharVar("HollaChipRegistration") == 1 then
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET + 6) -- Device seems to be functioning correctly.
    else
        player:startEvent(165) -- Hexagonal Cones
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 166 then
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET + 4, 478) -- You fit..
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET + 5)     -- Device has been repaired
        player:setCharVar("HollaChipRegistration", 1)
        player:tradeComplete()
    end
end
