-----------------------------------
-- Area: Al'Taieu
--  NPC: Swirling_Vortex
-- !pos ? ? ? 33
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.SWIRLING_VORTEX_OFFSET
    if offset >= 0 and offset <= 1 then
        player:startEvent(159 + offset)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 160 and option == 1 then
        xi.limbus.enter(player, 1)
    elseif csid == 159 and option == 1 then
        xi.limbus.enter(player, 0)
    end
end

return entity
