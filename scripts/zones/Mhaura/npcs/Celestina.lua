-----------------------------------
-- Area: Mhaura
--  NPC: Celestina
-- Finish Quest: The Sand Charm
-- Involved in Quest: Riding on the Clouds
-- Guild Merchant NPC: Goldsmithing Guild
-- !pos -37.624 -16.050 75.681 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_SAND_CHARM) == QUEST_ACCEPTED then
        if npcUtil.tradeHasExactly(trade, 13095) then
            player:startEvent(127) -- Finish quest "The Sand Charm"
        end
    end

    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and
        player:getCharVar("ridingOnTheClouds_3") == 5 then
        if npcUtil.tradeHasExactly(trade, 1127) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_3", 0)
            player:confirmTrade()
            npcUtil.giveKeyItem(player, tpz.ki.SOMBER_STONE)
        end
    end
end

function onTrigger(player, npc)
    if player:getCharVar("theSandCharmVar") == 3 then
        player:startEvent(126, 13095) -- During quest "The Sand Charm" - 3rd dialog
    else
        local guildSkillId = tpz.skill.GOLDSMITHING
        local stock = tpz.shop.generalGuildStock[guildSkillId]
        tpz.shop.generalGuild(player, stock, guildSkillId)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 126 and option == 70 then
        player:setCharVar("theSandCharmVar", 4)
    elseif (csid == 127) then
        player:confirmTrade()
        npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_SAND_CHARM, {
            keyItem = tpz.ki.MAP_OF_BOSTAUNIEUX_OUBLIETTE,
            fame_area = MHAURA,
            var = "theSandCharmVar"
        })
        player:setCharVar("SmallDialogByBlandine", 1)
    end
end
