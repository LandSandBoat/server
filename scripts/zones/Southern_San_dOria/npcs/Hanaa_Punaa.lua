-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Hanaa Punaa
-- Starts and Finishes: A Squire's Test, A Squire's Test II, A Knight's Test
-- !zone 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)

    -- "The Seamstress" , x3 sheepskin trade
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_SEAMSTRESS) ~= QUEST_AVAILABLE) then
        if (trade:hasItemQty(505, 3) and trade:getItemCount() == 3) then
            player:startEvent(530)
        end
    end

    -- "Black Tiger Skins", Tiger Hide trade
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.BLACK_TIGER_SKINS) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(861, 3) and trade:getItemCount() == 3) then
            player:startEvent(577)
        end
    end

    -- "Lizard Skins", lizard skin trade
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LIZARD_SKINS) ~= QUEST_AVAILABLE) then
        if (trade:hasItemQty(852, 3) and trade:getItemCount() == 3) then
            player:startEvent(561)
        end
    end
end

function onTrigger(player, npc)

    -- Checking Fame Level & Quest
    local sanFame = player:getFameLevel(SANDORIA)
    local theSteamStress = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_SEAMSTRESS)
    local lizardSkins = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LIZARD_SKINS)
    local blackTigerSkins = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.BLACK_TIGER_SKINS)

    -- "The Seamstress" Quest Status
    if (theSteamStress == QUEST_AVAILABLE and player:getCharVar("theSeamStress") == 1) then
        player:startEvent(531)
    elseif (theSteamStress == QUEST_AVAILABLE) then
        player:startEvent(528)
        player:setCharVar("theSeamStress", 1)
    elseif (theSteamStress == QUEST_ACCEPTED) then
        player:startEvent(529)
    elseif (theSteamStress == QUEST_COMPLETED and sanFame < 2) then
        player:startEvent(590)

    -- "Lizard Skins" Quest Dialogs
    elseif (lizardSkins == QUEST_AVAILABLE and player:getCharVar("lzdSkins") == 1 and sanFame >= 2 and theSteamStress == QUEST_COMPLETED) then
        player:startEvent(562)
    elseif (lizardSkins == QUEST_AVAILABLE and sanFame >= 2 and theSteamStress == QUEST_COMPLETED) then
        player:startEvent(559)
        player:setCharVar("lzdSkins", 1)
    elseif (lizardSkins == QUEST_ACCEPTED) then
        player:startEvent(560)
    elseif (lizardSkins == QUEST_COMPLETED and sanFame < 3) then
        player:startEvent(591)

    -- "Black Tiger Skins" Quest Dialogs
    elseif (blackTigerSkins == QUEST_AVAILABLE and player:getCharVar("blkTigerSkin") == 1 and sanFame >= 3 and theSteamStress == QUEST_COMPLETED and lizardSkins == QUEST_COMPLETED) then
        player:startEvent(579 )
    elseif (blackTigerSkins == QUEST_AVAILABLE and sanFame >= 3 and theSteamStress == QUEST_COMPLETED and lizardSkins == QUEST_COMPLETED) then
        player:startEvent(576)
        player:setCharVar("blkTigerSkin", 1)
    elseif (blackTigerSkins == QUEST_ACCEPTED) then
        player:startEvent(578)
    elseif (blackTigerSkins == QUEST_COMPLETED) then
        player:startEvent(592)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    -- "The Seamstress" Quest
    if ((csid == 528 or csid == 531) and option == 0) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.THE_SEAMSTRESS)
        player:setCharVar("theSeamStress", 0)
    elseif (csid == 530) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12696) -- Leather Gloves
        else
            player:tradeComplete()
            player:addTitle(tpz.title.SILENCER_OF_THE_LAMBS)
            player:addItem(12696)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12696) -- Leather Gloves
            if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_SEAMSTRESS) == QUEST_ACCEPTED) then
                player:addFame(SANDORIA, 30)
                player:completeQuest(SANDORIA, tpz.quest.id.sandoria.THE_SEAMSTRESS)
            else
                player:addFame(SANDORIA, 5)
            end
        end

    -- "Liard Skins" Quest
    elseif ((csid == 559 or csid == 562) and option == 0) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.LIZARD_SKINS)
        player:setCharVar("lzdSkins", 0)
    elseif (csid == 561) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12697) -- Lizard Gloves
        else
            player:tradeComplete()
            player:addTitle(tpz.title.LIZARD_SKINNER)
            player:addItem(12697)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12697) -- Lizard Gloves
            if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LIZARD_SKINS) == QUEST_ACCEPTED) then
                player:addFame(SANDORIA, 30)
                player:completeQuest(SANDORIA, tpz.quest.id.sandoria.LIZARD_SKINS)
            else
                player:addFame(SANDORIA, 5)
            end
        end

    -- "Black Tiger Skins" Quest
    elseif ((csid == 576 or csid == 579) and option == 0) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.BLACK_TIGER_SKINS)
        player:setCharVar("blkTigerSkin", 0)
    elseif (csid == 577) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13119) -- Tyger Stole
        else
            player:tradeComplete()
            player:addTitle(tpz.title.CAT_SKINNER)
            player:addItem(13119)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13119) -- Tyger Stole
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.BLACK_TIGER_SKINS)
        end
    end

end
