-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Atelloune
-- Starts and Finishes Quest: Atelloune's Lament
-- !pos 122 0 82 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    -----lady bug
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.ATELLOUNE_S_LAMENT) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(2506, 1) and trade:getItemCount() == 1) then
            player:startEvent(891)
        end
    end

end

function onTrigger(player, npc)

    local atellounesLament = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.ATELLOUNE_S_LAMENT)
    local sanFame = player:getFameLevel(SANDORIA)

    if (atellounesLament == QUEST_AVAILABLE and sanFame >= 2) then
        player:startEvent(890)
    elseif (atellounesLament == QUEST_ACCEPTED) then
        player:startEvent(892)
    elseif (atellounesLament == QUEST_COMPLETED) then
        player:startEvent(884) -- im profesors research
    elseif (sanFame < 2) then
        player:startEvent(884)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 890) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.ATELLOUNE_S_LAMENT)
    elseif (csid == 891) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 15008) -- Trainee Gloves
        else
            player:addItem(15008)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 15008) -- Trainee Gloves
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.ATELLOUNE_S_LAMENT)
        end
    end

end
