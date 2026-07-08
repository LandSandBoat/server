-----------------------------------
-- Area: Norg
--  NPC: Comitiolus
-- !pos 100 -7 -13 252
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, { 1695, 4297, 4506 }) and -- Habaneros, Black Curry, Mutton Tortilla
        player:getCharVar('TuningOut_Progress') == 6
    then
        player:startEvent(207, 0, 1695) -- Receives spicy food, mentions only one of them
    end
end

entity.onTrigger = function(player, npc)
    local tuningOutProgress = player:getCharVar('TuningOut_Progress')

    if tuningOutProgress == 6 then
        player:startEvent(206) -- Declines request to speak to Kamui
    elseif tuningOutProgress == 7 then
        player:startEvent(208) -- Repeat hint for player to go to Beaucedine Glacier
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 207 then
        player:tradeComplete()
        player:setCharVar('TuningOut_Progress', 7)
    end
end

return entity
