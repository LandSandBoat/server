-----------------------------------
-- Area: Windurst Woods
--  NPC: Tapoh Lihzeh
-- Starts & Finishes Repeatable Quest: Paying Lip Service
-- !pos 51.011 -3.749 54.402 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- CHOCOBILIOUS
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('ChocobiliousQuest') == 1 and
        npcUtil.tradeHas(trade, xi.item.PAPAKA_GRASS)
    then
        player:startEvent(229, 0, xi.item.PAPAKA_GRASS)

    -- PAYING LIP SERVICE
    elseif player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.PAYING_LIP_SERVICE) >= xi.questStatus.QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, { { xi.item.BEEHIVE_CHIP, 3 } }) then -- beehive_chip
            player:startEvent(479, 0, xi.item.BEEHIVE_CHIP, xi.item.REMI_SHELL, 0, 0)
        elseif npcUtil.tradeHas(trade, { { xi.item.REMI_SHELL, 2 } }) then -- remi_shell
            player:startEvent(479, 0, xi.item.BEEHIVE_CHIP, xi.item.REMI_SHELL, 0, 1)
        end
    end
end

entity.onTrigger = function(player, npc)
    local chocobilious = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS)
    local chocobiliousCS = player:getCharVar('ChocobiliousQuest')
    local payingLipService = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.PAYING_LIP_SERVICE)

    -- CHOCOBILIOUS
    if chocobilious == xi.questStatus.QUEST_ACCEPTED and chocobiliousCS == 2 then
        player:startEvent(230) -- after trading
    elseif chocobilious == xi.questStatus.QUEST_ACCEPTED and chocobiliousCS == 1 then
        player:startEvent(228, 0, xi.item.PAPAKA_GRASS) -- after first talk
    elseif chocobilious == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(227, 0, xi.item.PAPAKA_GRASS) -- first talk

    -- PAYING LIP SERVICE
    elseif payingLipService == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(478, 0, xi.item.BEEHIVE_CHIP, xi.item.REMI_SHELL, xi.settings.main.GIL_RATE * 150, xi.settings.main.GIL_RATE * 200)
    elseif payingLipService == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(477, 0, xi.item.BEEHIVE_CHIP, xi.item.REMI_SHELL, xi.settings.main.GIL_RATE * 150, xi.settings.main.GIL_RATE * 200)

    -- STANDARD DIALOG
    else
        player:startEvent(437)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- CHOCOBILIOUS
    if csid == 227 then
        player:setCharVar('ChocobiliousQuest', 1)
    elseif csid == 229 then
        player:setCharVar('ChocobiliousQuest', 2)

    -- PAYING LIP SERVICE
    elseif csid == 477 and option == 1 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.PAYING_LIP_SERVICE)
    elseif csid == 479 then
        if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.PAYING_LIP_SERVICE) == xi.questStatus.QUEST_ACCEPTED then
            npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.PAYING_LIP_SERVICE, { fame = 60, title = xi.title.KISSER_MAKE_UPPER })
        else
            player:addFame(xi.fameArea.WINDURST, 8)
        end

        if option == 1 then
            npcUtil.giveCurrency(player, 'gil', 150)
        else
            npcUtil.giveCurrency(player, 'gil', 200)
        end

        player:confirmTrade()
    end
end

return entity
