-----------------------------------
-- Area: Windurst Woods
--  NPC: Gioh Ajihri
-- Starts & Finishes Repeatable Quest: Twinstone Bonding
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('GiohAijhriSpokenTo') == 1 and
        not player:needToZone() and
        npcUtil.tradeHas(trade, xi.item.TWINSTONE_EARRING)
    then
        player:startEvent(490)
    end
end

entity.onTrigger = function(player, npc)
    local twinstoneBonding = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING)

    if twinstoneBonding == xi.questStatus.QUEST_COMPLETED then
        if player:needToZone() then
            player:startEvent(491, 0, xi.item.TWINSTONE_EARRING)
        else
            player:startEvent(488, 0, xi.item.TWINSTONE_EARRING)
        end
    elseif twinstoneBonding == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(488, 0, xi.item.TWINSTONE_EARRING)
    elseif
        twinstoneBonding == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 2
    then
        player:startEvent(487, 0, xi.item.TWINSTONE_EARRING)
    else
        player:startEvent(424)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 487 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING)
        player:setCharVar('GiohAijhriSpokenTo', 1)
    elseif csid == 490 then
        player:confirmTrade()
        player:needToZone(true)
        player:setCharVar('GiohAijhriSpokenTo', 0)

        if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING) == xi.questStatus.QUEST_ACCEPTED then
            npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING, { item = 17154, fame = 80, fameArea = xi.fameArea.WINDURST, title = xi.title.BOND_FIXER })
        else
            player:addFame(xi.fameArea.WINDURST, 10)
            npcUtil.giveCurrency(player, 'gil', 900)
        end
    elseif csid == 488 then
        player:setCharVar('GiohAijhriSpokenTo', 1)
    end
end

return entity
