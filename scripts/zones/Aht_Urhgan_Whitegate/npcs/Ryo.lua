-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ryo
-- Type: ZNM assistant
-- !pos -127.086 0.999 22.693 50
-----------------------------------
require("scripts/globals/besieged")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(913)
end

function onEventUpdate(player, csid, option)
    if option == 300 then
        player:updateEvent(player:getCurrency("zeni_point"), 0)
    else
        player:updateEvent(0, 0)
    end
end

function onEventFinish(player, csid, option)
end
