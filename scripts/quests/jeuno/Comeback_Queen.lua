-----------------------------------
-- Comeback Queen
-----------------------------------
-- !addquest 3 98
-- Laila        : !pos -54.045 -1 100.996 244
-- Rhea Myuliah : !pos -56.220 -1 101.805 244
-- Harmodios    : !pos -79.928 -4.824 -135.114 235
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN)

quest.reward =
{
    title = xi.title.ELEGANT_DANCER,
}

-- The final series of events for this quest involve several onZoneIn cutscenes back to back; however,
-- the player doesn't move.  Increment quest var with this function, and force a zone in their current
-- position.  This also ensures that things will resume where left off if the player disconnects.
local function progressZone(player)
    local currentPos = player:getPos()

    quest:incrementVar(player, 'Prog', 1)
    player:setPos(currentPos['x'], currentPos['y'], currentPos['z'], currentPos['rot'], xi.zone.UPPER_JEUNO)
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.DNC and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL and
                player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_DIVADOM) and
                not quest:getMustZone(player) and
                quest:getVar(player, 'Timer') <= VanadielUniqueDay()
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Laila'] = quest:progressEvent(10143),

            onEventFinish =
            {
                [10143] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.WYATTS_PROPOSAL)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Laila'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(10144)
                    elseif questProgress == 1 then
                        return quest:progressEvent(10147)
                    elseif questProgress <= 3 then
                        local progressOffset = questProgress - 2

                        if VanadielUniqueDay() < quest:getVar(player, 'Timer') then
                            -- Timer active - First time: 10148, Repeat: 10152
                            return quest:progressEvent(10148 + (4 * progressOffset))
                        else
                            return quest:progressEvent(10151, progressOffset)
                        end
                    elseif questProgress == 8 then
                        return quest:progressEvent(10154)
                    end
                end,
            },

            ['Olgald'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        -- Blocking event after the Dancer Tailor series (10167 and 10168), for those quests
                        -- 10167 is a progressEvent, 10168 is oncePerZone()

                        return quest:event(10146):setPriority(995)
                    elseif questProgress <= 2 then
                        return quest:event(10150):setPriority(995)
                    elseif questProgress == 3 then
                        return quest:event(10153):setPriority(995)
                    end
                end,
            },

            ['Rhea_Myuliah'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress <= 1 then
                        return quest:progressEvent(10145)
                    elseif questProgress <= 3 then
                        return quest:progressEvent(10149)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 4 then
                        return 10208
                    elseif questProgress == 5 then
                        return 10209
                    elseif questProgress == 6 then
                        return 10210
                    elseif questProgress == 7 then
                        return 10211
                    end
                end,
            },

            onEventFinish =
            {
                [10147] = function(player, csid, option, npc)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    quest:setVar(player, 'Prog', 2)
                end,

                [10151] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                        quest:setMustZone(player)
                        quest:setVar(player, 'Prog', 3)
                    else
                        progressZone(player)
                    end
                end,

                [10154] = function(player, csid, option, npc)
                    local dancersCasaque = xi.items.DANCERS_CASAQUE_F - player:getGender()

                    if npcUtil.giveItem(player, dancersCasaque) then
                        quest:complete(player)

                        player:setCharVar('Quest[3][99]Timer', VanadielUniqueDay() + 1)
                        player:setLocalVar('Quest[3][99]mustZone', 1)
                    end
                end,

                [10208] = function(player, csid, option, npc)
                    progressZone(player)
                end,

                [10209] = function(player, csid, option, npc)
                    progressZone(player)
                end,

                [10210] = function(player, csid, option, npc)
                    progressZone(player)
                end,

                [10211] = function(player, csid, option, npc)
                    local dancersCasaque = xi.items.DANCERS_CASAQUE_F - player:getGender()

                    if npcUtil.giveItem(player, dancersCasaque) then
                        quest:complete(player)

                        player:setCharVar('Quest[3][99]Timer', VanadielUniqueDay() + 1)
                        player:setLocalVar('Quest[3][99]mustZone', 1)
                    else
                        quest:setVar(player, 'Prog', 8)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Harmodios'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(490)
                    else
                        return quest:event(491):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [490] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.WYATTS_PROPOSAL)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            -- TODO: This condition may change with the implementation of
            -- Dancer Limit Break
            return status == QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Alfrieda']     = quest:event(10157):replaceDefault(),
            ['Finnela']      = quest:event(10159):replaceDefault(),
            ['Laila']        = quest:event(10154):replaceDefault(),
            ['Olgald']       = quest:event(10156):replaceDefault(),
            ['Rhea_Myuliah'] = quest:event(10155):replaceDefault(),
            ['Turlough']     = quest:event(10158):replaceDefault(),
        },
    },
}

return quest
