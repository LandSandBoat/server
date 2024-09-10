-----------------------------------
-- Fire in the Eyes of Men
-- Promathia 7-3
-----------------------------------
-- !addmission 6 728
-- Cid : !pos -12 -12 1 237
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)

mission.reward =
{
    title = xi.title.PRISHES_BUDDY,
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.CALM_BEFORE_THE_STORM },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.MINE_SHAFT_2716] =
        {
            ['_0d0'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(4)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    local waitTimer = mission:getVar(player, 'Timer')

                    if mission:getVar(player, 'Status') == 1 then
                        if waitTimer == 0 then
                            return mission:progressEvent(857)
                        elseif waitTimer <= VanadielUniqueDay() then
                            return mission:progressEvent(890)
                        else
                            return mission:event(858):importantEvent()
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [857] = function(player, csid, option, npc)
                    mission:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,

                [890] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
