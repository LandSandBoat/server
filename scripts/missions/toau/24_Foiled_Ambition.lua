-----------------------------------
-- Foiled Ambition
-- Aht Uhrgan Mission 24
-----------------------------------
-- !addmission 4 23
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.FOILED_AMBITION)

mission.reward =
{
    item        = { { xi.items.IMPERIAL_GOLD_PIECE, 5 } },
    title       = xi.title.KARABABAS_SECRET_AGENT,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.PLAYING_THE_PART },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                not mission:getMustZone(player) and
                VanadielUniqueDay() >= mission:getVar(player, 'Timer')
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    return mission:progressEvent(3097, { text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [3097] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setLocalVar('Mission[4][24]mustZone', 1)
                        player:setCharVar('Mission[4][24]Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
