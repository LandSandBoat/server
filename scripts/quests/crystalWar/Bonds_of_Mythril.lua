-----------------------------------
-- Bonds of Mythril
-----------------------------------
-- !addquest 7 59
-- Gentle Tiger    : !pos -203.932 -9.998 2.237 87
-- ??? (qm)        : !pos -384.257 -51.999 -95.783 155
-- Throne Room [S] : !pos -115.849 -8.657 0.000 156
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BONDS_OF_MYTHRIL)
local keepID = zones[xi.zone.CASTLE_ZVAHL_KEEP_S]

quest.reward =
{
    item  = xi.item.EXCELSIS_RING,
    title = xi.title.TEMPERER_OF_MYTHRIL,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TRUTH_LIES_HID) and
                player:getCurrentMission(xi.mission.log_id.WOTG) >= xi.mission.id.wotg.ADIEU_LILISETTE
        end,

        [xi.zone.CASTLE_ZVAHL_BAILEYS_S] =
        {
            onZoneIn = function(player, prevZone)
                if prevZone == xi.zone.CASTLE_ZVAHL_KEEP_S then
                    return 13
                end
            end,

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.CASTLE_ZVAHL_KEEP_S] =
        {
            ['qm'] = quest:progressEvent(17),

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.CASTLE_ZVAHL_KEEP_S] =
        {
            ['qm'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'ImpKills') >= 4 then
                        if npcUtil.popFromQM(player, npc, keepID.mob.GARGOUILLE_WARDEN, { hide = 0 }) then
                            quest:setVar(player, 'ImpKills', 0)
                        end

                        return quest:messageSpecial(keepID.text.A_SHIVER_RUNS_DOWN)
                    end

                    return quest:progressEvent(17)
                end,
            },

            ['Keep_Imp'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 1 then
                        local impKills = quest:getVar(player, 'ImpKills')
                        quest:setVar(player, 'ImpKills', math.min(4, impKills + 1))
                    end
                end,
            },

            ['Gargouille_Warden'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.CASTLE_ZVAHL_KEEP_S] =
        {
            ['qm'] = quest:progressEvent(18),

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    npcUtil.giveKeyItem(player, xi.ki.ZVAHL_PASSKEY)
                end,
            },
        },
    },

    {
        check = function(player, status)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasKeyItem(xi.ki.ZVAHL_PASSKEY)
        end,

        [xi.zone.THRONE_ROOM_S] =
        {
            ['_4c1'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(12)
                    end
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                -- Bonds of Mythril battlefield is not implemented currently.
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == xi.battlefield.id.BONDS_OF_MYTHRIL and
                        quest:getVar(player, 'Prog') == 4
                    then
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 5
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(213, 87, 0, 2964, 0)
                end,
            },

            onEventFinish =
            {
                [213] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                    player:setPos(52.272, -14.000, -0.017, 127, xi.zone.METALWORKS)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 6
        end,

        [xi.zone.METALWORKS] =
        {
            onZoneIn = function(player, prevZone)
                return 972
            end,

            onEventFinish =
            {
                [972] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                    player:setPos(380.062, 0.753, 147.908, 194, xi.zone.NORTH_GUSTABERG_S)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 7
        end,

        [xi.zone.NORTH_GUSTABERG_S] =
        {
            onZoneIn = function(player, prevZone)
                return 13
            end,

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ZVAHL_PASSKEY)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(214):replaceDefault(),
        },

        [xi.zone.METALWORKS] =
        {
            ['Naji'] = quest:event(971):replaceDefault(),
        },
    },
}

return quest
