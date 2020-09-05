-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Dauperiat
-- Starts and Finishes Quest: Blackmail (R)
-- !zone 231
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    local Black = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.BLACKMAIL)
    local questState = player:getCharVar("BlackMailQuest")

    if (Black == QUEST_ACCEPTED and questState == 2 or Black == QUEST_COMPLETED) then
        local count = trade:getItemCount()
        local carta = trade:hasItemQty(530, 1)

        if (carta == true and count == 1) then
            player:startEvent(648, 0, 530) --648
        end
    end
end

function onTrigger(player, npc)

    -- "Blackmail" quest status
    local blackMail = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.BLACKMAIL)
    local envelope = player:hasKeyItem(tpz.ki.SUSPICIOUS_ENVELOPE)
    local sanFame = player:getFameLevel(SANDORIA)
    local homeRank = player:getRank(player:getNation())
    local questState = player:getCharVar("BlackMailQuest")


    if (blackMail == QUEST_AVAILABLE and sanFame >= 3 and homeRank >= 3) then
        player:startEvent(643) -- 643 gives me letter
    elseif (blackMail == QUEST_ACCEPTED and envelope == true) then
        player:startEvent(645)  -- 645 recap, take envelope!

    elseif (blackMail == QUEST_ACCEPTED and questState == 1) then
        player:startEvent(646, 0, 530) --646  after giving letter to H, needs param


    elseif (blackMail == QUEST_ACCEPTED and questState == 2) then
        player:startEvent(647, 0, 530) --647 recap of 646

    else
        if (player:needToZone() ==true) then
            player:startEvent(642) --642 Quiet!
        else
            player:startEvent(641) --641 -- Quiet! leave me alone
            player:needToZone(true)
        end
    end

end

function onEventUpdate(player, csid, option)

end

function onEventFinish(player, csid, option)

    if (csid == 643) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.BLACKMAIL)
        player:addKeyItem(tpz.ki.SUSPICIOUS_ENVELOPE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SUSPICIOUS_ENVELOPE)
    elseif (csid == 646 and option == 1) then
        player:setCharVar("BlackMailQuest", 2)
    elseif (csid == 648) then
        player:tradeComplete()
        player:addGil(GIL_RATE*900)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*900)
        if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.BLACKMAIL) == QUEST_ACCEPTED) then
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.BLACKMAIL)
        else
            player:addFame(SANDORIA, 5)
        end
    elseif (csid == 40 and option == 1) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.BLACKMAIL)
    end

end
