-----------------------------------
-- Distant Beliefs
-- Promathia 2-3
-----------------------------------
-- !addmission 6 228
-- Minotaur    : !pos 60 0.5 304 27
-- Iron Gate   : !pos -70.800 -1.500 60.000 27
-- Ornate Gate : !pos -95 -24 60 27
-- Justinius   : !pos 76 -34 68 26
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.AN_ETERNAL_MELODY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Justinius'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 3 then
                        return mission:progressEvent(113)
                    else
                        return mission:event(123):replaceDefault()
                    end
                end,
            },

            onEventFinish =
            {
                [113] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        -- TODO: Wooden Ladder event is handled withing the NPC Script to prevent duplicating logic.  Move to this
        -- script once the NPCs for those have been named uniquely.
        [xi.zone.PHOMIUNA_AQUEDUCTS] =
        {
            ['_0r5'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(36)
                    end
                end,
            },

            ['Minotaur'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getVar(player, 'Status') == 0 then
                        mission:setVar(player, 'Status', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [36] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
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
            ['Chemioue']    = mission:event(281):replaceDefault(), -- Carries over up to beginning of Ancient Vows
            ['Mengrenaux']  = mission:event(271):replaceDefault(), -- Carries over up to beginning of Ancient Vows
        },
    },
}

return mission
