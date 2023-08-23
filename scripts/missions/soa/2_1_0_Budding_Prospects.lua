-----------------------------------
-- Budding Prospects
-- Seekers of Adoulin M2-1
-----------------------------------
-- !addmission 12 11
-- Masad : !pos -28.182 -0.650 -91.991 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.BUDDING_PROSPECTS)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHT_SHINING_IN_YOUR_EYES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(102),

            ['Masad'] =
            {
                onTrigger = function(player, npc)
                    local waitTimer = mission:getVar(player, 'Timer')

                    if
                        player:hasCompletedQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FLAVORS_OF_OUR_LIVES) or
                        (
                            waitTimer ~= 0 and
                            waitTimer <= VanadielUniqueDay() and
                            xi.quest.getVar(player, xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FLAVORS_OF_OUR_LIVES, 'Prog') >= 2
                        )
                    then
                        return mission:progressEvent(8)
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
