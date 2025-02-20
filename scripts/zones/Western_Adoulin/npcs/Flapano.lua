-----------------------------------
-- Area: Western Adoulin
--  NPC: Flapno
-- !pos 70 0 -13 256
-----------------------------------
local ID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local exoticDelicacies = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.EXOTIC_DELICACIES)

    -- ALL THE WAY TO THE BANK
    if
        player:hasKeyItem(xi.ki.TARUTARU_SAUCE_INVOICE) and
        npcUtil.tradeHas(trade, { { 'gil', 5600 } })
    then
        local paidFlapano = utils.mask.getBit(player:getCharVar('ATWTTB_Payments'), 2)
        if not paidFlapano then
            player:startEvent(5071)
        end

    -- EXOTIC DELICACIES
    elseif exoticDelicacies == xi.questStatus.QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, { 3916, 5949, { 5954, 2 } }) then
            player:startEvent(2861)
        elseif
            npcUtil.tradeHas(trade, xi.item.PLATE_OF_BARNACLE_PAELLA) or
            npcUtil.tradeHas(trade, xi.item.PLATE_OF_FLAPANOS_PAELLA)
        then
            player:startEvent(2862)
        end
    end
end

entity.onTrigger = function(player, npc)
    local theWeatherspoonWar = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.THE_WEATHERSPOON_WAR)
    local exoticDelicacies = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.EXOTIC_DELICACIES)

    -- THE WEATHERSPOON WAR
    if
        theWeatherspoonWar == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('Weatherspoon_War_Status') == 6
    then
        player:startEvent(191)

    -- EXOTIC DELICACIES
    -- Flapano offers his quest every other time the player talks to him
    elseif
        exoticDelicacies ~= xi.questStatus.QUEST_COMPLETED and
        player:getCharVar('Flapano_Odd_Even') == 0
    then
        if exoticDelicacies == xi.questStatus.QUEST_AVAILABLE then
            player:startEvent(2860)
        elseif exoticDelicacies == xi.questStatus.QUEST_ACCEPTED then
            player:startEvent(2863)
        end

        player:setCharVar('Flapano_Odd_Even', 1)

    -- SHOP
    else
        player:showText(npc, ID.text.FLAPANO_SHOP_TEXT)
        local stock =
        {
            5943, 125,   -- Smoked Mackerel
            4415, 124,   -- Roasted Corn
            4434, 5000,  -- Mushroom Risotto
            5145, 5600,  -- Fish and Chips
            4423, 300,   -- Apple Juice
            4405, 160,   -- Rice Ball
            5676, 76475, -- Mushroom Saute
        }
        xi.shop.general(player, stock)

        if exoticDelicacies ~= xi.questStatus.QUEST_COMPLETED then
            player:setCharVar('Flapano_Odd_Even', 0)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- ALL THE WAY TO THE BANK
    if csid == 5071 then
        player:confirmTrade()
        player:setCharVar('ATWTTB_Payments', utils.mask.setBit(player:getCharVar('ATWTTB_Payments'), 2, true))
        if utils.mask.isFull(player:getCharVar('ATWTTB_Payments'), 5) then
            npcUtil.giveKeyItem(player, xi.ki.TARUTARU_SAUCE_RECEIPT)
        end

    -- EXOTIC DELICACIES
    elseif csid == 2860 and option == 1 then
        player:addQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.EXOTIC_DELICACIES)
    elseif csid == 2861 then
        if npcUtil.completeQuest(player, xi.questLog.ADOULIN, xi.quest.id.adoulin.EXOTIC_DELICACIES, { bayld = 500, item = xi.item.PLATE_OF_FLAPANOS_PAELLA, exp = 1000 }) then
            player:confirmTrade()
            player:setCharVar('Flapano_Odd_Even', 0)
        end
    end
end

return entity
