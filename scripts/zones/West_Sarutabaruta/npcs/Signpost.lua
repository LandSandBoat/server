-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Signpost (18 total)
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local offset = npc:getID() - ID.npc.SIGNPOST_OFFSET
    if offset >= 0 and offset <= 18 then
        player:messageSpecial(ID.text.SIGN_1 + math.floor(offset / 2))
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
