-----------------------------------
-- The Gates
-- Seekers of Adoulin M4-3
-----------------------------------
-- !addmission 12 82
-- Levil            : !pos -87.204 3.350 12.655 256
-- Darkened Crevice : !pos 185.752 27.311 240.72 273
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_GATES)

mission.reward =
{
    title       = xi.title.ULBUKAN_UNDERSTUDY,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.MORIMAR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(165),
        },

        [xi.zone.WOH_GATES] =
        {
            ['Large_Animal_Track'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.TUFT_OF_GOLDEN_FUR) then
                        npcUtil.giveKeyItem(player, xi.ki.TUFT_OF_GOLDEN_FUR)

                        return mission:noAction()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 9
                    end
                end,
            },

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.CIRDAS_CAVERNS_U] =
        {
            onEventFinish =
            {
                -- TODO: The assumption for this mission script is to catch Event 1000 which is
                -- sent once the battlefield has been cleared.  This needs to be verified upon
                -- implementation of the instance.
                [1000] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                    player:setPos(182.053, 29.962, 240.197, 131, xi.zone.WOH_GATES)
                end,
            },
        },
    },
}

return mission
