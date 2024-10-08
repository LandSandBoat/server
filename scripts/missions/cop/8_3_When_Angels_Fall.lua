-----------------------------------
-- When Angels Fall
-- Promathia 8-3
-----------------------------------
-- !addmission 6 828
-- _iz2              : !pos 422.351 -5.180 -100.000 35
-- Ebon_Panel_Mithra : !pos 100.000 -5.180 -337.661 35
-- Ebon_Panel_Elvaan : !pos 740.000 -5.180 -342.352 35
-- Ebon_Panel_Taru   : !pos 257.650 -5.180 -699.999 35
-- Ebon_Panel_Galka  : !pos 577.648 -5.180 -700.000 35
-- _0z0              : !pos 420 -2.05 400 35
-----------------------------------
local altaieuID = zones[xi.zone.ALTAIEU]
local ruhmetID  = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.DAWN },
}

local ebonPanel =
{
    ['_iz2']              = { 1, 120, xi.ki.LIGHT_OF_VAHZL   },
    ['Ebon_Panel_Elvaan'] = { 2, 121, xi.ki.LIGHT_OF_MEA     },
    ['Ebon_Panel_Taru']   = { 3, 123, xi.ki.LIGHT_OF_HOLLA   },
    ['Ebon_Panel_Mithra'] = { 4, 124, xi.ki.LIGHT_OF_DEM     },
    ['Ebon_Panel_Galka']  = { 5, 122, xi.ki.LIGHT_OF_ALTAIEU },
}

local ebonPanelOnTrigger = function(player, npc)
    local missionStatus = mission:getVar(player, 'Status')

    if missionStatus == 1 then
        return mission:progressEvent(202)
    elseif missionStatus == 2 then
        local basicRace = player:getRace() <= xi.race.MITHRA and math.ceil(player:getRace() / 2) or 5
        local panelData = ebonPanel[npc:getName()]

        if basicRace == panelData[1] then
            if player:checkDistance(npc) <= 1.8 then
                return mission:progressEvent(panelData[2])
            else
                return mission:messageSpecial(ruhmetID.text.YOU_MUST_MOVE_CLOSER)
            end
        end
    end
end

local ebonPanelOnEventFinish = function(player, csid, option, npc)
    if option == 1 then
        npcUtil.giveKeyItem(player, ebonPanel[npc:getName()][3])
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        mission:setVar(player, 'Status', 3)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.THE_GARDEN_OF_RUHMET] =
        {
            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'Status') == 0 then
                    return 201
                end
            end,

            ['_iz2']              = ebonPanelOnTrigger,
            ['Ebon_Panel_Elvaan'] = ebonPanelOnTrigger,
            ['Ebon_Panel_Taru']   = ebonPanelOnTrigger,
            ['Ebon_Panel_Mithra'] = ebonPanelOnTrigger,
            ['Ebon_Panel_Galka']  = ebonPanelOnTrigger,

            ['_0z0'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 3 then
                        return mission:progressEvent(203)
                    elseif missionStatus == 5 then
                        return mission:event(205)
                    end
                end,
            },

            ['_0zt'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 5 then
                        return mission:progressEvent(204)
                    end
                end,
            },

            ['_0zu'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_DAWN) then
                        return mission:progressEvent(110)
                    end
                end,
            },

            ['_0zv'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_TWILIGHT) then
                        return mission:progressEvent(111)
                    end
                end,
            },

            onEventFinish =
            {
                [110] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.BRAND_OF_DAWN)
                    end
                end,

                [111] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.BRAND_OF_TWILIGHT)
                    end
                end,

                [120] = ebonPanelOnEventFinish,
                [121] = ebonPanelOnEventFinish,
                [122] = ebonPanelOnEventFinish,
                [123] = ebonPanelOnEventFinish,
                [124] = ebonPanelOnEventFinish,

                [201] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MYSTERIOUS_AMULET_PRISHE)
                    mission:setVar(player, 'Status', 1)
                end,

                [202] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,

                [203] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 4)
                end,

                [204] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 6)
                end,

                [32001] = function(player, csid, option, npc)
                    -- NOTE: Moving the player for this event is handled in the battlefield script.

                    if
                        player:getLocalVar('battlefieldWin') == xi.battlefield.id.WHEN_ANGELS_FALL and
                        mission:getVar(player, 'Status') == 4
                    then
                        mission:setVar(player, 'Status', 5)
                    end
                end,
            },
        },

        [xi.zone.ALTAIEU] =
        {
            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'Status') == 6 then
                    return 165
                end
            end,

            onEventFinish =
            {
                [165] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MYSTERIOUS_AMULET_PRISHE)
                    player:messageSpecial(altaieuID.text.RETURN_AMULET_TO_PRISHE, xi.ki.MYSTERIOUS_AMULET)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
