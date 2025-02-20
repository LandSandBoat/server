-----------------------------------
-- Area: Upper Jeuno
--  NPC: Osker
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local aNewDawnEvent = player:getCharVar('ANewDawn_Event')

    if
        trade:hasItemQty(xi.item.PIECE_OF_MAHOGANY_LUMBER, 1) and
        trade:getItemCount() == 1 and
        aNewDawnEvent == 3
    then
        player:tradeComplete()
        player:startEvent(148)
    end
end

entity.onTrigger = function(player, npc)
    local aNewDawn = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN)
    local aNewDawnEvent = player:getCharVar('ANewDawn_Event')

    -- A New Dawn
    if aNewDawn == xi.questStatus.QUEST_ACCEPTED then
        if aNewDawnEvent == 2 or aNewDawnEvent == 3 then
            player:startEvent(146)
        elseif aNewDawnEvent >= 4 then
            player:startEvent(147)
        end

    elseif aNewDawn == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(145)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local aNewDawnEvent = player:getCharVar('ANewDawn_Event')

    if csid == 146 then
        if aNewDawnEvent == 2 then
            player:setCharVar('ANewDawn_Event', 3)
        end
    elseif csid == 148 then
        npcUtil.giveKeyItem(player, xi.ki.TAMERS_WHISTLE)
        player:setCharVar('ANewDawn_Event', 4)
    end
end

return entity
