-----------------------------------
-- Land of Sacred Serpents
-- Aht Uhrgan Mission 1
-----------------------------------
-- NOTE: xi.mission.id.toau.LAND_OF_SACRED_SERPENTS is set on character creation
-- !addmission 4 0
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.LAND_OF_SACRED_SERPENTS)

mission.reward =
{
    keyItem     = xi.ki.SUPPLIES_PACKAGE,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.IMMORTAL_SENTRIES },
}

mission.sections =
{
    {
        -- NOTE: I don't know HOW would someone get to Whitegate without the Boarding Permit Key Item, but it's probably for the best to add the additional check.
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                xi.settings.main.ENABLE_TOAU == 1 and
                player:hasKeyItem(xi.ki.BOARDING_PERMIT)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    -- Naja Salaheem interactions require the 9th argument set to 0.
                    -- This is because Aht Uhrgan Whitegate uses 2 different dats.
                    return mission:progressEvent(3000, { text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [3000] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
