-----------------------------------
-- Balamor, The Deathborne Xol
-- Seekers of Adoulin M4-5
-----------------------------------
-- !addmission 12 99
-- Levil          : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.BALAMOR_THE_DEATHBORNE_XOL)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.ANAGNORISIS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 1, 975, 4063, 1999, 1999, 4),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Timer') <= VanadielUniqueDay() then
                        return mission:progressEvent(1536, 257, 23, 2964, 0, 87, 203, 1995, 0)
                    else
                        return mission:progressEvent(1543, 257, 645960362, 4, 0, 67108863, 93232308, 3903, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [1536] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
