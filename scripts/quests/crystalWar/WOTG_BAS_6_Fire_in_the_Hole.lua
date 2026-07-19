-----------------------------------
-- Fire in the Hole
-----------------------------------
-- !addquest 7 36
-- Stonehoused Adit : !pos -434.655 36.708 279.983 88
-- Gentle Tiger     : !pos -203.932 -9.998 2.237 87
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRE_IN_THE_HOLE)

quest.reward =
{
    item  = xi.item.REPUBLICAN_SILVER_MEDAL,
    title = xi.title.MYTHRIL_MUSKETEER_NO_6,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.STORM_ON_THE_HORIZON) and
                player:getCurrentMission(xi.mission.log_id.WOTG) >= xi.mission.id.wotg.IN_THE_NAME_OF_THE_FATHER
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            onZoneIn = function(player, prevZone)
                if prevZone == xi.zone.NORTH_GUSTABERG_S then
                    return 60
                end
            end,

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    player:startEvent(77)
                end,

                [77] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.SILVERMINE_KEY)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTH_GUSTABERG_S] =
        {
            ['Stonehoused_Adit'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        player:hasKeyItem(xi.ki.SILVERMINE_KEY)
                    then
                        return quest:progressEvent(5)
                    end
                end,
            },

            ['Solitary_Ant'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress >= 0 and
                        questProgress <= 1 and
                        player:hasKeyItem(xi.ki.SILVERMINE_KEY)
                    then
                        return quest:progressEvent(7)
                    elseif
                        questProgress >= 2 and
                        not player:hasKeyItem(xi.ki.SILVERMINE_KEY)
                    then
                        return quest:progressEvent(8)
                    end
                end,
            },

            onZoneIn = function(player, prevZone)
                if
                    quest:getVar(player, 'Prog') == 3 and
                    prevZone == xi.zone.RUHOTZ_SILVERMINES
                then
                    return 6
                end
            end,

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [6] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [8] = function(player, csid, option, npc)
                    if npc and npc:getName() == 'Solitary_Ant' then
                        npcUtil.giveKeyItem(player, xi.ki.SILVERMINE_KEY)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },

        [xi.zone.RUHOTZ_SILVERMINES] =
        {
            -- Fire in the Hole instance is not implemented currently
            onEventFinish =
            {
                [10000] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS_S] =
        {
            onZoneIn = function(player, prevZone)
                if
                    quest:getVar(player, 'Prog') == 4 and
                    prevZone == xi.zone.NORTH_GUSTABERG_S
                then
                    return 62
                end
            end,

            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 5 then
                        return quest:progressEvent(63)
                    elseif questProgress == 6 then
                        return quest:progressEvent(65)
                    end
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [63] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [65] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
