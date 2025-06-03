-----------------------------------
-- Area: Mhaura
--  NPC: Orlando
-- !pos -37.268 -9 58.047 249
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local questStatus = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ORLANDOS_ANTIQUES)
    local itemID = trade:getItemId()
    local itemList =
    {
        {   564, 200 }, -- Fingernail Sack
        {   565, 250 }, -- Teeth Sack
        {   566, 200 }, -- Goblin Cup
        {   568, 120 }, -- Goblin Die
        {   656, 600 }, -- Beastcoin
        {   748, 900 }, -- Gold Beastcoin
        {   749, 800 }, -- Mythril Beastcoin
        {   750, 750 }, -- Silver Beastcoin
        {   898, 120 }, -- Chicken Bone
        {   900, 100 }, -- Fish Bone
        { 16995, 150 }, -- Rotten Meat
    }

    for x, item in pairs(itemList) do
        if
            questStatus == xi.questStatus.QUEST_ACCEPTED or
            player:getLocalVar('OrlandoRepeat') == 1
        then
            if item[1] == itemID then
                if trade:hasItemQty(itemID, 8) and trade:getItemCount() == 8 then
                    -- Correct amount, valid item.
                    player:setCharVar('ANTIQUE_PAYOUT', xi.settings.main.GIL_RATE * item[2])
                    player:startEvent(102, xi.settings.main.GIL_RATE * item[2], itemID)
                elseif trade:getItemCount() < 8 then
                    -- Wrong amount, but valid item.
                    player:startEvent(104)
                end
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local questStatus = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ORLANDOS_ANTIQUES)

    if player:getFameLevel(xi.fameArea.WINDURST) >= 2 then
        if player:hasKeyItem(xi.ki.CHOCOBO_LICENSE) then
            if questStatus ~= xi.questStatus.QUEST_AVAILABLE then
                player:startEvent(103)
            elseif questStatus == xi.questStatus.QUEST_AVAILABLE then
                player:startEvent(101)
            end
        else
            player:startEvent(100)
        end
    else
        player:startEvent(106)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local questStatus = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ORLANDOS_ANTIQUES)
    local payout = player:getCharVar('ANTIQUE_PAYOUT')

    if csid == 101 then
        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ORLANDOS_ANTIQUES)
    elseif csid == 102 then
        player:tradeComplete()
        player:addFame(xi.fameArea.WINDURST, 10)
        npcUtil.giveCurrency(player, 'gil', payout)
        player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ORLANDOS_ANTIQUES)
        player:setCharVar('ANTIQUE_PAYOUT', 0)
        player:setLocalVar('OrlandoRepeat', 0)
    elseif csid == 103 then
        if questStatus == xi.questStatus.QUEST_COMPLETED then
            player:setLocalVar('OrlandoRepeat', 1)
        end
    end
end

return entity
