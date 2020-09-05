-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Thierride
-- !pos -124 -2 14 80
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------

-- Item 1019 = Lufet Salt
-- Had to use setCharVar because you have to trade Salts one at a time according to the wiki.
-- Lufet Salt can be obtained by killing Crabs in normal West Ronfaure.

function onTrade(player, npc, trade)
    local lufetSalt = trade:hasItemQty(1019, 1)
    local cnt = trade:getItemCount()
    local beansAhoy = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.BEANS_AHOY)
    if (lufetSalt and cnt == 1 and beansAhoy == QUEST_ACCEPTED) then
        if (player:getCharVar("BeansAhoy") == 0 == true) then

            player:startEvent(337) -- Traded the Correct Item Dialogue (NOTE: You have to trade the Salts one at according to wiki)

        elseif (player:needsToZone() == false) then
            player:startEvent(340) -- Quest Complete Dialogue

        end

    else
        player:startEvent(339) -- Wrong Item Traded

    end

end

function onTrigger(player, npc)
    local beansAhoy = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.BEANS_AHOY)
    if (beansAhoy == QUEST_AVAILABLE) then
        player:startEvent(334) -- Quest Start

    elseif (beansAhoy == QUEST_ACCEPTED) then
        player:startEvent(335) -- Quest Active, NPC Repeats what he says but as normal 'text' instead of cutscene.

    elseif (beansAhoy == QUEST_COMPLETED and getConquestTally() ~= player:getCharVar("BeansAhoy_ConquestWeek")) then
        player:startEvent(342)
    elseif (beansAhoy == QUEST_COMPLETED) then
        player:startEvent(341)
    else
        player:startEvent(333) -- Default Dialogue

    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 334) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.BEANS_AHOY)

    elseif (csid == 337) then
        player:tradeComplete()
        player:setCharVar("BeansAhoy", 1)
        player:needsToZone(true)

    elseif (csid == 340 or csid == 342) then
        if (player:hasItem(5704, 1) or player:getFreeSlotsCount() < 1) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 5704)

        else
            player:addItem(5704, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5704)
            player:setCharVar("BeansAhoy_ConquestWeek", getConquestTally())
            if (csid == 340) then
                player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.BEANS_AHOY)
                player:setCharVar("BeansAhoy", 0)
                player:tradeComplete()
            end

        end
    end


end
