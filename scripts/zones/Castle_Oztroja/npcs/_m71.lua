-----------------------------------
-- Area: Castle Oztroja
--  NPC: _m71 (Torch Stand)
-- Involved in Mission: Magicite
-- !pos -99 24 -105 151
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.YAGUDO_TORCH) then
        player:startEvent(11) -- TODO: Check if should be startOptionalCutscene(11, { cs_option = 0, canSkip = true })
    else
        player:messageSpecial(ID.text.PROBABLY_WORKS_WITH_SOMETHING_ELSE)
    end
end

return entity
