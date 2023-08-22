-----------------------------------
-- Area: Lower Jeuno
--  NPC: Zalsuhm
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/equipment")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/weaponskillids")
-----------------------------------
local entity = {}

local function getQuestId(mainJobId)
    return xi.quest.id.jeuno.UNLOCKING_A_MYTH_WARRIOR - 1 + mainJobId
end

entity.onTrade = function(player, npc, trade)
    for i, wepId in pairs(xi.equipment.baseNyzulWeapons) do
        if npcUtil.tradeHasExactly(trade, wepId) then
            local unlockingAMyth = player:getQuestStatus(xi.quest.log_id.JEUNO, getQuestId(i))
            if unlockingAMyth == QUEST_ACCEPTED then
                local wsPoints = trade:getItem(0):getWeaponskillPoints()
                if wsPoints <= 49 then
                    player:startEvent(10091)
                elseif wsPoints <= 200 then
                    player:startEvent(10092)
                elseif wsPoints <= 249 then
                    player:startEvent(10093)
                elseif wsPoints >= 250 then
                    player:startEvent(10088, i)
                end
            end

            return
        end
    end
end

entity.onTrigger = function(player, npc)
    local mainJobId         = player:getMainJob()
    local unlockingAMyth    = player:getQuestStatus(xi.quest.log_id.JEUNO, getQuestId(mainJobId))
    local nyzulWeaponMain   = xi.equip.isBaseNyzulWeapon(player:getEquipID(xi.slot.MAIN))
    local nyzulWeaponRanged = xi.equip.isBaseNyzulWeapon(player:getEquipID(xi.slot.RANGED))

    if unlockingAMyth == QUEST_AVAILABLE then
        if player:needToZone() and player:getCharVar("Upset_Zalsuhm") > 0 then
            player:startEvent(10090)
        else
            if player:getCharVar("Upset_Zalsuhm") > 0 then
                player:setCharVar("Upset_Zalsuhm", 0)
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local questId = getQuestId(option)
    if csid == 10086 then
        if option == 53 then
            player:setCharVar("Upset_Zalsuhm", 1)
            player:needToZone(true)
        elseif option <= xi.job.SCH then
            player:addQuest(xi.quest.log_id.JEUNO, questId)
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

        player:completeQuest(xi.quest.log_id.JEUNO, questId)
        player:messageSpecial(ID.text.MYTHIC_LEARNED, player:getMainJob())
        player:addLearnedWeaponskill(skill)
    end
end

return entity
