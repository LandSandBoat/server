-----------------------------------
-- Area: Lower Jeuno
--  NPC: Zalsuhm
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
local entity = {}

local function getQuestId(mainJobId)
    return xi.quest.id.jeuno.UNLOCKING_A_MYTH_WARRIOR - 1 + mainJobId
end

entity.onTrade = function(player, npc, trade)
    for i, weaponData in pairs(xi.equipment.baseNyzulWeaponsFull) do
        local wepId = weaponData.itemId
        if npcUtil.tradeHasExactly(trade, wepId) then
            local unlockingAMyth = player:getQuestStatus(xi.questLog.JEUNO, getQuestId(i))
            if unlockingAMyth == xi.questStatus.QUEST_ACCEPTED then
                -- For use by "unlocking_a_myth" module to use pre-2014 ws point scaling on Nyzul Climb progress
                local requiredWsPoints = xi.equipment.baseNyzulWeaponRequiredWsPoints(player)
                local wsPoints = trade:getItem(0):getWeaponskillPoints()
                if wsPoints <= requiredWsPoints / 5 then
                    player:startEvent(10091)
                elseif wsPoints <= requiredWsPoints * 4 / 5 then
                    player:startEvent(10092)
                elseif wsPoints < requiredWsPoints then
                    player:startEvent(10093)
                elseif wsPoints >= requiredWsPoints then
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

entity.onEventUpdate = function(player, csid, option, npc)
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
    elseif csid == 10088 and xi.equipment.baseNyzulWeaponsFull[option] then
        local skill = xi.equipment.baseNyzulWeaponsFull[option].wsUnlockId

        player:completeQuest(xi.questLog.JEUNO, questId)
        player:messageSpecial(ID.text.MYTHIC_LEARNED, player:getMainJob())
        player:addLearnedWeaponskill(skill)
    end
end

return entity
