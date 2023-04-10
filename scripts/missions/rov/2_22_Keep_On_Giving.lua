-----------------------------------
-- Keep On Giving
-- Rhapsodies of Vana'diel Mission 2-22
-----------------------------------
-- !addmission 13 96
-- qm_rov2_20 : !pos -44.741 -23.753 568.504 25
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.KEEP_ON_GIVING)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.PAST_IMPERFECT },
}

local itemOptions =
{
    [0] = { xi.items.BEEF_STEWPOT,          1 },
    [1] = { xi.items.SERVING_OF_ZARU_SOBA,  1 },
    [2] = { xi.items.SPICY_CRACKER,        30 },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.MISAREAUX_COAST] =
        {
            ['qm_rov2_20'] =
            {

                onTrade = function(player, npc, trade)
                    local requiredTrade = itemOptions[mission:getVar(player, 'Option')]

                    if npcUtil.tradeHasExactly(trade, { requiredTrade }) then
                        -- NOTE: First parameter is dependent on RotZ completion status regarding Kam'lanaut living.  With minimal requirements,
                        -- this was '1', while with RotZ completed this was '3'

                        local rotzParam = player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS) and 3 or 1

                        return mission:progressEvent(17, rotzParam, 23)
                    end
                end,

                onTrigger = function(player, npc)
                    return mission:progressEvent(19, mission:getVar(player, 'Option'))
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return mission
