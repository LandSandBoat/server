-----------------------------------
-- Dawn
-- Promathia 8-4
-----------------------------------
-- !addmission 6 828
-- Hinaree      : !pos -301.535 -10.199 97.698 230
-- Chipmy-Popmy : !pos -183.02 -2.835 73.905 240
-- Warmachine   : !pos -345.236 -3.188 -976.563 4
-- Cid          : !pos -12 -12 1 237
-- _6s1         : !pos -96.6 -0.2 92.3 244
-- _0qa         : !pos 111 -41 41 26
-- TODO: Add additional section to complete mission that aligns with Apocalypse Nigh
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE },
}

local ringItems =
{
    xi.item.RAJAS_RING,
    xi.item.SATTVA_RING,
    xi.item.TAMAS_RING,
}

local ringOnEventUpdate = function(player, csid, option, npc)
    if option == 4 then
        player:updateEvent(unpack(ringItems))
    end
end

local ringOnEventFinish = function(player, csid, option, npc)
    if
        option >= 5 and
        option <= 7 and
        npcUtil.giveItem(player, ringItems[option - 4])
    then
        mission:setVar(player, 'firstRing', 0)
    end
end

local missionOnEventFinish = function(player, csid, option, npc)
    if
        option >= 1 and
        option <= 4 and
        mission:getVar(player, 'Status') == 8
    then
        mission:complete(player)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId
        end,

        [xi.zone.THE_GARDEN_OF_RUHMET] =
        {
            ['_0zy'] =
            {
                onTrigger = function(player, npc)
                    if player:getZPos() <= 360 then
                        return mission:progressEvent(140)
                    else
                        return mission:progressEvent(141)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EMPYREAL_PARADOX] =
        {
            onZoneIn = function(player, prevZone)
                local missionStatus = mission:getVar(player, 'Status')

                if missionStatus == 2 then
                    return 6
                elseif missionStatus == 3 then
                    return 3
                end
            end,

            ['TR_Entrance'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [3] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.TEAR_OF_ALTANA)
                    mission:setVar(player, 'Timer', 1, JstMidnight())
                    mission:setVar(player, 'Option', 31)
                    mission:setVar(player, 'Status', 4)
                    player:setPos(0.18, -10, -470.43, 63, xi.zone.ALTAIEU)
                end,

                [6] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                    player:setPos(540, 0, -514, 63, xi.zone.EMPYREAL_PARADOX)
                end,

                [32001] = function(player, csid, option, npc)
                    if
                        mission:getVar(player, 'Status') == 1 and
                        player:getLocalVar('battlefieldWin') == xi.battlefield.id.DAWN
                    then
                        mission:setVar(player, 'Status', 2)
                    end
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if
                        mission:getVar(player, 'Status') == 4 and
                        mission:getVar(player, 'Option') == 0
                    then
                        return mission:progressEvent(122)
                    end
                end,
            },

            onEventFinish =
            {
                [122] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 5)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s1'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 5 then
                        return mission:progressEvent(129)
                    end
                end,
            },

            onEventFinish =
            {
                [129] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 6)
                    mission:setVar(player, 'firstRing', 1)
                end,
            },
        },

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['_0qa'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 6 then
                        return mission:progressEvent(543)
                    end
                end,
            },

            onEventFinish =
            {
                [543] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 7)
                end,
            },
        },

        [xi.zone.LUFAISE_MEADOWS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if mission:getVar(player, 'Status') == 7 then
                        return mission:progressEvent(116)
                    end
                end,
            },

            onEventFinish =
            {
                [116] = function(player, csid, option, npc)
                    player:addTitle(xi.title.BANISHER_OF_EMPTINESS)
                    mission:setVar(player, 'Status', 8)
                end,
            },
        },

        [xi.zone.NORG] =
        {
            onEventFinish =
            {
                [232] = missionOnEventFinish,
                [234] = missionOnEventFinish,
            },
        },
    },

    -- Final Cutscenes - Louverance (Bit 0)
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                vars.Status == 4 and
                vars.Timer == 0 and
                utils.mask.getBit(vars.Option, 0)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if mission:getVar(player, 'LProg') == 2 then
                        return mission:progressEvent(758)
                    end
                end,
            },

            ['Hinaree'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'LProg') == 0 then
                        return mission:progressEvent(757)
                    end
                end,
            },

            onEventFinish =
            {
                [757] = function(player, csid, option, npc)
                    mission:setVar(player, 'LProg', 1)
                end,

                [758] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', utils.mask.setBit(mission:getVar(player, 'Option'), 0, false))
                end,
            },
        },

        [xi.zone.ULEGUERAND_RANGE] =
        {
            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'LProg') == 1 then
                    return 17
                end
            end,

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    mission:setVar(player, 'LProg', 2)
                end,
            },
        },
    },

    -- Final Cutscenes - Chebukkis (Bit 1)
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                vars.Status == 4 and
                vars.Timer == 0 and
                (utils.mask.getBit(vars.Option, 1) or vars.coloredDropId > 0)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Chipmy-Popmy'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'CProg') == 0 then
                        return mission:progressEvent(619)
                    end
                end,
            },

            onEventFinish =
            {
                [619] = function(player, csid, option, npc)
                    mission:setVar(player, 'CProg', 1)
                end,
            },
        },

        [xi.zone.BIBIKI_BAY] =
        {
            ['Warmachine'] =
            {
                onTrigger = function(player, npc)
                    local coloredDropId = mission:getVar(player, 'coloredDropId')

                    if
                        coloredDropId > 0 and
                        npcUtil.giveItem(player, coloredDropId)
                    then
                        mission:setVar(player, 'coloredDropId', 0)
                    elseif mission:getVar(player, 'CProg') == 1 then
                        return mission:progressEvent(43)
                    end
                end,
            },

            onEventFinish =
            {
                [43] = function(player, csid, option, npc)
                    local coloredDropId = xi.item.RED_DROP + math.random(0, 7)

                    if not npcUtil.giveItem(player, coloredDropId) then
                        mission:setVar(player, 'coloredDropId', coloredDropId)
                    end

                    mission:setVar(player, 'Option', utils.mask.setBit(mission:getVar(player, 'Option'), 1, false))
                end,
            },
        },
    },

    -- Final Cutscenes - Shikarees (Bit 2)
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                vars.Status == 4 and
                vars.Timer == 0 and
                utils.mask.getBit(vars.Option, 2)
        end,

        [xi.zone.MHAURA] =
        {
            onZoneIn = function(player, prevZone)
                return 322
            end,

            onEventFinish =
            {
                [322] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', utils.mask.setBit(mission:getVar(player, 'Option'), 2, false))
                end,
            },
        },
    },

    -- Final Cutscenes - Jabbos (Bit 3)
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                vars.Status == 4 and
                vars.Timer == 0 and
                utils.mask.getBit(vars.Option, 3)
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            onZoneIn = function(player, prevZone)
                return 57
            end,

            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', utils.mask.setBit(mission:getVar(player, 'Option'), 3, false))
                end,
            },
        },
    },

    -- Final Cutscenes - Tenzen (Bit 4)
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                vars.Status == 4 and
                vars.Timer == 0 and
                utils.mask.getBit(vars.Option, 4)
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] = mission:progressEvent(897),

            onEventFinish =
            {
                [897] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', utils.mask.setBit(mission:getVar(player, 'Option'), 4, false))
                end,
            },
        },
    },

    -- Ring granting or replacement
    {
        check = function(player, currentMission, missionStatus, vars)
            return ((currentMission == mission.missionId and
                vars.Status >= 6) or
                player:hasCompletedMission(mission.areaId, mission.missionId)) and
                vars.Timer == 0
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s1'] =
            {
                onTrigger = function(player, npc)
                    for _, itemId in ipairs(ringItems) do
                        if player:hasItem(itemId) then
                            return
                        end
                    end

                    local eventId = mission:getVar(player, 'firstRing') == 1 and 84 or 204
                    return mission:progressEvent(eventId)
                end,
            },

            onEventUpdate =
            {
                [84]  = ringOnEventUpdate,
                [204] = ringOnEventUpdate,
            },

            onEventFinish =
            {
                [84]  = ringOnEventFinish,
                [204] = ringOnEventFinish,
            },
        },
    },
}

return mission
