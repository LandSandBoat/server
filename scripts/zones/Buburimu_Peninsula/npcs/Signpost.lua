-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Signpost
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.SIGNPOST_OFFSET
    if (offset >= 4 or offset <= 6) then
        player:messageSpecial(ID.text.SIGN_1)
    elseif (offset >= 0 and offset <= 3) then
        player:messageSpecial(ID.text.SIGN_5 - offset)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
