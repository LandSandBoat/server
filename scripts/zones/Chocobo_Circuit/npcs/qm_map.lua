-----------------------------------
-- Area: Chocobo Circuit
--  NPC: ??? (Map of the Chocobo Circuit)
-----------------------------------
local ID = zones[xi.zone.CHOCOBO_CIRCUIT]
-----------------------------------
---@type TNpcEntity
local entity = {}

local events = { 261, 344 }

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.keyItem.MAP_OF_THE_CHOCOBO_CIRCUIT) then
        player:messageSpecial(ID.text.ALREADY_POSSESS, xi.keyItem.MAP_OF_THE_CHOCOBO_CIRCUIT, 0, 6)
        return
    end

    player:messageSpecial(ID.text.FIND_ON_COUNTER, xi.keyItem.MAP_OF_THE_CHOCOBO_CIRCUIT)
    player:startEvent(events[npc:getID() - ID.npc.QM_MAP_OFFSET + 1], xi.keyItem.MAP_OF_THE_CHOCOBO_CIRCUIT)
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        npcUtil.giveKeyItem(player, xi.keyItem.MAP_OF_THE_CHOCOBO_CIRCUIT)
    end
end

return entity
