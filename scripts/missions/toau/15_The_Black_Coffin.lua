-----------------------------------
-- The Black Coffin
-- Aht Uhrgan Mission 15
-----------------------------------
-- !addmission 4 14
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_BLACK_COFFIN)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.GHOSTS_OF_THE_PAST },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(3073, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if
                        player:hasKeyItem(xi.keyItem.EPHRAMADIAN_GOLD_COIN) and
                        player:getMissionStatus(mission.areaId) == 0
                    then
                        player:startEvent(8)
                        player:startEvent(34, { [7] = 1, isHidden = true })
                        return mission:progressEvent(35, { isHidden = true })
                    elseif
                        not player:hasKeyItem(xi.keyItem.EPHRAMADIAN_GOLD_COIN) and
                        player:getMissionStatus(mission.areaId) == 1
                    then
                        return mission:event(12):oncePerZone()
                    end
                end,
            },

            onZoneIn = function(player, prevZone)
                if
                    prevZone == xi.zone.THE_ASHU_TALIF and
                    player:getMissionStatus(mission.areaId) == 2
                then
                    player:setPos(-444.059, -4.124, -413.934, 126)
                    return 9
                end
            end,

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                    player:setPos(0, 0, 0, 0, xi.zone.NASHMAU)
                end,

                [35] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },

        [xi.zone.NASHMAU] =
        {
            onZoneIn = function(player, prevZone)
                if
                    prevZone == xi.zone.ARRAPAGO_REEF and
                    player:getMissionStatus(mission.areaId) == 3 and
                    player:getXPos() == 0 and
                    player:getYPos() == 0 and
                    player:getZPos() == 0
                then
                    player:setPos(0.016, 0, -23.753, 63)
                    return 281
                end
            end,

            onEventFinish =
            {
                [281] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
