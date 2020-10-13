-----------------------------------
-- Area: Windurst Walls
--  NPC: Nanaa Mihgo
-- Starts and Finishes Quest: Mihgo's Amigo (R), The Tenshodo Showdown (start), Rock Racketeer (start)
-- Involved In Quest: Crying Over Onions
-- Involved in Mission 2-1
-- !pos 62 -4 240 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------

local TrustMemory = function(player)
    local memories = 0
    -- 2 - Saw her at the start of the game
    if player:getNation() == tpz.nation.WINDURST then
        memories = memories + 2
    end
    -- 4 - ROCK_RACKETEER
    if player:hasCompletedQuest(WINDURST, tpz.quest.id.windurst.ROCK_RACKETEER) then
        memories = memories + 4
    end
    -- 8 - HITTING_THE_MARQUISATE
    if player:hasCompletedQuest(WINDURST, tpz.quest.id.windurst.HITTING_THE_MARQUISATE) then
        memories = memories + 8
    end
    -- 16 - CRYING_OVER_ONIONS
    if player:hasCompletedQuest(WINDURST, tpz.quest.id.windurst.CRYING_OVER_ONIONS) then
        memories = memories + 16
    end
    -- 32 - hasItem(286) Nanaa Mihgo statue
    if player:hasItem(286) then
        memories = memories + 32
    end
    -- 64 - ROAR_A_CAT_BURGLAR_BARES_HER_FANGS
    if player:hasCompletedMission(AMK, tpz.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS) then
        memories = memories + 64
    end
    return memories
end

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, {{498, 4}}) then -- Yagudo Necklace x4
        local mihgosAmigo = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MIHGO_S_AMIGO)

        if mihgosAmigo == QUEST_ACCEPTED then
            player:startEvent(88, GIL_RATE * 200)
        elseif mihgosAmigo == QUEST_COMPLETED then
            player:startEvent(494, GIL_RATE * 200)
        end
    end
end

function onTrigger(player, npc)
    local missionStatus = player:getCharVar("MissionStatus")
    local wildcatWindurst = player:getCharVar("WildcatWindurst")
    local mihgosAmigo = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MIHGO_S_AMIGO)
    local tenshodoShowdown = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_TENSHODO_SHOWDOWN)
    local tenshodoShowdownCS = player:getCharVar("theTenshodoShowdownCS")
    local rockRacketeer = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.ROCK_RACKETEER)
    local rockRacketeerCS = player:getCharVar("rockracketeer_sold")
    local thickAsThieves = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES)
    local hittingTheMarquisate = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HITTING_THE_MARQUISATE)
    local hittingTheMarquisateYatnielCS = player:getCharVar("hittingTheMarquisateYatnielCS")
    local hittingTheMarquisateHagainCS = player:getCharVar("hittingTheMarquisateHagainCS")
    local hittingTheMarquisateNanaaCS = player:getCharVar("hittingTheMarquisateNanaaCS")
    local job = player:getMainJob()
    local lvl = player:getMainLvl()

    -- LURE OF THE WILDCAT (WINDURST 2-1)
    -- Simply checks this NPC as talked to for the PC, should be highest priority
    if
        player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 4)
    then
        player:startEvent(732)

    -- CRYING OVER ONIONS (Optional dialogue)
    -- Should be available at all times, variable gets increased to remove it from her logic to not block anything
    elseif player:getCharVar("CryingOverOnions") == 1 then
        player:startEvent(598)

    -- TRUST
    elseif player:hasKeyItem(tpz.ki.WINDURST_TRUST_PERMIT) and not player:hasSpell(901) then
        local trustFlag = (player:getRank() >=3 and 1 or 0) + (mihgosAmigo == QUEST_COMPLETED and 2 or 0)

        player:startEvent(865, 0, 0, 0, TrustMemory(player), 0, 0, 0, trustFlag)

    -- WINDURST 2-1: LOST FOR WORDS
    elseif
        player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.LOST_FOR_WORDS and
        missionStatus > 0 and missionStatus < 5
    then
        if missionStatus == 1 then
            player:startEvent(165, 0, tpz.ki.LAPIS_CORAL, tpz.ki.LAPIS_MONOCLE)
        elseif missionStatus == 2 then
            player:startEvent(166, 0, tpz.ki.LAPIS_CORAL, tpz.ki.LAPIS_MONOCLE)
        elseif missionStatus == 3 then
            player:startEvent(169)
        else
            player:startEvent(170)
        end

    -- THE TENSHODO SHOWDOWN (THF AF Weapon)
    elseif job == tpz.job.THF and lvl >= AF1_QUEST_LEVEL and tenshodoShowdown == QUEST_AVAILABLE then
        player:startEvent(496) -- start quest
    elseif tenshodoShowdownCS == 1 then
        player:startEvent(497) -- before cs at tensho HQ
    elseif tenshodoShowdownCS >= 2 then
        player:startEvent(498) -- after cs at tensho HQ
    elseif job == tpz.job.THF and lvl < AF2_QUEST_LEVEL and tenshodoShowdown == QUEST_COMPLETED then
        player:startEvent(503) -- standard dialog after

    -- THICK AS THIEVES (THF AF Head)
    elseif
        job == tpz.job.THF and lvl >= AF2_QUEST_LEVEL and
        thickAsThieves == QUEST_AVAILABLE and tenshodoShowdown == QUEST_COMPLETED
    then
        player:startEvent(504) -- start quest
    elseif thickAsThieves == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.FIRST_SIGNED_FORGED_ENVELOPE) and
            player:hasKeyItem(tpz.ki.SECOND_SIGNED_FORGED_ENVELOPE) then
            player:startEvent(508) -- complete quest
        else
            player:startEvent(505, 0, tpz.ki.GANG_WHEREABOUTS_NOTE) -- before completing grappling and gambling sidequests
        end

    -- HITTING THE MARQUISATE (THF AF Feet)
    elseif job == tpz.job.THF and lvl >= AF3_QUEST_LEVEL and
        thickAsThieves == QUEST_COMPLETED and hittingTheMarquisate == QUEST_AVAILABLE
    then
        player:startEvent(512) -- start quest
    elseif hittingTheMarquisateYatnielCS == 3 and hittingTheMarquisateHagainCS == 9 then
        player:startEvent(516) -- finish first part
    elseif hittingTheMarquisateNanaaCS == 1 then
        player:startEvent(517) -- second part

    -- ROCK RACKETEER (Mihgo's Amigo follow-up)
    elseif mihgosAmigo == QUEST_COMPLETED and rockRacketeer == QUEST_AVAILABLE and
        player:getFameLevel(WINDURST) >= 3
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
        if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CRYING_OVER_ONIONS) == QUEST_AVAILABLE then
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

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- WINDURST 2-1: LOST FOR WORDS
    if csid == 165 and option == 1 then
        npcUtil.giveKeyItem(player, tpz.ki.LAPIS_MONOCLE)
        player:setCharVar("MissionStatus", 2)
    elseif csid == 169 then
        player:setCharVar("MissionStatus", 4)
        player:setCharVar("MissionStatus_randfoss", 0)
        player:delKeyItem(tpz.ki.LAPIS_MONOCLE)
        player:delKeyItem(tpz.ki.LAPIS_CORAL)
        npcUtil.giveKeyItem(player, tpz.ki.HIDEOUT_KEY)

    -- LURE OF THE WILDCAT (WINDURST)
    elseif csid == 732 then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 4, true))

    -- CRYING OVER ONIONS
    elseif csid == 598 then
        player:setCharVar("CryingOverOnions", 2)

    -- THE TENSHODO SHOWDOWN
    elseif (csid == 496) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.THE_TENSHODO_SHOWDOWN)
        player:setCharVar("theTenshodoShowdownCS", 1)
        npcUtil.giveKeyItem(player, tpz.ki.LETTER_FROM_THE_TENSHODO)

    -- THICK AS THIEVES
    elseif (csid == 504 and option == 1) then -- start quest "as thick as thieves"
        player:addQuest(WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES)
        player:setCharVar("thickAsThievesGamblingCS", 1)
        npcUtil.giveKeyItem(player,
            {tpz.ki.GANG_WHEREABOUTS_NOTE, tpz.ki.FIRST_FORGED_ENVELOPE, tpz.ki.SECOND_FORGED_ENVELOPE})
    elseif (csid == 508 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES, {
        item = 12514,
        var = "thickAsThievesGamblingCS"
    })) then
        player:delKeyItem(tpz.ki.GANG_WHEREABOUTS_NOTE)
        player:delKeyItem(tpz.ki.FIRST_SIGNED_FORGED_ENVELOPE)
        player:delKeyItem(tpz.ki.SECOND_SIGNED_FORGED_ENVELOPE)

    -- HITTING THE MARQUISATE
    elseif csid == 512 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.HITTING_THE_MARQUISATE)
        player:setCharVar("hittingTheMarquisateYatnielCS", 1)
        player:setCharVar("hittingTheMarquisateHagainCS", 1)
        npcUtil.giveKeyItem(player, tpz.ki.CAT_BURGLARS_NOTE)
    elseif csid == 516 then
        player:setCharVar("hittingTheMarquisateNanaaCS", 1)
        player:setCharVar("hittingTheMarquisateYatnielCS", 0)
        player:setCharVar("hittingTheMarquisateHagainCS", 0)

    -- ROCK RACKETEER
    elseif csid == 93 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.ROCK_RACKETEER)
        npcUtil.giveKeyItem(player, tpz.ki.SHARP_GRAY_STONE)
    elseif csid == 98 then
        player:delGil(10 * GIL_RATE)
        player:setCharVar("rockracketeer_sold", 3)

    -- MIHGO'S AMIGO
    elseif csid == 80 or csid == 81 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.MIHGO_S_AMIGO)
    elseif csid == 88 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.MIHGO_S_AMIGO, {
        gil = 200,
        title = tpz.title.CAT_BURGLAR_GROUPIE,
        fameArea = NORG,
        fame = 60
    }) then
        player:confirmTrade()
        player:needToZone(true)
    elseif csid == 494 then
        player:confirmTrade()
        player:addTitle(tpz.title.CAT_BURGLAR_GROUPIE)
        player:addGil(GIL_RATE * 200)
        player:addFame(NORG, 30)

    elseif csid == 865 and option == 2 then
        player:addSpell(901, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 901)
    end
end
