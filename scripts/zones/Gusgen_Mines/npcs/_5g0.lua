-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5g0 (Door C)
-- !pos 44 -42.4 -25.5 196
-----------------------------------
local ID = require("scripts/zones/Gusgen_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (npc:getAnimation() == 9) then
        player:messageSpecial(ID.text.LOCK_OTHER_DEVICE)
    else
        return 0
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
