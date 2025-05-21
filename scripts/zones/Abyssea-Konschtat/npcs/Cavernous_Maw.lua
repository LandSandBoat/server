-----------------------------------
-- Area: Abyssea - Konschatat
--  NPC: Cavernous Maw
-- !pos 159.943 -72.109 -839.986 15
-- Teleports Players to Konschatat Highlands
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(91, -68, -582, 237, 108)
    end
end

return entity
