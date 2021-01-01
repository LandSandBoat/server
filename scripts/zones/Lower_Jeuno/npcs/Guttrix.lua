-----------------------------------
-- Area: Lower Jeuno
--  NPC: Guttrix
-- Starts and Finishes Quest: The Goblin Tailor
-- !pos -36.010 4.499 -139.714 245
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

-----------------------------------
-- [race] = {body, hands, legs, feet}
-----------------------------------

local rse_map =
{
    [tpz.race.HUME_M]   = {12654, 12761, 12871, 13015},
    [tpz.race.HUME_F]   = {12655, 12762, 12872, 13016},
    [tpz.race.ELVAAN_M] = {12656, 12763, 12873, 13017},
    [tpz.race.ELVAAN_F] = {12657, 12764, 12874, 13018},
    [tpz.race.TARU_M]   = {12658, 12765, 12875, 13019},
    [tpz.race.TARU_F]   = {12658, 12765, 12875, 13019},
    [tpz.race.MITHRA]   = {12659, 12766, 12876, 13020},
    [tpz.race.GALKA]    = {12660, 12767, 12877, 13021},
}

local function hasRSE(player)
    local mask = 0
    local rse = rse_map[player:getRace()]

    for i = 1, #rse do
        if player:hasItem(rse[i]) then
            mask = mask + 2 ^ (i - 1)
        end
    end

    return mask
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local pFame = player:getFameLevel(JEUNO)
    local pLevel = player:getMainLvl()
    local questStatus = player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBLIN_TAILOR)
    local rseGear = hasRSE(player)
    local rseRace = VanadielRSERace()
    local rseLocation = VanadielRSELocation()

    if pLevel >= 10 and pFame >= 3 then
        if rseGear < 15 then
            if questStatus == QUEST_AVAILABLE then
                player:startEvent(10016, rseLocation, rseRace)
            elseif questStatus >= QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.MAGICAL_PATTERN) then
                player:startEvent(10018, rseGear)
            else
                player:startEvent(10017, rseLocation, rseRace)
            end
        else
            player:startEvent(10019)
        end
    else
        player:startEvent(10020)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local questStatus = player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBLIN_TAILOR)

    if csid == 10016 then
        player:addQuest(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBLIN_TAILOR)
    elseif
        csid == 10018 and
        option >= 1 and
        option <= 4 and
        questStatus >= QUEST_ACCEPTED and
        player:hasKeyItem(tpz.ki.MAGICAL_PATTERN)
    then
        if npcUtil.giveItem(player, rse_map[player:getRace()][option]) then
            if questStatus == QUEST_ACCEPTED then
                player:addFame(JEUNO, 30)
                player:completeQuest(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBLIN_TAILOR)
            end

            player:delKeyItem(tpz.ki.MAGICAL_PATTERN)
        end
    end
end
