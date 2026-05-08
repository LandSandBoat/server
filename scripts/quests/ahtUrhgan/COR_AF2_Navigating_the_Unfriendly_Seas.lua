-----------------------------------
-- Navigating the Unfriendly Seas
-- Corsair AF2 Quest
-----------------------------------
-- !addquest 6 25
-- qm6 (H-10 / Boat): !pos 468.767 -12.292 111.817 54
-- Leleroon         : !pos -14.687 0.000 25.114 53
-- Leypoint         : !pos -200.027 -8.500 80.058 51
-----------------------------------
local wajaomID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS)

quest.reward =
{
    item = xi.item.CORSAIRS_CULOTTES,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS) == xi.questStatus.QUEST_COMPLETED and
                player:getMainJob() == xi.job.COR and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL
        end,

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(232)
                end,
            },

            onEventFinish =
            {
                [232] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NASHMAU] =
        {
            ['Leleroon'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.tradeHasExactly(trade, xi.item.HYDROGAUGE)
                    then
                        return quest:progressEvent(283)
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') >= 1 and
                        quest:getVar(player, 'Prog') < 3
                    then
                        return quest:event(292)
                    end
                end,
            },

            onEventFinish =
            {
                [283] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        player:confirmTrade()
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['Leypoint'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHasExactly(trade, xi.item.HYDROGAUGE)
                    then
                        player:confirmTrade()
                        quest:setVar(player, 'Prog', 2)
                        quest:setVar(player, 'Wait', GetSystemTime() + 60) -- 1 minute wait time
                        return quest:messageSpecial(wajaomID.text.PLACE_HYDROGAUGE, xi.item.HYDROGAUGE)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        if quest:getVar(player, 'Wait') > GetSystemTime() then
                            return quest:messageSpecial(wajaomID.text.ENIGMATIC_LIGHT, xi.item.HYDROGAUGE)
                        else
                            return quest:progressEvent(508)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [508] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    quest:setVar(player, 'Wait', 0)
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(233)
                    end
                end,
            },

            onEventFinish =
            {
                [233] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
