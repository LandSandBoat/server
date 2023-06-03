-----------------------------------
-- Area: Lower Jeuno
--  NPC: Guttrix
-- Starts and Finishes Quest: The Goblin Tailor
-- !pos -36.010 4.499 -139.714 245
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local rseMap =
{
    -- [race] = { body, hands, legs, feet }
    [xi.race.HUME_M]   = { 12654, 12761, 12871, 13015 },
    [xi.race.HUME_F]   = { 12655, 12762, 12872, 13016 },
    [xi.race.ELVAAN_M] = { 12656, 12763, 12873, 13017 },
    [xi.race.ELVAAN_F] = { 12657, 12764, 12874, 13018 },
    [xi.race.TARU_M]   = { 12658, 12765, 12875, 13019 },
    [xi.race.TARU_F]   = { 12658, 12765, 12875, 13019 },
    [xi.race.MITHRA]   = { 12659, 12766, 12876, 13020 },
    [xi.race.GALKA]    = { 12660, 12767, 12877, 13021 },
}

local function hasRSE(player)
    local mask = 0
    local rse = rseMap[player:getRace()]

    for i = 1, #rse do
        if player:hasItem(rse[i]) then
            mask = mask + 2 ^ (i - 1)
        end
    end

    return mask
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local questStatus = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBLIN_TAILOR)
    local rseGear     = hasRSE(player)
    local rseRace     = VanadielRSERace()
    local rseLocation = VanadielRSELocation()

    if
        player:getMainLvl() >= 10 and
        player:getFameLevel(xi.quest.fame_area.JEUNO) >= 3
    then
        if rseGear < 15 then
            if questStatus == QUEST_AVAILABLE then
                player:startEvent(10016, rseLocation, rseRace)
            elseif
                questStatus >= QUEST_ACCEPTED and
                player:hasKeyItem(xi.ki.MAGICAL_PATTERN)
            then
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local questStatus = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBLIN_TAILOR)

    if csid == 10016 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBLIN_TAILOR)
    elseif
        csid == 10018 and
        option >= 1 and
        option <= 4 and
        questStatus >= QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.MAGICAL_PATTERN)
    then
        if npcUtil.giveItem(player, rseMap[player:getRace()][option]) then
            if questStatus == QUEST_ACCEPTED then
                player:addFame(xi.quest.fame_area.JEUNO, 30)
                player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBLIN_TAILOR)
            end

            player:delKeyItem(xi.ki.MAGICAL_PATTERN)
        end
    end
end

return entity
