-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Eperdur
-- Starts and Finishes Quest: Altana's Sorrow (finish), Acting in Good Faith (finish), Healing the Land,
-- !pos 129 -6 96 231
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local AltanaSorrow  = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.ALTANA_S_SORROW)
    local ActingInGoodFaith  = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ACTING_IN_GOOD_FAITH)
    local HealingTheLand = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)
    local SorceryOfTheNorth = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SORCERY_OF_THE_NORTH)

    if AltanaSorrow == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.LETTER_FROM_VIRNAGE) then
        player:startEvent(679) -- Finish quest "Altana's Sorrow"
    elseif ActingInGoodFaith == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.GANTINEUXS_LETTER) then
        player:startEvent(680) -- Finish quest "Acting in Good Faith"
    elseif HealingTheLand == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 4 and player:getMainLvl() >= 10 then
        player:startEvent(681) -- Start quest "Healing the Land"
    elseif HealingTheLand == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.SEAL_OF_BANISHING) then
        player:startEvent(682) -- During quest "Healing the Land"
    elseif HealingTheLand == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.SEAL_OF_BANISHING) == false then
        player:startEvent(683) -- Finish quest "Healing the Land"
    elseif HealingTheLand == QUEST_COMPLETED and SorceryOfTheNorth == QUEST_AVAILABLE and player:needToZone() then
        player:startEvent(684) -- New standard dialog after "Healing the Land"
    elseif HealingTheLand == QUEST_COMPLETED and SorceryOfTheNorth == QUEST_AVAILABLE and player:needToZone() == false then
        player:startEvent(685) -- Start quest "Sorcery of the North"
    elseif SorceryOfTheNorth == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.FEIYIN_MAGIC_TOME) == false then
        player:startEvent(686) -- During quest "Sorcery of the North"
    elseif SorceryOfTheNorth == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.FEIYIN_MAGIC_TOME) then
        player:startEvent(687) -- Finish quest "Sorcery of the North"
    else
        player:startEvent(678) -- Standard dialog
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if csid == 679 then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4731)
        else
            player:addTitle(xi.title.PILGRIM_TO_DEM)
            player:delKeyItem(xi.ki.LETTER_FROM_VIRNAGE)
            player:addItem(4731)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4731) -- Scroll of Teleport-Dem
            player:addFame(BASTOK, 30)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.ALTANA_S_SORROW)
        end
    elseif csid == 680 then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4732)
        else
            player:addTitle(xi.title.PILGRIM_TO_MEA)
            player:delKeyItem(xi.ki.GANTINEUXS_LETTER)
            player:addItem(4732)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4732) -- Scroll of Teleport-Mea
            player:addFame(WINDURST, 30)
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ACTING_IN_GOOD_FAITH)
        end
    elseif csid == 681 and option == 0 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)
        player:addKeyItem(xi.ki.SEAL_OF_BANISHING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEAL_OF_BANISHING)
    elseif csid == 683 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4730)
        else
            player:addTitle(xi.title.PILGRIM_TO_HOLLA)
            player:addItem(4730)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4730) -- Scroll of Teleport-Holla
            player:needToZone(true)
            player:addFame(SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)
        end
    elseif csid == 685 and option == 0 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SORCERY_OF_THE_NORTH)
    elseif csid == 687 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4747)
        else
            player:delKeyItem(xi.ki.FEIYIN_MAGIC_TOME)
            player:addItem(4747)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4747) -- Scroll of Teleport-Vahzl
            player:addFame(SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SORCERY_OF_THE_NORTH)
        end
    end

end

return entity
