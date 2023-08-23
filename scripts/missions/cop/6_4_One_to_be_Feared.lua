-----------------------------------
-- One to be Feared
-- Promathia 6-4
-----------------------------------
-- !addmission 6 638
-- Cid       : !pos -12 -12 1 237
-- Iron Gate : !pos 612 132 774 32
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(856)
                    end
                end,
            },

            onEventFinish =
            {
                [856] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire']     = mission:event(318),
            ['Ironclad_Gorilla'] = mission:event(306),
            ['Justinius']        = mission:event(267),
        },

        [xi.zone.SEALIONS_DEN] =
        {
            ['_0w0'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(31)
                    end
                end,
            },

            ['Sueleen'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:event(24)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 1 then
                        return 15
                    elseif missionStatus == 4 then
                        return 33
                    end
                end,
            },

            onEventUpdate =
            {
                [15] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(0, 0, 0, 0, 32, 2, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,

                [31] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                end,

                [33] = function(player, csid, option, npc)
                    mission:complete(player)
                    player:setPos(407.389, -0.262, -72.964, 96, xi.zone.LUFAISE_MEADOWS)
                end,

                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 992 and
                        mission:getVar(player, 'Status') == 3
                    then
                        -- While we could queue this, any disconnect would cause the player to have to
                        -- repeat this fight.  Retail handles event 33 as onZoneIn, and this implementation
                        -- both matches and provides safety in the above scenario.
                        mission:setVar(player, 'Status', 4)
                        player:setPos(612.057, 132.664, 776.920, 188, xi.zone.SEALIONS_DEN)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Ironclad_Gorilla'] = mission:event(306):replaceDefault(),
        },
    },
}

return mission
