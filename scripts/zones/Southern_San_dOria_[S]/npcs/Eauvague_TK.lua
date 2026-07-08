-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Eauvague T.K
-- !pos 105 0 -53 80
-- Gate Guard
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(94, -62, 266, 40, 81)
    end
end

return entity
