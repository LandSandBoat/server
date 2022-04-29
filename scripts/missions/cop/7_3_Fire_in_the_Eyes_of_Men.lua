-----------------------------------
-- Fire in the Eyes of Men
-- Promathia 7-3
-----------------------------------
-- !addmission 6 728
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/titles')
require('scripts/globals/utils')
require('scripts/globals/zone')
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
                    mission:setVar(player, 'Status', 1) -- Verify Location on end: -87.410 180 499.929 127 13
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
                            return mission:progressEvent(890) -- Check params 0,1,2,3, and 8 (first 4 0, last was 1)
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
