-----------------------------------
-- Area: Windurst Walls (239)
--  NPC: Shantotto
-- !pos 122 -2 112 239
-- CSID's missing in autoEventID please check the old forums under resources for all of shantotto's csid's. I found them all manually.
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/wsquest")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------

local wsQuest = tpz.wsquest.retribution

local TrustMemory = function(player)
    local memories = 0
    --[[ TODO
    -- 2 - The Three Kingdoms
    if player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.JOURNEY_TO_BASTOK2) or player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2) then
        memories = memories + 2
    end
    -- 4 - Where Two Paths Converge
    if player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) then
        memories = memories + 4
    end
    -- 8 - The Pirate's Cove
    if player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_PIRATE_S_COVE) then
        memories = memories + 8
    end
    -- 16 - Ayame and Kaede
    if player:hasCompletedQuest(BASTOK, tpz.quest.id.bastok.AYAME_AND_KAEDE) then
        memories = memories + 16
    end
    -- 32 - Light of Judgement
    if player:hasCompletedMission(TOAU, tpz.mission.id.toau.LIGHT_OF_JUDGMENT) then
        memories = memories + 32
    end
    -- 64 - True Strength
    if player:hasCompletedQuest(BASTOK, tpz.quest.id.bastok.TRUE_STRENGTH) then
        memories = memories + 64
    end
    ]]--

    -- Kill a Taru under the gun
    -- Defeated Shadowlord
    -- Saving Star Sibyl
    -- Grade, came up in spades
    -- Bring back Prishe
    -- Yoran Oran: No Heir
    -- Incident with Ragnarok
    -- Chocobo Races
    -- Markovich
    -- Puppet Twin battle
    -- Yoran-Oran and Koru-Moru
    -- Grimy Hat
    return memories
end

function onTrade(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)
    local count = trade:getItemCount()

    if wsQuestEvent ~= nil then
        if wsQuestEvent == 448 then
            player:startEvent(wsQuestEvent, nil, nil, tpz.ki.ANNALS_OF_TRUTH)
        else
            player:startEvent(wsQuestEvent)
        end

        -- Curses Foiled Again!
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_AGAIN_1) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(928, 1) and trade:hasItemQty(880, 2) and count == 3) then
            player:startEvent(173, 0, 0, 0, 0, 0, 0, 928, 880) -- Correct items given, complete quest.
        else
            player:startEvent(172, 0, 0, 0, 0, 0, 0, 928, 880) -- Incorrect or not enough items
        end

        -- Curses, Foiled ... Again!?
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_AGAIN_2) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(17316, 2) and trade:hasItemQty(940, 1) and trade:hasItemQty(552, 1) and count == 4) then
            player:startEvent(183) -- Correct items given, complete quest.
        else
            player:startEvent(181, 0, 0, 0, 0, 0, 0, 17316, 940) -- Incorrect or not enough items
        end
    end
end

function onTrigger(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local foiledAgain = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_AGAIN_1)
    local CFA2 = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_AGAIN_2)
    local CFAtimer = player:getCharVar("CursesFoiledAgain")
    local FoiledAGolem = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_A_GOLEM)
    local golemdelivery = player:getCharVar("foiledagolemdeliverycomplete")
    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and
        player:getCharVar("MissionStatus") == 7) then
        player:startEvent(397, 0, 0, 0, 282)
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatWindurst, 6)) then
        player:startEvent(498)
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CLASS_REUNION) == QUEST_ACCEPTED and
        player:getCharVar("ClassReunionProgress") == 3) then
        player:startEvent(409) -- she mentions that Sunny-Pabonny left for San d'Oria

        -- AMK
    elseif player:getCurrentMission(AMK) == tpz.mission.id.amk.CURSES_A_HORRIFICALLY_HARROWING_HEX then
        player:startEvent(506)

        -------------------------------------------------------
        -- Curses Foiled Again!
    elseif (foiledAgain == QUEST_AVAILABLE) then
        player:startEvent(171, 0, 0, 0, 0, 0, 0, 928, 880)
    elseif (foiledAgain == QUEST_ACCEPTED) then
        player:startEvent(172, 0, 0, 0, 0, 0, 0, 928, 880)
    elseif (foiledAgain == QUEST_COMPLETED and CFA2 == QUEST_AVAILABLE and CFAtimer == 0) then
        local cDay = VanadielDayOfTheYear()
        local cYear = VanadielYear()
        local dFinished = player:getCharVar("CursesFoiledAgainDay")
        local yFinished = player:getCharVar("CursesFoiledAgainYear")

        -- player:PrintToPlayer("Vana Day and year:  "..cDay..", "..cYear)
        -- player:PrintToPlayer("Database Day and year:  "..dFinished..", "..yFinished)

        if (cDay == dFinished and cYear == yFinished) then
            player:startEvent(174)
        elseif (cDay == dFinished + 1 and cYear == yFinished) then
            player:startEvent(178)
        elseif ((cDay >= dFinished + 2 and cYear == yFinished) or (cYear > yFinished)) then
            player:startEvent(179)
        end

        -- Curses, Foiled...Again!?
    elseif (foiledAgain == QUEST_COMPLETED and CFA2 == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 2 and
        player:getMainLvl() >= 5 and CFAtimer == 1) then
        player:startEvent(180, 0, 0, 0, 0, 928, 880, 17316, 940) -- Quest Start
    elseif (CFA2 == QUEST_ACCEPTED) then
        player:startEvent(181, 0, 0, 0, 0, 0, 0, 17316, 940) -- Reminder dialog

        -- Curses, Foiled A-Golem!?
    elseif (CFA2 == QUEST_COMPLETED and FoiledAGolem == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 4 and
        player:getMainLvl() >= 10) then
        player:startEvent(340) -- quest start
    elseif (golemdelivery == 1) then
        player:startEvent(342) -- finish
    elseif (FoiledAGolem == QUEST_ACCEPTED) then
        player:startEvent(341) -- reminder dialog

        -- Trust
        -- TODO: Wiki's aren't clear on the exact conditions for this event, assuming it's the final nation "extreme" trust
    elseif player:hasSpell(898) and -- Kupipi
    player:hasSpell(901) and -- Nanaa Mihgo
    player:hasSpell(903) and -- Volker
    player:hasSpell(904) and -- Ajido-Marujido
    player:hasSpell(905) and -- Trion
    not player:hasSpell(896) -- NOT Shantotto
    then
        player:startEvent(529, 0, 0, 0, TrustMemory(player), 0, 0, 0, FoiledAGolem == QUEST_COMPLETED and 1 or 0)

        -- Standard dialog
    elseif (FoiledAGolem == QUEST_COMPLETED) then
        player:startEvent(343) -- new standard dialog after Curses, Foiled A-Golem!?

    elseif (CFA2 == QUEST_COMPLETED) then
        player:startEvent(184) -- New standard dialog after CFA2
    elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING) and
        player:getCharVar("ShantottoCS") == 1) then
        player:startEvent(399, 0, 0, 282)
    else
        player:startEvent(164)
    end
end

function onEventFinish(player, csid, option)
    if (csid == 173) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17081)
        else
            player:tradeComplete()
            player:setCharVar("CursesFoiledAgainDay", VanadielDayOfTheYear())
            player:setCharVar("CursesFoiledAgainYear", VanadielYear())
            player:addFame(WINDURST, 80)
            player:addItem(17081)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17081)
            player:completeQuest(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_AGAIN_1)
        end
    elseif (csid == 171 and option ~= 1) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_AGAIN_1)

    elseif (csid == 179) then
        player:setCharVar("CursesFoiledAgainDayFinished", 0)
        player:setCharVar("CursesFoiledAgainYearFinished", 0)
        player:setCharVar("CursesFoiledAgainDay", 0)
        player:setCharVar("CursesFoiledAgainYear", 0)
        player:setCharVar("CursesFoiledAgain", 1) -- Used to acknowledge that the two days have passed, Use this to initiate next quest
        player:needToZone(true)

    elseif (csid == 180 and option == 3) then
        player:setCharVar("CursesFoiledAgain", 0)
        player:addQuest(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_AGAIN_2)
        player:setTitle(tpz.title.TARUTARU_MURDER_SUSPECT)

    elseif (csid == 183) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17116)
        else
            player:tradeComplete()
            player:setTitle(tpz.title.HEXER_VEXER)
            player:addItem(17116)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17116)
            player:completeQuest(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_AGAIN_2)
            player:needToZone(true)
            player:addFame(WINDURST, 90)
        end

    elseif (csid == 340) then
        if (option == 1) then
            player:addQuest(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_A_GOLEM)
        else
            player:setTitle(tpz.title.TOTAL_LOSER)
        end

    elseif (csid == 342) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4870)
        else
            player:completeQuest(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_A_GOLEM)
            player:setCharVar("foiledagolemdeliverycomplete", 0)
            player:addItem(4870)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4870)
            player:setTitle(tpz.title.DOCTOR_SHANTOTTOS_FLAVOR_OF_THE_MONTH)
            player:addFame(WINDURST, 120)
        end
    elseif (csid == 409) then
        player:setCharVar("ClassReunionProgress", 4)
    elseif (csid == 498) then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 6, true))
    elseif (csid == 397) then
        player:addKeyItem(tpz.ki.GLOVE_OF_PERPETUAL_TWILIGHT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.GLOVE_OF_PERPETUAL_TWILIGHT)
        player:setCharVar("MissionStatus", 8)
    elseif (csid == 399) then
        player:setCharVar("ShantottoCS", 0)

    elseif csid == 506 then
        player:completeMission(AMK, tpz.mission.id.amk.CURSES_A_HORRIFICALLY_HARROWING_HEX)
        player:addMission(AMK, tpz.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE)

        -- TRUST
    elseif csid == 529 and option == 2 then
        player:addSpell(896, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 896)

    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.RETRIBUTION_LEARNED)
    end
end
