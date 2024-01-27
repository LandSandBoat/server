-----------------------------------
-- Boy and the Beast
-----------------------------------
-- !addquest 7 24
-- Rholont     : !pos -168 -2 56 80
-- qm7         : !pos -26 -31 364
-- Leafy Patch : !pos -418 -33 576
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BOY_AND_THE_BEAST)

quest.reward =
{
    item = xi.item.CARBON_FISHING_ROD,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.BACK_TO_THE_BEGINNING)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Raustigne'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(55)
                    end
                end,
            },

            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(56)
                    elseif questProgress == 2 then
                        return quest:event(57)
                    end
                end,
            },

            onEventFinish =
            {
                [55] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [56] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.VUNKERL_INLET_S] =
        {
            ['qm7'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(105)
                    end
                end,
            },

            onEventFinish =
            {
                [105] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.VUNKERL_HERB_MEMO)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.VUNKERL_INLET_S] =
        {
            ['qm7'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.VUNKERL_HERB) then
                        if quest:getVar(player, 'Prog') == 3 then
                            return quest:progressEvent(108)
                        else
                            return quest:progressEvent(109)
                        end
                    else
                        -- NOTE: The below two events are "Nothing out of the Ordinary" events; however, Event 110
                        -- is only displayed the first time in this state.  Unknown use at this time, but implemented
                        -- for accuracy.  This Option var is actually reset every time a different event from this
                        -- point fires.

                        if quest:getVar(player, 'Option') == 0 then
                            return quest:event(110)
                        else
                            return quest:event(111)
                        end
                    end
                end,
            },

            ['Leafy_Patch'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.VUNKERL_HERB) then
                        local vanadielHour = VanadielHour()
                        local hourParam = 0

                        if vanadielHour >= 16 then
                            hourParam = 2
                        elseif vanadielHour >= 8 then
                            hourParam = 1
                        end

                        return quest:progressEvent(107, hourParam)
                    end
                end,
            },

            onEventFinish =
            {
                [107] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 3)
                    end

                    npcUtil.giveKeyItem(player, xi.ki.VUNKERL_HERB)
                end,

                [108] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.VUNKERL_HERB)
                        player:delKeyItem(xi.ki.VUNKERL_HERB_MEMO)
                    end
                end,

                [109] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.VUNKERL_HERB)
                end,

                [110] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,
            },
        },
    },
}

return quest
