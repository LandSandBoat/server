-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Darcia
--  SoA: Mission NPC
-- !pos 25 -38.617 -1.000
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_SOA == 0 then
        player:startEvent(10124)
    else
        player:startEvent(10123)
    end
end

return entity
