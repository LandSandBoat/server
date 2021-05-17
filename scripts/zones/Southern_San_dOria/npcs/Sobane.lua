-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Sobane
-- Starts and Finishes Quest: Signed in Blood
-- Involved in quest: Sharpening the Sword, Riding on the Clouds
-- !pos -190 -3 97 230
-- csid: 52  732  733  734  735  736  737  738  739  740  741
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- RIDING ON THE CLOUDS
    if npcUtil.tradeHas(trade, 1127) and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_1") == 2 then
        player:setCharVar("ridingOnTheClouds_1", 0)
        npcUtil.giveKeyItem(player, xi.ki.SCOWLING_STONE)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    local signedInBlood = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SIGNED_IN_BLOOD)
    local teaWithATonberry = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TEA_WITH_A_TONBERRY)

    -- SHARPENING THE SWORD
    if player:getCharVar("sharpeningTheSwordCS") >= 2 then
        player:startEvent(52)

    -- TEA WITH A TONBERRY
    elseif signedInBlood == QUEST_COMPLETED and teaWithATonberry == QUEST_AVAILABLE then
        player:startEvent(738)
    elseif teaWithATonberry == QUEST_ACCEPTED then
        if player:getCharVar("TEA_WITH_A_TONBERRY_PROG") == 5 then
            player:startEvent(740)
        else
            player:startEvent(739)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- SHARPENING THE SWORD
    if csid == 52 then
        player:setCharVar("sharpeningTheSwordCS", 3)

    -- TEA WITH A TONBERRY
    elseif csid == 738 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TEA_WITH_A_TONBERRY)
    elseif csid == 740 and npcUtil.completeQuest(player, SANDORIA, xi.quest.id.sandoria.TEA_WITH_A_TONBERRY, {item = 13174}) then
        player:setCharVar("TEA_WITH_A_TONBERRY_PROG", 0)
    end
end

return entity
