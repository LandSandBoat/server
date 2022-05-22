-----------------------------------
-- A Shantotto Ascension
-- A Shantotto Ascension M2
-----------------------------------
-- !addmission 11 1
-----------------------------------
require('scripts/globals/missions')
require('scripts/settings/main')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
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
                        player:hasStatusEffect(xi.effect.MOUNTED) == false
                    then
                        return mission:event(71)
                    end
                end,
            },

            onEventUpdate =
            {
                [71] = function(player, csid, option, npc)
                    local kit = 2779 + math.random(0,3)
                    player:updateEvent(kit)
                    player:setCharVar("ASA_kit", kit)
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
                    if
                        prevZone == xi.zone.WINDURST_WATERS
                    then
                        return 62
                    end

                    if
                        prevZone == xi.zone.PORT_WINDURST
                    then
                        return 63
                    end
                end,
            },

            onEventUpdate =
            {
                [62] = function(player, csid, option, npc)
                    local kit = 2779 + math.random(0,3)
                    player:updateEvent(kit)
                    player:setCharVar("ASA_kit", kit)
                end,

                [63] = function(player, csid, option, npc)
                    local kit = 2779 + math.random(0,3)
                    player:updateEvent(kit)
                    player:setCharVar("ASA_kit", kit)
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
