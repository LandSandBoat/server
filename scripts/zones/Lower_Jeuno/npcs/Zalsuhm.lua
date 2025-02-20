-----------------------------------
-- Area: Lower Jeuno
--  NPC: Zalsuhm
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

local function getQuestId(mainJobId)
    return xi.quest.id.jeuno.UNLOCKING_A_MYTH_WARRIOR - 1 + mainJobId
end

entity.onTrade = function(player, npc, trade)
    for i, wepId in pairs(xi.equipment.baseNyzulWeapons) do
        if npcUtil.tradeHasExactly(trade, wepId) then
            local unlockingAMyth = player:getQuestStatus(xi.questLog.JEUNO, getQuestId(i))
            if unlockingAMyth == xi.questStatus.QUEST_ACCEPTED then
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
    local unlockingAMyth    = player:getQuestStatus(xi.questLog.JEUNO, getQuestId(mainJobId))
    local nyzulWeaponMain   = xi.equip.isBaseNyzulWeapon(player:getEquipID(xi.slot.MAIN))
    local nyzulWeaponRanged = xi.equip.isBaseNyzulWeapon(player:getEquipID(xi.slot.RANGED))

    if unlockingAMyth == xi.questStatus.QUEST_AVAILABLE then
        if player:needToZone() and player:getCharVar('Upset_Zalsuhm') > 0 then
            player:startEvent(10090)
        else
            if player:getCharVar('Upset_Zalsuhm') > 0 then
                player:setCharVar('Upset_Zalsuhm', 0)
            end

            if nyzulWeaponMain or nyzulWeaponRanged then
                player:startEvent(10086, mainJobId)
            else
                player:startEvent(10085)
            end
        end
    elseif unlockingAMyth == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(10087)
    else
        player:startEvent(10089)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local questId = getQuestId(option)
    if csid == 10086 then
        if option == 53 then
            player:setCharVar('Upset_Zalsuhm', 1)
            player:needToZone(true)
        elseif option <= xi.job.SCH then
            player:addQuest(xi.questLog.JEUNO, questId)
        end
    elseif csid == 10088 and option <= xi.job.SCH then
        local jobs =
        {
            [xi.job.WAR] = xi.wsUnlock.KINGS_JUSTICE,
            [xi.job.MNK] = xi.wsUnlock.ASCETICS_FURY,
            [xi.job.WHM] = xi.wsUnlock.MYSTIC_BOON,
            [xi.job.BLM] = xi.wsUnlock.VIDOHUNIR,
            [xi.job.RDM] = xi.wsUnlock.DEATH_BLOSSOM,
            [xi.job.THF] = xi.wsUnlock.MANDALIC_STAB,
            [xi.job.PLD] = xi.wsUnlock.ATONEMENT,
            [xi.job.DRK] = xi.wsUnlock.INSURGENCY,
            [xi.job.BST] = xi.wsUnlock.PRIMAL_REND,
            [xi.job.BRD] = xi.wsUnlock.MORDANT_RIME,
            [xi.job.RNG] = xi.wsUnlock.TRUEFLIGHT,
            [xi.job.SAM] = xi.wsUnlock.TACHI_RANA,
            [xi.job.NIN] = xi.wsUnlock.BLADE_KAMU,
            [xi.job.DRG] = xi.wsUnlock.DRAKESBANE,
            [xi.job.SMN] = xi.wsUnlock.GARLAND_OF_BLISS,
            [xi.job.BLU] = xi.wsUnlock.EXPIACION,
            [xi.job.COR] = xi.wsUnlock.LEADEN_SALUTE,
            [xi.job.PUP] = xi.wsUnlock.STRINGING_PUMMEL,
            [xi.job.DNC] = xi.wsUnlock.PYRRHIC_KLEOS,
            [xi.job.SCH] = xi.wsUnlock.OMNISCIENCE,
        }
        local skill = jobs[option]

        player:completeQuest(xi.questLog.JEUNO, questId)
        player:messageSpecial(ID.text.MYTHIC_LEARNED, player:getMainJob())
        player:addLearnedWeaponskill(skill)
    end
end

return entity
