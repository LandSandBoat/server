-----------------------------------
-- Area: Abyssea - Grauberg
--  NPC: Cavernous Maw
-- !pos -564.000, 30.300, -760.000 254
-- Teleports Players to North Gustaberg
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(-71, 0.001, 601, 126, 106)
    end
end

return entity
