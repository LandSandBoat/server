-----------------------------------
-- Ganged Up On
-- Rhapsodies of Vana'diel Mission 2-16
-----------------------------------
-- !addmission 13 80
-----------------------------------
local pastSandoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA_S]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.GANGED_UP_ON)

mission.reward =
{
    item        = xi.item.CIPHER_OF_LILISETTES_ALTER_EGO_II,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.SACRIFICE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Mystic_Retriever'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        if player:getFreeSlotsCount() > 0 then
                            player:messageSpecial(pastSandoriaID.text.BONDS_STRENGTHENED, 3)

                            mission:complete(player)
                        else
                            player:messageName(pastSandoriaID.text.ITEM_CANNOT_BE_OBTAINED, nil, xi.item.CIPHER_OF_LILISETTES_ALTER_EGO_II)
                        end

                        return mission:noAction()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        xi.rhapsodies.charactersAvailable(player) and
                        mission:getVar(player, 'Status') == 0
                    then
                        -- Lilisette is required for this event to occur, and was tested during repeat of
                        -- Where It All Began to reobtain Moonshade earring.  There are two patterns of
                        -- parameters that were captured, with the known breakpoint of being above or below
                        -- WotG26 (Fate in Haze)

                        -- WotG8          : 0, 0, 0, 0
                        -- WotG26, WotG50 : 1, 1, 0, 0

                        return 183
                    elseif mission:getVar(player, 'Option') == 0 then
                        return 185
                    end
                end,
            },

            onEventUpdate =
            {
                [183] = function(player, csid, option, npc)
                    if option == 1 then
                        local updateParams = { 0, 0, 0, 0 }

                        if player:getCurrentMission(xi.mission.log_id.WOTG) >= xi.mission.id.wotg.FATE_IN_HAZE then
                            updateParams[1] = 1
                            updateParams[2] = 1
                        end

                        player:updateEvent(unpack(updateParams))
                    end
                end,
            },

            onEventFinish =
            {
                [183] = function(player, csid, option, npc)
                    if player:getFreeSlotsCount() > 0 then
                        player:messageSpecial(pastSandoriaID.text.BONDS_STRENGTHENED, 3)

                        mission:complete(player)
                    else
                        player:messageName(pastSandoriaID.text.CANNOT_OBTAIN_MYSTIC, nil, xi.item.CIPHER_OF_LILISETTES_ALTER_EGO_II)
                        mission:setVar(player, 'Status', 1)
                    end
                end,

                [185] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,
            },
        },
    },
}

return mission
