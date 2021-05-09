-----------------------------------
-- Unlocking a Myth (All Jobs)
-- Zalsuhm
-- !pos -33 6 -117
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/equipment")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/weaponskillids")
-- require("scripts/globals/utils/nyzul")
-----------------------------------

quest = quest or {}
quest.unlockingMyth = quest.unlockingMyth or {}

function quest.unlockingMyth.getQuestId(mainJobId)

    return (UNLOCKING_A_MYTH_WARRIOR - 1 + mainJobId)

end

function quest.unlockingMyth.onTrade(player, npc, trade)
    for jobID, wepId in pairs(nyzul.baseWeapons) do
        if npcUtil.tradeHasExactly(trade, wepId) then
            local unlockingAMyth = player:getQuestStatus(JEUNO, quest.unlockingMyth.getQuestId(jobID))
            if unlockingAMyth == QUEST_ACCEPTED then
                local wsPoints = trade:getItem(0):getWeaponskillPoints()

                -- player:PrintToPlayer(string.format("points Accumulated: %s", wsPoints))

                if wsPoints <= 50 then
                    player:startEvent(10091)
                elseif wsPoints <= 250 then
                    player:startEvent(10092)
                elseif wsPoints <= 8000 then
                    player:startEvent(10093)
                elseif wsPoints >= 16000 then
                     player:startEvent(10088, jobID)
                end
            end

            return
        end
    end
end

function quest.unlockingMyth.onTrigger(player, npc)
    local mainJobId = player:getMainJob()
    local unlockingAMyth = player:getQuestStatus(JEUNO, quest.unlockingMyth.getQuestId(mainJobId))
    local nyzulWeaponMain = nyzul.isBaseWeapon(player:getEquipID(xi.slot.MAIN))
    local nyzulWeaponRanged = nyzul.isBaseWeapon(player:getEquipID(xi.slot.RANGED))

    if unlockingAMyth == QUEST_AVAILABLE then
        if player:needToZone() and player:getVar("Quest[3][102]Prog") > 0 then
            player:startEvent(10090)
        else
            if player:getVar("Quest[3][102]Prog") > 0 then
                player:setVar("Quest[3][102]Prog", 0)
            end

            if nyzulWeaponMain or nyzulWeaponRanged then
                player:startEvent(10086, mainJobId)
            else
                player:startEvent(10085)
            end
        end
    elseif unlockingAMyth == QUEST_ACCEPTED then
        player:startEvent(10087)
    else
        player:startEvent(10089)
    end
end

function quest.unlockingMyth.onEventFinish(player, csid, option)
    local questId = quest.unlockingMyth.getQuestId(option)
    if csid == 10086 then
        if option == 53 then
            player:setVar("Quest[3][102]Prog", 1)
            player:needToZone(true)
        elseif option <= xi.job.SCH then
            player:addQuest(JEUNO, questId)
        end
    elseif csid == 10088 and option <= xi.job.SCH then
        local jobs =
        {
            [xi.job.WAR] = xi.ws_unlock.KINGS_JUSTICE,
            [xi.job.MNK] = xi.ws_unlock.ASCETICS_FURY,
            [xi.job.WHM] = xi.ws_unlock.MYSTIC_BOON,
            [xi.job.BLM] = xi.ws_unlock.VIDOHUNIR,
            [xi.job.RDM] = xi.ws_unlock.DEATH_BLOSSOM,
            [xi.job.THF] = xi.ws_unlock.MANDALIC_STAB,
            [xi.job.PLD] = xi.ws_unlock.ATONEMENT,
            [xi.job.DRK] = xi.ws_unlock.INSURGENCY,
            [xi.job.BST] = xi.ws_unlock.PRIMAL_REND,
            [xi.job.BRD] = xi.ws_unlock.MORDANT_RIME,
            [xi.job.RNG] = xi.ws_unlock.TRUEFLIGHT,
            [xi.job.SAM] = xi.ws_unlock.TACHI_RANA,
            [xi.job.NIN] = xi.ws_unlock.BLADE_KAMU,
            [xi.job.DRG] = xi.ws_unlock.DRAKESBANE,
            [xi.job.SMN] = xi.ws_unlock.GARLAND_OF_BLISS,
            [xi.job.BLU] = xi.ws_unlock.EXPIACION,
            [xi.job.COR] = xi.ws_unlock.LEADEN_SALUTE,
            [xi.job.PUP] = xi.ws_unlock.STRINGING_PUMMEL,
            [xi.job.DNC] = xi.ws_unlock.PYRRHIC_KLEOS,
            [xi.job.SCH] = xi.ws_unlock.OMNISCIENCE,
        }
        local skill = jobs[option]

        player:completeQuest(JEUNO, questId)
        player:messageSpecial(ID.text.MYTHIC_LEARNED, player:getMainJob())
        player:addLearnedWeaponskill(skill)
    end
end

return quest


--[[
Floor     Point
100     250

80-99 : 500+20(99-x)
95     580
90     680
85     780
80     880

60-79 : 1000+40(79-x)
75     1160
70     1360
65     1560
60     1760

40-59 : 2000+80(59-x)
55     2320
50     2720
45     3120
40     3520

20-39 : 4000+160(39-x)
35     4640
30     5440
25     6240
20     7040

01-19 : 8000+320*(19-x)
15     9280
10     10880
5     12480
0     16000
]]