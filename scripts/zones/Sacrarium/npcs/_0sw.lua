-----------------------------------
-- Area: Sacrarium
--  NPC: _0sw (Reliquiarium Gate)
-- !pos 23.447 -1.563 50.941 28
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
-----------------------------------

function onTrigger(player, npc)

    if (player:getZPos() < 52) then
        player:messageSpecial(ID.text.STURDY_GATE)
    else
        player:messageSpecial(ID.text.KEYHOLE_DAMAGED)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
