------------------------------------
-- Carbuncle Debacle
-- !addquest 2 83
-- Koru-moru !pos -120 -6 124 239
------------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
require('scripts/globals/titles')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CARBUNCLE_DEBACLE)

quest.reward =
{
    item            =   xi.items.EVOKERS_HORN,
    fame            =   60,
    fameArea        =   xi.quest.fame_area.WINDURST,
    title           =   xi.title.PARAGON_OF_SUMMONER_EXCELLENCE,
}

quest.sections =
{
    --Section: Quest Available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL and
                player:getMainJob() == xi.job.SMN and
                not quest:getMustZone(player) and
                player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION) == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['_6n2'] = quest:progressEvent(415),

            onEventFinish =
            {
                [415] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },
        --Section: Quest Accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(416)
                    elseif questProgress == 4 then
                        return quest:progressEvent(417)
                    elseif questProgress == 5 then
                        return quest:event(418)
                    elseif questProgress == 7 then
                        return quest:progressEvent(419)
                    end
                end,
            },

            onEventFinish =
            {
                [416] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [417] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    npcUtil.giveKeyItem(player, xi.ki.DAZE_BREAKER_CHARM)
                end,

                [419] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            ['Ripapa'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(10022)
                    elseif
                        questProgress == 3 and
                        not player:hasItem(xi.items.LIGHTNING_PENDULUM)
                    then
                        return quest:progressEvent(10023)
                    end
                end,
            },

            onEventFinish =
            {
                [10022] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.LIGHTNING_PENDULUM)
                    quest:setVar(player, 'Prog', 3)
                end,

                [10023] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.LIGHTNING_PENDULUM)
                end,
            },
        },

        [xi.zone.CLOISTER_OF_STORMS] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 449 and
                        quest:getVar(player, 'Prog') == 3
                    then
                        quest:setVar(player, 'Prog', 4)
                    end
                end
            },
        },

        [xi.zone.RABAO] =
        {
            ['Agado-Pugado'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 5 and
                        player:hasKeyItem(xi.ki.DAZE_BREAKER_CHARM)
                    then
                        return quest:progressEvent(86)
                    elseif
                        questProgress == 6 and
                        not player:hasItem(xi.items.WIND_PENDULUM)
                    then
                        return quest:progressEvent(87)
                    else
                        return quest:event(88)
                    end
                end,
            },

            onEventFinish =
            {
                [86] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.WIND_PENDULUM)
                    quest:setVar(player, 'Prog', 6)
                end,

                [87] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.WIND_PENDULUM)
                end
            },
        },

        [xi.zone.CLOISTER_OF_GALES] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 417 and
                        quest:getVar(player, 'Prog') == 6
                    then
                        quest:setVar(player, 'Prog', 7)
                        player:delKeyItem(xi.ki.DAZE_BREAKER_CHARM)
                    end
                end
            },
        },
    },

    --Section: Quest Complete
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        ['Koru-Moru'] = quest:event(420):replaceDefault(),
    },
}

return quest
