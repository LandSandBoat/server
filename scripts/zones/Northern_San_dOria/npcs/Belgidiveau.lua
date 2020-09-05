-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Belgidiveau
-- Starts and Finishes Quest: Trouble at the Sluice
-- !pos -98 0 69 231
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    troubleAtTheSluice = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
    NeutralizerKI = player:hasKeyItem(tpz.ki.NEUTRALIZER)

    if (troubleAtTheSluice == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 3) then
        player:startEvent(57)
    elseif (troubleAtTheSluice == QUEST_ACCEPTED and NeutralizerKI == false) then
        player:startEvent(55)
    elseif (NeutralizerKI) then
        player:startEvent(56)
    else
        player:startEvent(585)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 57 and option == 0) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
        player:setCharVar("troubleAtTheSluiceVar", 1)
    elseif (csid == 56) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16706) -- Heavy Axe
        else
            player:tradeComplete()
            player:delKeyItem(tpz.ki.NEUTRALIZER)
            player:addItem(16706)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16706) -- Heavy Axe
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
        end
    end

end
