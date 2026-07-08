-----------------------------------
-- Area: Bhaflau Thickets
--  NPC: Postern (door _1g0)
-- Shortcut back into Aht Urgan Whitegate, North Harbor
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(502)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 502 and option == 1 then
        player:setPos(-37, 1, 56, 0, 50)
    end
end

return entity
