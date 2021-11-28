-----------------------------------
-- Imperial Schemes
-- Aht Uhrgan Mission 11
-----------------------------------
-- !addmission 4 10
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------
require("scripts/globals/besieged")
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.IMPERIAL_SCHEMES)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.ROYAL_PUPPETEER },
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
            ['Naja_Salaheem'] = mission:progressEvent(3070, 0, 0, 0, 0, 0, 0, 0, 0, 0),

            onEventFinish =
            {
                [3070] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setCharVar('Mission[4][11]Timer', VanadielUniqueDay() + 1)
                        player:setLocalVar('Mission[4][11]mustZone', 1)
                    end
                end,
            },
        },
    },
}

return mission
