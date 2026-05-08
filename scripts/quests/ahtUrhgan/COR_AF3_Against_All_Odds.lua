-----------------------------------
-- Against All Odds
-- Corsair AF3 Quest
-----------------------------------
-- !addquest 6 26
-- Ratihb   : !pos 75.225 -6.000 -137.203 50
-- Cutter   : !pos -462 -2 -394 54
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS)

quest.reward =
{
    item  = xi.item.CORSAIRS_TRICORNE,
    title = xi.title.PARAGON_OF_CORSAIR_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == xi.questStatus.QUEST_COMPLETED and
                player:getMainJob() == xi.job.COR and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onRegionEnter =
            {
                [5] = function(player, region)
                    return quest:progressEvent(797)
                end,
            },

            onEventFinish =
            {
                [797] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.LIFE_FLOAT)
                    quest:setVar(player, 'Wait', JstMidnight())
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ratihb'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        not player:hasKeyItem(xi.ki.LIFE_FLOAT) and
                        (
                            quest:getVar(player, 'Wait') < GetSystemTime() or
                            quest:getVar(player, 'Wait') == 0
                        )
                    then
                        return quest:progressEvent(798)
                    end
                end,
            },

            onEventFinish =
            {
                [798] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LIFE_FLOAT)
                    quest:setVar(player, 'Wait', JstMidnight())
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['Cutter'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(238)
                    end
                end,
            },

            onRegionEnter =
            {
                [1] = function(player, region)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(237)
                    end
                end,
            },

            onZoneIn = function(player, prevZone)
                if
                    prevZone == xi.zone.THE_ASHU_TALIF and
                    quest:getVar(player, 'Prog') == 2
                then
                    return 238
                end
            end,

            onEventFinish =
            {
                [237] = function(player, csid, option, npc)
                    player:startEvent(240)
                end,

                [238] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [240] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },
}

return quest
