-----------------------------------
-- Area: West Sarutabaruta
-- NPC: Fuahah
-- !pos -339.464 2.750 -377.699
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getLocalVar('spokenFuahah') == 0 then
        player:setLocalVar('spokenFuahah', 1)
        return player:messageText(npc, ID.text.COME_FROM_THE_ORASTERY)
    else
        player:setLocalVar('spokenFuahah', 0)
        return player:messageText(npc, ID.text.FERAL_CARDIANS)
    end
end

return entity
