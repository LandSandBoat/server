-----------------------------------
-- Area: Kazham
--  NPC: Romaa Mihgo
-- !pos 29.000 -13.023 -176.500 250
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local tuningOutProgress = player:getCharVar('TuningOut_Progress')

    if tuningOutProgress == 2 then
        player:startEvent(295) -- Ildy meets Romaa. Romaa tells player to go to waterfall
    elseif tuningOutProgress == 3 or tuningOutProgress == 4 then
        player:startEvent(296) -- Repeats hint to go to waterfall
    elseif tuningOutProgress == 5 then
        player:startEvent(297, 0, 1695, 4297, 4506) -- After fight with the Nasus. Mentions guard needs Habaneros, Black Curry, Mutton Tortilla
    elseif tuningOutProgress == 6 then
        player:startEvent(298, 0, 1695, 4297, 4506) -- Repeats guard need for Habaneros, Black Curry, Mutton Tortilla
    else
        player:startEvent(263)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 295 then
        player:setCharVar('TuningOut_Progress', 3)
    elseif csid == 297 then
        player:setCharVar('TuningOut_Progress', 6)
    end
end

return entity
