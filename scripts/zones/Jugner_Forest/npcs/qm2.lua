-----------------------------------
-- Area: Jugner Forest
--  NPC: qm2 (???)
-- Involved in Quest: Sin Hunting - RNG AF1
-- !pos -10.946 -1.000 313.810 104
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('sinHunting') == 4 then
        player:startEvent(13, 0, 1107)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 13 then
        player:setCharVar('sinHunting', 5)
    end
end

return entity
