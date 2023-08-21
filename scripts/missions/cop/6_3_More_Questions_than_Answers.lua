-----------------------------------
-- More Questions than Answers
-- Promathia 6-3
-----------------------------------
-- !addmission 6 628
-- Pherimociel : !pos -31.627 1.002 67.956 243
-- Mathilde    : !pos 12.578 -8.287 -7.576 248
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['_6r9'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(10050)
                    end
                end,
            },

            ['Pherimociel'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return mission:progressEvent(10049)
                    elseif missionStatus == 1 then
                        return mission:event(10053)
                    elseif missionStatus == 2 then
                        return mission:event(10063)
                    end
                end,
            },

            ['Auchefort'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:event(10054)
                    else
                        return mission:event(9)
                    end
                end,
            },

            -- TODO: These persist across multiple missions.  Once the pattern has been established,
            -- these should move into a separate block.
            ['Adolie']          = mission:event(158),
            ['Chapi_Galepilai'] = mission:event(12),
            ['Colti']           = mission:event(22),
            ['Neraf-Najiruf']   = mission:event(31):oncePerZone(),

            onEventFinish =
            {
                [10049] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [10050] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Mathilde'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(10005)
                    end
                end,
            },

            onEventFinish =
            {
                [10005] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
