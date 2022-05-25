-----------------------------------
-- Area: Windurst Walls
--  NPC: Nanaa Mihgo
-- Starts and Finishes Quest: Mihgo's Amigo (R), The Tenshodo Showdown (start), Rock Racketeer (start)
-- Involved In Quest: Crying Over Onions
-- Involved in Mission 2-1
-- !pos 62 -4 240 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/magic")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/settings/main")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, {{498, 4}}) then -- Yagudo Necklace x4
        local mihgosAmigo = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO)

        if mihgosAmigo == QUEST_ACCEPTED then
            player:startEvent(88, xi.settings.GIL_RATE * 200)
        elseif mihgosAmigo == QUEST_COMPLETED then
            player:startEvent(494, xi.settings.GIL_RATE * 200)
        end
    end
end

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar("WildcatWindurst")
    local mihgosAmigo = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO)
    local rockRacketeer = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)
    local rockRacketeerCS = player:getCharVar("rockracketeer_sold")

    -- LURE OF THE WILDCAT (WINDURST 2-1)
    -- Simply checks this NPC as talked to for the PC, should be highest priority
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 4)
    then
        player:startEvent(732)

    -- ROCK RACKETEER (Mihgo's Amigo follow-up)
    elseif mihgosAmigo == QUEST_COMPLETED and rockRacketeer == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.WINDURST) >= 3
    then
        if player:needToZone() then
            player:startEvent(89) -- complete
        else
            player:startEvent(93) -- quest start
        end
    elseif rockRacketeer == QUEST_ACCEPTED and rockRacketeerCS == 1 then
        player:startEvent(98) -- advance quest talk to Varun
    elseif rockRacketeer == QUEST_ACCEPTED and rockRacketeerCS == 2 then
        player:startEvent(95) -- not sold reminder
    elseif rockRacketeer == QUEST_ACCEPTED then
        player:startEvent(94) -- quest reminder

    -- MIHGO'S AMIGO
    elseif mihgosAmigo == QUEST_AVAILABLE then
        if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS) == QUEST_AVAILABLE then
            player:startEvent(81) -- Start Quest "Mihgo's Amigo" with quest "Crying Over Onions" Activated
        else
            player:startEvent(80) -- Start Quest "Mihgo's Amigo"
        end
    elseif mihgosAmigo == QUEST_ACCEPTED then
        player:startEvent(82)

    -- STANDARD DIALOG
    elseif rockRacketeer == QUEST_COMPLETED then
        player:startEvent(99) -- new dialog after Rock Racketeer
    elseif mihgosAmigo == QUEST_COMPLETED then
        player:startEvent(89) -- new dialog after Mihgo's Amigos
    else
        player:startEvent(76) -- standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- LURE OF THE WILDCAT (WINDURST)
    if csid == 732 then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 4, true))

    -- ROCK RACKETEER
    elseif csid == 93 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)
        npcUtil.giveKeyItem(player, xi.ki.SHARP_GRAY_STONE)
    elseif csid == 98 then
        player:delGil(10 * xi.settings.GIL_RATE)
        player:setCharVar("rockracketeer_sold", 3)

    -- MIHGO'S AMIGO
    elseif csid == 80 or csid == 81 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO)
    elseif csid == 88 then
        player:confirmTrade()
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO)
        player:addTitle(xi.title.CAT_BURGLAR_GROUPIE)
        player:addGil(xi.settings.GIL_RATE * 200)
        player:addFame(xi.quest.fame_area.NORG, 60)
        player:needToZone(true)
    elseif csid == 494 then
        player:confirmTrade()
        player:addTitle(xi.title.CAT_BURGLAR_GROUPIE)
        player:addGil(xi.settings.GIL_RATE * 200)
        player:addFame(xi.quest.fame_area.NORG, 30)
    end
end

return entity
