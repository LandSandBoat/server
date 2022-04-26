-----------------------------------
-- Aphmau's Light
-- Rhapsodies of Vana'diel Mission 2-7
-----------------------------------
-- !addmission 13 62
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------
local whitegateID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.APHMAUS_LIGHT)

mission.reward =
{
    item = xi.items.CIPHER_OF_NASHMEIRAS_ALT_EGO_II,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.REUNITED },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    if
                        xi.rhapsodies.charactersAvailable(player) and
                        player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.ROYAL_PUPPETEER
                    then
                        -- TODO: Mask Documentation

                        return mission:progressEvent(166, 0, 0, 0, 0)
                    else
                        return mission:messageSpecial(whitegateID.text.UNABLE_TO_PROGRESS_ROV)
                    end
                end,
            },

            onEventFinish =
            {
                [166] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
