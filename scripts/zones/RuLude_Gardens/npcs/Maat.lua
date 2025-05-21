-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Maat
-- Starts and Finishes Quest: Limit Break Quest 1-5
-- Involved in Quests: Beat Around the Bushin
-- !pos 8 3 118 243
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('BeatAroundTheBushin') == 5 then
        player:startEvent(117)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 117 then
        player:setCharVar('BeatAroundTheBushin', 6)
    end
end

return entity
