-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Eperdur
-- Starts and Finishes Quest: Acting in Good Faith (finish), Healing the Land,
-- !pos 129 -6 96 231
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local actingInGoodFaith  = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ACTING_IN_GOOD_FAITH)
    local healingTheLand = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)
    local sorceryOfTheNorth = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SORCERY_OF_THE_NORTH)

    if
        actingInGoodFaith == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.GANTINEUXS_LETTER)
    then
        player:startEvent(680) -- Finish quest "Acting in Good Faith"
    elseif
        healingTheLand == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 4 and
        player:getMainLvl() >= 10
    then
        player:startEvent(681) -- Start quest "Healing the Land"
    elseif
        healingTheLand == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SEAL_OF_BANISHING)
    then
        player:startEvent(682) -- During quest "Healing the Land"
    elseif
        healingTheLand == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.SEAL_OF_BANISHING)
    then
        player:startEvent(683) -- Finish quest "Healing the Land"
    elseif
        healingTheLand == QUEST_COMPLETED and
        sorceryOfTheNorth == QUEST_AVAILABLE and
        player:needToZone()
    then
        player:startEvent(684) -- New standard dialog after "Healing the Land"
    elseif
        healingTheLand == QUEST_COMPLETED and
        sorceryOfTheNorth == QUEST_AVAILABLE and
        not player:needToZone()
    then
        player:startEvent(685) -- Start quest "Sorcery of the North"
    elseif
        sorceryOfTheNorth == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.FEIYIN_MAGIC_TOME)
    then
        player:startEvent(686) -- During quest "Sorcery of the North"
    elseif
        sorceryOfTheNorth == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.FEIYIN_MAGIC_TOME)
    then
        player:startEvent(687) -- Finish quest "Sorcery of the North"
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 680 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4732)
        else
            player:addTitle(xi.title.PILGRIM_TO_MEA)
            player:delKeyItem(xi.ki.GANTINEUXS_LETTER)
            player:addItem(4732)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4732) -- Scroll of Teleport-Mea
            player:addFame(xi.quest.fame_area.WINDURST, 30)
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
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
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
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SORCERY_OF_THE_NORTH)
        end
    end
end

return entity
