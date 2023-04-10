-----------------------------------
-- Easterly Winds
-- Aht Uhrgan Mission 6
-----------------------------------
-- !addmission 4 5
-- Halver : !pos 2 0.1 0.1 233
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.EASTERLY_WINDS)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.WESTERLY_WINDS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(565)
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return mission:progressEvent(10094)
                end,
            },

            onEventFinish =
            {
                [10094] = function(player, csid, option, npc)
                    -- NOTE: We don't want to fall through and complete if the player's inventory is full.
                    -- This is the reasoning for the two different mission:complete() calls.

                    if option == 1 then
                        if npcUtil.giveItem(player, { { xi.items.IMPERIAL_BRONZE_PIECE, 10 } }) then
                            mission:complete(player)
                        end
                    else
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
