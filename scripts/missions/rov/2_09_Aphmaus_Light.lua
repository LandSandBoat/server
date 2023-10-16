-----------------------------------
-- Aphmau's Light
-- Rhapsodies of Vana'diel Mission 2-7
-----------------------------------
-- !addmission 13 62
-----------------------------------
local whitegateID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.APHMAUS_LIGHT)

mission.reward =
{
    item = xi.item.CIPHER_OF_NASHMEIRAS_ALTER_EGO_II,
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
                        player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.ROYAL_PUPPETEER
                    then
                        -- NOTE: The first 4 parameters for this event change the available dialogue.  This remains all zeroes
                        -- until the player has progressed at least past TOAU21.  No changes are implemented at this time until
                        -- viable captures are obtained.

                        return mission:progressEvent(166, { text_table = 0 })
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
