-----------------------------------
-- Kumhau, the Flashfrost Naakual
-- Seekers of Adoulin M3-6-1
-----------------------------------
-- !addmission 12 63
-- Crawling Cave : !pos -349.302 40.339 -379.79 267
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.KUMHAU_THE_FLASHFROST_NAAKUAL)

mission.reward =
{
    keyItem     = xi.ki.AUREATE_BALL_OF_FUR,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.SOUL_SIPHON },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 0 then
                        return mission:progressEvent(145)
                    else
                        return mission:event(152)
                    end
                end,
            },

            onEventFinish =
            {
                [145] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.KAMIHR_DRIFTS] =
        {
            ['Crawling_Cave'] = mission:progressEvent(30),

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        return 31
                    end
                end,
            },

            onEventFinish =
            {
                [30] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                    player:setPos(429.938, 0.412, 176.818, 128, xi.zone.CEIZAK_BATTLEGROUNDS)
                end,

                [31] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.CEIZAK_BATTLEGROUNDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 27
                    end
                end,
            },

            onEventUpdate =
            {
                [27] = function(player, csid, option, npc)
                    -- TODO: This may be unnecessary, but was observed in captures
                    if option == 1 then
                        player:updateEvent(109, 0, 100, 100, utils.MAX_UINT32 - 72772, 80, 1203, 196654)
                    end
                end,
            },

            onEventFinish =
            {
                [27] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                    player:setPos(344.003, 40.676, -381.140, 12, xi.zone.KAMIHR_DRIFTS)
                end,
            },
        },
    },
}

return mission
