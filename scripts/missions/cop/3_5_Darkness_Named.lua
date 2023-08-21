-----------------------------------
-- Darkness Named
-- Promathia 3-5
-----------------------------------
-- !addmission 6 358
-- Door: Neptune's Spire : !pos 35 0 -15 245
-- Monberaux             : !pos -42 0 -2 244
-----------------------------------
local upperJeunoID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:event(7):importantEvent()
                    end
                end,
            },

            ['Ghebi_Damomohe'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:hasKeyItem(xi.ki.PSOXJA_PASS) and
                        mission:getVar(player, 'Status') == 2 and
                        (
                            npcUtil.tradeHasExactly(trade, xi.item.CARMINE_CHIP) or
                            npcUtil.tradeHasExactly(trade, xi.item.CYAN_CHIP) or
                            npcUtil.tradeHasExactly(trade, xi.item.GRAY_CHIP)
                        )
                    then
                        return mission:progressEvent(52, 500 * xi.settings.main.GIL_RATE)
                    end
                end,

                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 1 then
                        return mission:progressEvent(54)
                    elseif missionStatus == 2 then
                        return mission:event(53):importantEvent()
                    end
                end,
            },

            -- TODO: Some of Harnek's events duplicate dialogue but with the Neptune's Spire door
            -- first opening.  Since Tenshodo membership is not required, there may be alternative
            -- ways to see these messages. (Event 13 is the NPC version, Event 10 is the Door)
            ['Harnek'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:event(13):importantEvent()
                    end
                end,
            },

            ['Sattal-Mansal'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:event(11):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [52] = function(player, csid, option, npc)
                    player:confirmTrade()

                    npcUtil.giveCurrency(player, 'gil', 500)
                    npcUtil.giveKeyItem(player, xi.ki.PSOXJA_PASS)
                    mission:setVar(player, 'Status', 3)
                end,

                [54] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Monberaux'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return mission:progressEvent(82)
                    elseif missionStatus == 1 then
                        return mission:event(3):importantOnce()
                    elseif missionStatus == 5 then
                        return mission:progressEvent(75)
                    end
                end,
            },

            onEventFinish =
            {
                [75] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [82] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MYSTERIOUS_AMULET)
                    player:messageSpecial(upperJeunoID.text.LEND_PRISHE_AMULET, xi.ki.MYSTERIOUS_AMULET)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.THE_SHROUDED_MAW] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 3 then
                        return 2
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 4)
                end,

                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 704 and
                        mission:getVar(player, 'Status') == 4
                    then
                        player:addTitle(xi.title.TRANSIENT_DREAMER)
                        mission:setVar(player, 'Status', 5)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Chemioue']     = mission:event(282):replaceDefault(),
            ['Justinius']    = mission:event(129):replaceDefault(),
            ['Parelbriaux']  = mission:event(296):replaceDefault(),

            ['Arquil'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS) then
                        return mission:event(292):replaceDefault()
                    end
                end,
            },

            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS) then
                        return mission:event(315):replaceDefault()
                    end
                end,
            },
        },
    },
}

return mission
