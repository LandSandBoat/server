-----------------------------------
-- Knot Quite There (WOTG Nation Quests - Windurst 3)
-----------------------------------
-- !addquest 7 27
-- Door:Acolyte Hostel : !pos 124 -3 222 94
-- Bulwark Gate        : !pos -447 -2 342 91
-- Door:House          : !pos 148 -3 24 80
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE)

quest.reward =
{
    item = xi.item.PLATINUM_BEASTCOIN,
}

quest.sections =
{
    -- Pick up the quest at the Acolyte Hostel door in Windurst Waters (S).
    -- Requires The Tigress Strikes complete and WOTG mission Cait Sith current
    -- (i.e. Back to the Beginning completed).
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES) and
                player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.BACK_TO_THE_BEGINNING)
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
                    quest:begin(player)
                end,
            },
        },
    },

    -- Escort progression: Bulwark Gate (Sauromugue Champaign [S]) -> zone into
    -- Southern San d'Oria (S) from East Ronfaure (S) -> Door:House.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            -- Reminder cutscene while the quest is active.
            ['Door_Acolyte_Hostel_down'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(152)
                end,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Bulwark_Gate'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 0 then
                        return quest:progressEvent(105)
                    elseif prog == 1 then
                        -- Pre-trade reminder to hand over the 108-Knot Quipu.
                        return quest:event(107)
                    elseif prog == 2 then
                        -- Post-trade reminder to head to Southern San d'Oria.
                        return quest:event(108)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHasExactly(trade, xi.item.ONE_HUNDRED_EIGHT_KNOT_QUIPU)
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
            ['_6eo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(63)
                    end
                end,
            },

            -- Approach cutscene with Pattna-Ottna, only when arriving on foot from
            -- East Ronfaure (S). (Retail also suppresses it while mounted; not modeled here.)
            onZoneIn = function(player, prevZone)
                if
                    prevZone == xi.zone.EAST_RONFAURE_S and
                    quest:getVar(player, 'Prog') == 2
                then
                    return 62
                end
            end,

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
