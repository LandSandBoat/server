-----------------------------------
-- Area: Castle Oztroja
--  NPC: _m70 (Torch Stand)
-- Involved in Mission: Magicite
-- !pos -97.134 24.250 -105.979 151
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.YAGUDO_TORCH) then
        player:startEvent(11)
    else
        player:messageSpecial(ID.text.PROBABLY_WORKS_WITH_SOMETHING_ELSE)
    end
end

return entity
