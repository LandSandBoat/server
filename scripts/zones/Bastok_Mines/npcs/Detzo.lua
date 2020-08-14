-----------------------------------
-- Area: Bastok Mines
--  NPC: Detzo
-- Starts & Finishes Quest: Rivals
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    Rivals = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.RIVALS)

    if (Rivals == QUEST_ACCEPTED) then
        FreeSlots = player:getFreeSlotsCount()

        if (FreeSlots >= 1) then
            count = trade:getItemCount()
            MythrilSallet = trade:hasItemQty(12417, 1)

            if (MythrilSallet == true and count == 1) then
                -- You retain the Mythril Sallet after trading it to Detzo
                player:startEvent(94)
            end
        else
            player:messageSpecial(ID.text.FULL_INVENTORY_AFTER_TRADE, 13571)
        end
    end

end

function onTrigger(player, npc)

    Rivals = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.RIVALS)

    if (player:getCharVar("theTalekeeperGiftCS") == 1) then
        player:startEvent(171)
        player:setCharVar("theTalekeeperGiftCS", 2)
    elseif (Rivals == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 3) then
        player:startEvent(93)
    elseif (Rivals == QUEST_ACCEPTED) then
        player:showText(npc, ID.text.DETZO_RIVALS_DIALOG)
    else
        player:startEvent(30)
    end

end
-- 1  30  93  94  171  1010  176  180  184
function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)

    if (csid == 93) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.RIVALS)
    elseif (csid == 94) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13571)
        else
            player:addTitle(tpz.title.CONTEST_RIGGER)
            player:addItem(13571)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13571)
            player:addFame(BASTOK, 30)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.RIVALS)
        end
    end

end
