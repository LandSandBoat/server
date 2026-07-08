-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Gate of the Gods
-- !pos -20 0.1 -283 34
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(52)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 52 and option == 1 then
        player:setPos(-419.995, 0, 248.483, 191, 35) -- To The Garden of RuHmet
    end
end

return entity
