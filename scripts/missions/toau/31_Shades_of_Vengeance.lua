-----------------------------------
-- Shades of Vengeance
-- Aht Uhrgan Mission 31
-----------------------------------
-- !addmission 4 30
-- Nashib : !pos -274.334 -9.287 -64.255 79
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.SHADES_OF_VENGEANCE)

mission.reward =
{
    title       = xi.title.NASHMEIRAS_MERCENARY,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.IN_THE_BLOOD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['Nashib'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT) and
                        VanadielUniqueDay() >= mission:getVar(player, 'Timer')
                    then
                        return mission:progressEvent(22)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 21
                    end
                end,
            },

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [22] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)
                end,
            },
        },
    },
}

return mission
