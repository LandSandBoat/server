-----------------------------------
-- Knot Quite There
-----------------------------------
-- !addquest 7 27
-- Door Acolyte Hostel : !pos 124.000 -3.000 222.215 94
-- Bulwark Gate        : !pos -445 0 342 98
-- Door:House          : !pos 148 0 27 80
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE)

quest.reward =
{
    item = xi.item.PLATINUM_BEASTCOIN,
}

quest.sections =
{
    -- Talk to the Door Acolyte Hostel in Windurst Waters [S].
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.BACK_TO_THE_BEGINNING) and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES)
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Door_Acolyte_Hostel_down'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(151)
                end,
            },

            onEventFinish =
            {
                [151] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Speak with the Bulwark Gate, trade a One Hundred Eight Knot Quipu,
    -- enter Southern San d'Oria [S] from East Ronfaure [S], then check the door.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Bulwark_Gate'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(105)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(107)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(108)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHasExactly(trade, { xi.item.ONE_HUNDRED_EIGHT_KNOT_QUIPU })
                    then
                        return quest:progressEvent(106)
                    end
                end,
            },

            onEventFinish =
            {
                [105] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [106] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            onZoneIn = function(player, prevZone)
                if
                    prevZone == xi.zone.EAST_RONFAURE_S and
                    quest:getVar(player, 'Prog') == 2
                then
                    return 62
                end
            end,

            ['_6eo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(63)
                    end
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [63] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
