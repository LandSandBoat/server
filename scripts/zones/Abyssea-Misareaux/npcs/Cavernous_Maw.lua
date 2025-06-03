-----------------------------------
-- Area: Abyssea - Misareaux
--  NPC: Cavernous Maw
-- !pos 676.070, -16.063, 318.999 216
-- Teleports Players to Valkrum Dunes
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(362, 0.001, -119, 4, 103)
    end
end

return entity
