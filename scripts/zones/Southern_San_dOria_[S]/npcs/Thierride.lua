-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Thierride
-- !pos -124 -2 14 80
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

-- Item 1019 = Lufet Salt
-- Had to use setCharVar because you have to trade Salts one at a time according to the wiki.
-- Lufet Salt can be obtained by killing Crabs in normal West Ronfaure.

entity.onTrade = function(player, npc, trade)
    local lufetSalt = trade:hasItemQty(1019, 1)
    local cnt = trade:getItemCount()
    local beansAhoy = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BEANS_AHOY)

    if lufetSalt and cnt == 1 and beansAhoy == QUEST_ACCEPTED then
        if player:getCharVar("BeansAhoy") == 0 then
            player:startEvent(337) -- Traded the Correct Item Dialogue (NOTE: You have to trade the Salts one at according to wiki)
        elseif not player:needToZone() then
            player:startEvent(340) -- Quest Complete Dialogue
        end
    else
        player:startEvent(339) -- Wrong Item Traded
    end
end

entity.onTrigger = function(player, npc)
    local beansAhoy = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BEANS_AHOY)

    if beansAhoy == QUEST_AVAILABLE then
        player:startEvent(334) -- Quest Start
    elseif beansAhoy == QUEST_ACCEPTED then
        player:startEvent(335) -- Quest Active, NPC Repeats what he says but as normal 'text' instead of cutscene.
    elseif
        beansAhoy == QUEST_COMPLETED and
        os.time() > player:getCharVar("BeansAhoy_ConquestWeek")
    then
        player:startEvent(342)
    elseif beansAhoy == QUEST_COMPLETED then
        player:startEvent(341)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 334 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BEANS_AHOY)
    elseif csid == 337 then
        player:tradeComplete()
        player:setCharVar("BeansAhoy", 1)
        player:needToZone(true)
    elseif csid == 340 or csid == 342 then
        if player:hasItem(5704, 1) or player:getFreeSlotsCount() < 1 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 5704)
        else
            player:addItem(5704, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5704)
            player:setCharVar("BeansAhoy_ConquestWeek", getConquestTally())
            if csid == 340 then
                player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BEANS_AHOY)
                player:setCharVar("BeansAhoy", 0)
                player:tradeComplete()
            end
        end
    end
end

return entity
