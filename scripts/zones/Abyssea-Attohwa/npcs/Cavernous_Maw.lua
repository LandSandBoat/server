-----------------------------------
-- Area: Abyssea - Attohwa
--  NPC: Cavernous Maw
-- !pos -133.197 20.242 -181.658 215
-- Notes: Teleports Players to Buburimu Peninsula
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(-338, -23, 47, 167, 118)
    end
end

return entity
