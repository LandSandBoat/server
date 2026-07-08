-----------------------------------
-- Meeting of the Minds
-- Seekers of Adoulin M1-7
-----------------------------------
-- !addmission 12 8
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.MEETING_OF_THE_MINDS)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.ARCIELA_APPEARS_AGAIN },
}

local isDinnerTime = function()
    return VanadielHour() >= 15 and VanadielHour() <= 22
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    if isDinnerTime() then
                        return mission:progressEvent(1500)
                    else
                        return mission:progressEvent(1501) -- 257, 2 seem to be consistent parameters (first 2), could be animation, Ploh extends a hand
                    end
                end,
            },

            onEventFinish =
            {
                [1500] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.DINNER_INVITATION)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
