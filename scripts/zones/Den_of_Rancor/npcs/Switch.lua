-----------------------------------
-- Area: Den of Rancor
--  NPC: Switch
-- !pos -56 45 40 160
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() > 35 then
        GetNPCByID(ID.npc.DROP_GATE):openDoor() -- drop gate to Sacrificial Chamber
    end
end

return entity
