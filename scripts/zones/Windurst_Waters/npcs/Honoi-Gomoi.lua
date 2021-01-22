-----------------------------------
-- Area: Windurst Waters
--  NPC: Honoi-Gumoi
-- Involved In Quest: Crying Over Onions, Hat in Hand
-- !pos -195 -11 -120 238
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade "Star Spinel" for "Crying over Onions" after having talked to this NPC once
    -- and optionally talked to Nanaa Mihgo (CryingOverOnions == 2)
    if
        (player:getCharVar("CryingOverOnions") == 1 or player:getCharVar("CryingOverOnions") == 2) and
        npcUtil.tradeHas(trade, 1149)
    then
        player:startEvent(775, 0, 1149)
    end
end

entity.onTrigger = function(player, npc)
    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end

    local cryingOverOnions  = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.CRYING_OVER_ONIONS)
    local wildCard          = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.WILD_CARD)
    local hatInHand         = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.HAT_IN_HAND)

    if
        player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ROAD_FORKS and
        player:getCharVar("MEMORIES_OF_A_MAIDEN_Status") == 5
    then
        player:startEvent(874) -- COP event
    elseif
        (hatInHand == QUEST_ACCEPTED or player:getCharVar("QuestHatInHand_var2") == 1) and
        not testflag(player:getCharVar("QuestHatInHand_var"), 2)
    then
        player:startEvent(59) -- Show Off Hat
    elseif wildCard == QUEST_COMPLETED then
        player:startEvent(783)
    elseif wildCard == QUEST_ACCEPTED then
        if player:getCharVar("WildCard") == 3 and not player:hasKeyItem(tpz.ki.JOKER_CARD) then
            player:startEvent(782)
        else
            player:startEvent(781)
        end
    elseif cryingOverOnions == QUEST_COMPLETED then
        if not player:needToZone() and player:getFameLevel(WINDURST) >= 6 then
            player:startEvent(780)
        else
            player:startEvent(779)
        end
    elseif cryingOverOnions == QUEST_ACCEPTED then
        local cryingOverOnionsVar = player:getCharVar("CryingOverOnions")
        if cryingOverOnionsVar == 4 then
            player:startEvent(776)
        elseif cryingOverOnionsVar == 3 then
            player:startEvent(778)
        elseif cryingOverOnionsVar >= 1 then
            player:startEvent(777)
        else
            player:startEvent(774, 0, 1149)
        end
    else
        player:startEvent(650)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    -- "Crying over Onions"
    if csid == 774 then
        player:setCharVar("CryingOverOnions", 1)
    elseif csid == 775 and npcUtil.giveItem(player, 13136) then
        player:confirmTrade()
        player:setCharVar("CryingOverOnions", 3)
    elseif
        csid == 776 and
        npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.CRYING_OVER_ONIONS, {
            fame=120,
            var="CryingOverOnions",
        })
    then
        player:needToZone(true)

    -- "Wild Card"
    elseif csid == 780 then
        player:addQuest(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.WILD_CARD)
    elseif
        csid == 782 and
        npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.WILD_CARD, {
            title=tpz.title.DREAM_DWELLER,
            fame=135,
            var="WildCard",
        })
    then
        player:needToZone(true)

    -- "Hat in Hand"
    elseif csid == 59 then -- Show Off Hat
        player:addCharVar("QuestHatInHand_var", 2)
        player:addCharVar("QuestHatInHand_count", 1)

    -- COP Misson 3-3B "Memories of a Maiden"
    elseif csid == 874 then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 6)
        npcUtil.giveKeyItem(player, tpz.ki.CRACKED_MIMEO_MIRROR)
    end
end

return entity
