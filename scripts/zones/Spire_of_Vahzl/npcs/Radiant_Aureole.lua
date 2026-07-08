-----------------------------------
-- Area: Spire of Vahzl
--  NPC: Radiant Aureole
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(15)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 15 and option == 1 then
        player:setPos(-379.947, 48.045, 334.059, 192, 9) -- To Pso'Xja (R)
    end
end

return entity
