-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Signpost (18 total)
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.SIGNPOST_OFFSET
    if offset >= 0 and offset <= 18 then
        player:messageSpecial(ID.text.SIGN_1 + math.floor(offset / 2))
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
