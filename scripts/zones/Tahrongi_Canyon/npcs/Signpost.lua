-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Signpost
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = math.floor((npc:getID() - ID.npc.SIGNPOST_OFFSET) / 2)
    player:messageSpecial(ID.text.SIGN_1 + offset)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
