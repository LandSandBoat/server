-----------------------------------
-- A Shantotto Ascension
-- A Shantotto Ascension M2
-----------------------------------
-- !addmission 11 1
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EAST_SARUTABARUTA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.WINDURST_WOODS and
                        not player:hasStatusEffect(xi.effect.MOUNTED)
                    then
                        return mission:event(71)
                    end
                end,
            },

            onEventUpdate =
            {
                [71] = function(player, csid, option, npc)
                    local kit = 2779 + math.random(0, 3)
                    player:updateEvent(kit)
                    xi.mission.setVar(player, xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD, 'Option', kit)
                end,
            },

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.WINDURST_WATERS then
                        return 62
                    elseif prevZone == xi.zone.PORT_WINDURST then
                        return 63
                    end
                end,
            },

            onEventUpdate =
            {
                [62] = function(player, csid, option, npc)
                    local kit = 2779 + math.random(0, 3)
                    player:updateEvent(kit)
                    xi.mission.setVar(player, xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD, 'Option', kit)
                end,

                [63] = function(player, csid, option, npc)
                    local kit = 2779 + math.random(0, 3)
                    player:updateEvent(kit)
                    xi.mission.setVar(player, xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD, 'Option', kit)
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [63] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
