-----------------------------------
-- Area: Abyssea - Tahrongi
--  NPC: Cavernous Maw
-- !pos -31.000, 47.000, -681.000 45
-- Teleports Players to Tahrongi Canyon
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(-28, 46, -680, 76, 117)
    end
end

return entity
