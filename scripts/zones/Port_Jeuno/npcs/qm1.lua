-----------------------------------
-- Area: Port Jeuno
--  NPC: ???
-- Finish Quest: Borghertz's Hands (AF Hands, Many jobs)
-- !pos -51 8 -4 246
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local borghertzCS = player:getCharVar('BorghertzCS')

    if player:hasKeyItem(xi.ki.OLD_GAUNTLETS) then
        if not player:hasKeyItem(xi.ki.SHADOW_FLAMES) then
            if borghertzCS == 1 then
                player:startEvent(20) -- Request Shadow Flames KI
            elseif borghertzCS == 2 then
                player:startEvent(49) -- Reminder text
            end
        else
            player:startEvent(48) -- Get AF
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 20 and option == 1 then
        player:setCharVar('BorghertzCS', 2)
    elseif csid == 48 then
        local questJob = player:getCharVar('BorghertzAlreadyActiveWithJob')
        local quest = xi.quest.id.jeuno.BORGHERTZS_WARRING_HANDS + questJob - 1
        local reward = 13960 + questJob

        if
            npcUtil.completeQuest(player, xi.questLog.JEUNO, quest, {
                item = reward,
                var = { 'BorghertzCS', 'BorghertzAlreadyActiveWithJob' },
            })
        then
            player:delKeyItem(xi.ki.OLD_GAUNTLETS)
            player:delKeyItem(xi.ki.SHADOW_FLAMES)
        end
    end
end

return entity
