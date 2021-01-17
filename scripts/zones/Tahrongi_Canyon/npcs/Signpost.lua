-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Signpost
-----------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = math.floor((npc:getID() - ID.npc.SIGNPOST_OFFSET) / 2)
    player:messageSpecial(ID.text.SIGN_1 + offset)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
