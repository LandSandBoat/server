-----------------------------------
-- Area: Lower Delkfutt's Tower
--  NPC: Cermet Door
-- Notes: Leads to Upper Delkfutt's Tower.
-- !pos 524 16 20 184
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(20)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 20 and option == 1 then
        player:setPos(314.053, 16, 19.944, 128, xi.zone.UPPER_DELKFUTTS_TOWER)
    end
end

return entity
