-----------------------------------
-- Area: Buburimu Peninsula
-- NPC:  Signpost
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local offset = npc:getID() - ID.npc.SIGNPOST_OFFSET
    if (offset >= 4 or offset <= 6) then
        player:messageSpecial(ID.text.SIGN_1)
    elseif (offset >= 0 and offset <= 3) then
        player:messageSpecial(ID.text.SIGN_5 - offset)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
