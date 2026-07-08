-----------------------------------
-- Apocalypse Nigh
-----------------------------------
-- Log ID: 3, Quest ID: 89
-- _iya      : !pos -20 0.1 -283 34
-- Aldo      : !pos 20 3 -58 245
-- Gilgamesh : !pos 122.452 -9.009 -12.052 252
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)

quest.reward = {}

local rewardOnEventUpdate = function(player, csid, option, npc)
    if option == 99 then
        player:updateEvent(252,
            xi.item.STATIC_EARRING,
            xi.item.MAGNETIC_EARRING,
            xi.item.HOLLOW_EARRING,
            xi.item.ETHEREAL_EARRING
        )
    end
end

-- NOTE: This event is also captured in both Dawn and Awakening's mission scripts, and
-- the order may not trigger after this function.  While the missions are guaranteed to
-- complete here, the quest may not if inventory is full, but it will not errantly complete.
-- Both missions require their variables to be cleared, and is why they are handled there.

local rewardOnEventFinish = function(player, csid, option, npc)
    if
        option >= 1 and
        option <= 4
    then
        local rewardItem = xi.item.STATIC_EARRING + option - 1

        if npcUtil.giveItem(player, rewardItem) then
            quest:complete(player)
        end
    else
        quest:setVar(player, 'Prog', 6)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) and
                VanadielUniqueDay() >= vars.Timer and
                not quest:getMustZone(player)
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return quest:progressEvent(123)
                end,
            },

            onEventFinish =
            {
                [123] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SEALIONS_DEN] =
        {
            onZoneIn = function(player, prevZone)
                if quest:getVar(player, 'Prog') == 0 then
                    return 29
                end
            end,

            onEventUpdate =
            {
                [29] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(0, 0, 0, 0, 32, 3, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [29] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.GRAND_PALACE_OF_HUXZOI] =
        {
            ['_iya'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(4)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:setPos(-419.995, 0, 248.483, 191, 35)
                end,
            },
        },

        [xi.zone.EMPYREAL_PARADOX] =
        {
            onZoneIn = function(player, prevZone)
                if quest:getVar(player, 'Prog') == 4 then
                    return 7
                end
            end,

            ['TR_Entrance'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(4)
                    end
                end,
            },

            onEventUpdate =
            {
                [7] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(36, 1430550, 2964, 1013, 36, 1, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [7] = function(player, csid, option, npc)
                    player:setPos(-.0745, -10, -465.1132, 63, xi.zone.ALTAIEU)
                end,

                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == xi.battlefield.id.APOCALYPSE_NIGH and
                        quest:getVar(player, 'Prog') == 3
                    then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 4 and
                        player:getRank(player:getNation()) >= 5
                    then
                        return quest:progressEvent(10057)
                    elseif questProgress == 5 then
                        return quest:event(10058)
                    end
                end,
            },

            onEventFinish =
            {
                [10057] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['_700'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 5 and
                        quest:getVar(player, 'Timer') > VanadielUniqueDay()
                    then
                        return quest:progressEvent(235)
                    end
                end,
            },

            ['Gilgamesh'] =
            {
                onTrigger = function(player, npc)
                    if
                        VanadielUniqueDay() >= quest:getVar(player, 'Timer') and
                        not quest:getMustZone(player)
                    then
                        local questProgress = quest:getVar(player, 'Prog')

                        if questProgress == 5 then
                            return quest:progressEvent(232, 252, 6)
                        elseif questProgress == 6 then
                            return quest:progressEvent(234, 252)
                        end
                    end
                end,
            },

            onEventUpdate =
            {
                [232] = rewardOnEventUpdate,
                [234] = rewardOnEventUpdate,
            },

            onEventFinish =
            {
                [232] = rewardOnEventFinish,
                [234] = rewardOnEventFinish,

                [235] = function(player, csid, option, npc)
                    quest:setMustZone(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.EMPYREAL_PARADOX] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    for itemId = xi.item.STATIC_EARRING, xi.item.STATIC_EARRING + 3 do
                        if player:hasItem(itemId) then
                            return
                        end
                    end

                    return quest:progressEvent(5)
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
                        player:delMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_LAST_VERSE)

                        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
                        player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)

                        player:setMissionStatus(xi.mission.log_id.ZILART, 3)
                        xi.mission.setVar(player, xi.mission.log_id.COP, xi.mission.id.cop.DAWN, 'Status', 8)

                        player:delQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
                        player:delQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
                    end
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] = quest:event(233):replaceDefault(),
        },
    },
}

return quest
