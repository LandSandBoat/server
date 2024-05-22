-----------------------------------
-- Fire and Brimstone (RNG AF2)
-----------------------------------
-- Log ID: 2, Quest ID: 73
-- Perih Vashai: !pos 117 -3 92 241
-- Koh Lenbalalako: !pos -64.412 -17 29.213 249
-- Gravestone: !pos 180 -32 -56 104
-- Pool: !pos -79.0 -40.2 -76.3 151
-----------------------------------
local eldiemeID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------
local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE)

quest.reward =
{
    item     = xi.item.HUNTERS_BERET,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
            player:getMainJob() == xi.job.RNG and
            player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.SIN_HUNTING)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] = quest:progressEvent(531),

            onEventFinish =
            {
                [531] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 0 and quest:getVar(player, 'Prog') < 3 then
                        return quest:event(532) -- during RNG AF2
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(535, 0, xi.item.TWINSTONE_EARRING, xi.item.OLD_EARRING)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:event(536, 0, xi.item.TWINSTONE_EARRING, xi.item.OLD_EARRING)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.OLD_EARRING) and
                        quest:getVar(player, 'Prog') == 4
                    then
                        return quest:progressEvent(537, 0, xi.item.TWINSTONE_EARRING)
                    end
                end,
            },

            ['Kapeh_Myohrye'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 2 then -- gives dialog after viewing cs about escaping prison.
                        return quest:event(534)
                    end
                end,
            },

            ['Muhk_Johldy'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 2 then -- gives dialog after viewing cs about escaping prison.
                        return quest:event(533)
                    end
                end,
            },

            onEventFinish =
            {
                [535] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [537] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        xi.quest.setMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION)
                    end
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            ['Koh_Lenbalalako'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(10007)
                    elseif quest:getVar(player, 'Prog') == 2 then -- progress var so event wont trigger each time zoning into mhaura.
                        return quest:event(323):oncePerZone()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 1 then
                        return 10032
                    end
                end,
            },

            onEventFinish =
            {
                [10007] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:setPos(-61.3135, -16.0000, 30.3377, 114, xi.zone.MHAURA)
                end,

                [10032] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        player:getPreviousZone() == xi.zone.BATALLIA_DOWNS
                    then
                        return 4
                    end
                end,
            },

            ['Gravestone'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        if npc:getID() == eldiemeID.npc.GRAVESTONE_OFFSET then
                            return quest:progressEvent(5)
                        else
                            player:messageSpecial(eldiemeID.text.NAMES_OF_DECEASED)
                            return quest:messageSpecial(eldiemeID.text.SINNER_NOT_HERE)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Gioh_Ajihri'] = quest:event(551, 0, xi.item.TWINSTONE_EARRING):importantOnce(),
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION) == xi.questStatus.QUEST_AVAILABLE then
                        return quest:progressEvent(538):replaceDefault()
                    end
                end,
            },

            ['Muhk_Johldy'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION) == xi.questStatus.QUEST_AVAILABLE then
                        return quest:progressEvent(539):replaceDefault()
                    end
                end,
            },
        },
    },
}

return quest
