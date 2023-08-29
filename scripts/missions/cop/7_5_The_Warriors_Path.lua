-----------------------------------
-- The Warrior's Path
-- Promathia 7-5
-----------------------------------
-- !addmission 6 748
-- Iron Gate : !pos 612 132 774 32
-----------------------------------
local altaieuID = zones[xi.zone.ALTAIEU]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH)

mission.reward =
{
    title = xi.title.SEEKER_OF_THE_LIGHT,
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY },
}

local stolenKeyTable =
{
    [1] = xi.ki.LIGHT_OF_VAHZL,
    [2] = xi.ki.LIGHT_OF_MEA,
    [3] = xi.ki.LIGHT_OF_HOLLA,
    [4] = xi.ki.LIGHT_OF_DEM,
    [5] = xi.ki.LIGHT_OF_ALTAIEU,
}

local function getStolenKeyItem(player)
    local raceId = player:getRace() <= xi.race.MITHRA and math.ceil(player:getRace() / 2) or 5

    return stolenKeyTable[raceId]
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SEALIONS_DEN] =
        {
            ['_0w0'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(32)
                    end
                end,
            },

            ['Sueleen'] = mission:event(28),

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        return 34
                    end
                end,
            },

            onEventUpdate =
            {
                [32] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(32, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [32] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [34] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                    player:setPos(-422.100, 0, -532.092, 220, xi.zone.ALTAIEU)
                end,

                [32001] = function(player, csid, option, npc)
                    if
                        mission:getVar(player, 'Status') == 1 and
                        player:getLocalVar('battlefieldWin') == 993
                    then
                        mission:setVar(player, 'Status', 2)
                        player:setPos(612.057, 132.664, 776.920, 188, xi.zone.SEALIONS_DEN)
                    end
                end,
            },
        },

        [xi.zone.ALTAIEU] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 3 then
                        -- NOTE: Event Options 1 and 2 come for update requests, no observed responses
                        -- this may be related to RotZ progress, since Kam'Lanaut shows up as ???
                        return 1
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    local stolenLight = getStolenKeyItem(player)

                    player:delKeyItem(xi.ki.MYSTERIOUS_AMULET_DRAINED)
                    player:messageSpecial(altaieuID.text.AMULET_SHATTERED, xi.ki.MYSTERIOUS_AMULET)

                    if stolenLight ~= xi.ki.LIGHT_OF_ALTAIEU then
                        player:delKeyItem(stolenLight)
                        player:messageSpecial(altaieuID.text.LIGHT_STOLEN, stolenLight)
                        npcUtil.giveKeyItem(player, xi.ki.LIGHT_OF_ALTAIEU)
                    else
                        player:messageSpecial(altaieuID.text.OBTAIN_BUT_STOLEN, stolenLight)
                    end

                    mission:complete(player)
                    mission:setVar(player, 'Option', 1)
                    -- Setup var for initial interactions with Sagheera.
                    -- This is a bitfield that has its bits removed as the player completes the necessary interactions.
                    player:setCharVar('SagheeraInteractions', 7)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.SEALIONS_DEN] =
        {
            ['Sueleen'] = mission:event(12),

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Option') == 1 then
                        return 18
                    end
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    if option == 1 then
                        xi.teleport.to(player, xi.teleport.id.SEA)
                    end
                end,

                [18] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 0)
                end,
            },
        },
    },
}

return mission
