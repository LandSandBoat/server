-----------------------------------
-- Area: Castle Oztroja
--  NPC: _m71 (Torch Stand)
-- Involved in Mission: Magicite
-- !pos -99 24 -105 151
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.YAGUDO_TORCH) then
        player:startEvent(11)
    else
        player:messageSpecial(ID.text.PROBABLY_WORKS_WITH_SOMETHING_ELSE)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
