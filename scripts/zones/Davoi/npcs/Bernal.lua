-----------------------------------
-- Area: Davoi
--  NPC: Bernal
-- !pos 177 -3 -127 149
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(30)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 42 and option == 0) then
        player:messageSpecial(ID.text.POWER_OF_THE_ORB_ALLOW_PASS)
    end

end
