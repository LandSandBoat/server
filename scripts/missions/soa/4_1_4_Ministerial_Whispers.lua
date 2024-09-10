-----------------------------------
-- Ministerial Whispers
-- Seekers of Adoulin M4-1-4
-----------------------------------
-- !addmission 12 75
-- Levil   : !pos -87.204 3.350 12.655 256
-- Kipligg : !pos -32 0 22 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.MINISTERIAL_WHISPERS)

mission.reward =
{
    bayld       = 500,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.A_DAY_IN_THE_LIFE_OF_A_PIONEER },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Kipligg'] = mission:event(163):setPriority(101), -- TODO: This overrides default logic in NPC script
            ['Levil']   = mission:progressEvent(158),

            onEventFinish =
            {
                [158] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.A_DAY_IN_THE_LIFE_OF_A_PIONEER, 'Timer', VanadielUniqueDay() + 1)
                        xi.mission.setMustZone(player, xi.mission.log_id.SOA, xi.mission.id.soa.A_DAY_IN_THE_LIFE_OF_A_PIONEER)
                    end
                end,
            },
        },
    },
}

return mission
