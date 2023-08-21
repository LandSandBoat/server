-----------------------------------
-- Call to Serve
-- Rhapsodies of Vana'diel Mission 2-3
-----------------------------------
-- !addmission 13 48
-----------------------------------
local portJeunoID = zones[xi.zone.PORT_JEUNO]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.CALL_TO_SERVE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.NUMBERING_DAYS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.PORT_JEUNO] =
        {
            -- Receiving this Alter Ego is required for completing the mission, so we can handle it here.
            ['Mystic_Retriever'] =
            {
                onTrigger = function(player, npc)
                    if
                        mission:getVar(player, 'Retrieve') == 1 and
                        npcUtil.giveItem(player, xi.item.CIPHER_OF_PRISHES_ALTER_EGO_II)
                    then
                        mission:complete(player)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        xi.rhapsodies.charactersAvailable(player) and
                        mission:getVar(player, 'Retrieve') == 0
                    then
                        -- Note: Working with the assumption that there are four variable parameters for this mission,
                        -- the following observations have been made.  The first parameter *does* have an impact on dialogue
                        -- however, it was not observed in caps (A 1-value makes Prishe sound at best more vulnerable).  The
                        -- second parameter seems to align with having completed Darkness Named, which like previous events,
                        -- moves from a 0-value to 2.

                        -- Unknown ----------------------------.
                        -- Unknown -------------------------.  |
                        -- CoP Progress  ----------------.  |  |
                        -- Unknown -------------------.  |  |  |
                        --                            |  |  |  |
                        -- Minimum Progress         : 0, 0, 1, 1
                        -- Darkness Named Completed : 0, 2, 1, 1

                        -- Inferring the second parameter to the above scheme, and leaving the other three values as static.

                        return 399
                    elseif mission:getVar(player, 'Status') == 0 then
                        return 402
                    end
                end,
            },

            onEventUpdate =
            {
                [399] = function(player, csid, option, npc)
                    if option == 1 then
                        local hasCompletedDarkness = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) and 2 or 0

                        player:updateEvent(0, hasCompletedDarkness, 1, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [399] = function(player, csid, option, npc)
                    if player:getFreeSlotsCount() == 0 then
                        player:messageSpecial(portJeunoID.text.MYSTIC_RETRIEVER, xi.item.CIPHER_OF_PRISHES_ALTER_EGO_II)
                        mission:setVar(player, 'Retrieve', 1)
                    else
                        npcUtil.giveItem(player, xi.item.CIPHER_OF_PRISHES_ALTER_EGO_II)
                        mission:complete(player)
                    end
                end,

                [402] = function(player, csid, option, npc)
                    -- Unable to proceed message is only displayed once ever.
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },
    },
}

return mission
