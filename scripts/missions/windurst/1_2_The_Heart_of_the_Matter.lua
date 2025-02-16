-----------------------------------
-- The Heart of the Matter
-- Windurst M1-2
-----------------------------------
-- !addmission 2 1
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Apururu          : !pos -11 -2 13 241
-- Pore-Ohre        : !pos 261 -17 -458 116
-- Outer Horu. Ruin : !pos 466 0 -660 194
-- _5e9 - Gate      : !pos 584 0 -660 194
-----------------------------------
local eastSarutabarutaID   = zones[xi.zone.EAST_SARUTABARUTA]
local outerHorutotoRuinsID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_HEART_OF_THE_MATTER)
local msgBase = outerHorutotoRuinsID.text.ORB_ALREADY_PLACED

mission.reward =
{
    rankPoints = 250,
}

local darkOrbKI =
{
    xi.ki.FIRST_DARK_MANA_ORB,
    xi.ki.SECOND_DARK_MANA_ORB,
    xi.ki.THIRD_DARK_MANA_ORB,
    xi.ki.FOURTH_DARK_MANA_ORB,
    xi.ki.FIFTH_DARK_MANA_ORB,
    xi.ki.SIXTH_DARK_MANA_ORB,
}

local glowingOrbKI =
{
    xi.ki.FIRST_GLOWING_MANA_ORB,
    xi.ki.SECOND_GLOWING_MANA_ORB,
    xi.ki.THIRD_GLOWING_MANA_ORB,
    xi.ki.FOURTH_GLOWING_MANA_ORB,
    xi.ki.FIFTH_GLOWING_MANA_ORB,
    xi.ki.SIXTH_GLOWING_MANA_ORB,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 1 then
        mission:begin(player)
        player:setMissionStatus(mission.areaId, 1)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

local gizmoOnTrigger = function(player, gizmoNum, placeCS, collectCS)
    -- first section handling placing orbs
    if player:getMissionStatus(mission.areaId) == 3 then
        -- has orb been placed here?
        if not mission:isVarBitsSet(player, 'GizmoUsed', gizmoNum) then
            -- place orb
            return mission:event(placeCS)
        else
            -- orb has been already been placed
            player:messageSpecial(msgBase) -- "A dark Mana Orb is already placed here."
        end
    -- second section collecting orbs
    elseif player:getMissionStatus(mission.areaId) == 4 then
        -- collect orb
        if not mission:isVarBitsSet(player, 'GizmoEmpty', gizmoNum) then
            return mission:event(collectCS)
        else
            --orb has already been retrieved
            player:messageSpecial(msgBase + 3) -- "You have already retrieved a glowing Mana Orb from here."
        end
    end
end

local placeOrb = function(player, csid, option, npc)
    local gizmoNum = npc:getID() - outerHorutotoRuinsID.npc.GATE_MAGICAL_GIZMO -- gizmoNum will be 1 through 6
    local numberPlaced = mission:getVar(player, 'OrbsPlaced')
    local ki = darkOrbKI[(numberPlaced + 1)]

    mission:setVarBit(player, 'GizmoUsed', gizmoNum)
    mission:setVar(player, 'OrbsPlaced', (numberPlaced + 1))
    player:messageSpecial(msgBase + 1, 0, 0, ki) -- "The <ki> has been placed into the receptacle."
    player:delKeyItem(ki)

    -- final orb placed triggers additional message
    if mission:getVar(player, 'OrbsPlaced') == 6 then
        player:messageSpecial(msgBase + 5) -- "You have set all of the dark Mana Orbs in place."
    end
end

local collectOrb = function(player, csid, option, npc)
    local gizmoNum = npc:getID() - outerHorutotoRuinsID.npc.GATE_MAGICAL_GIZMO -- gizmoNum will be 1 through 6
    local numberCollected = mission:getVar(player, 'OrbsCollected')
    local ki = glowingOrbKI[(numberCollected + 1)]

    mission:setVarBit(player, 'GizmoEmpty', gizmoNum)
    mission:setVar(player, 'OrbsCollected', numberCollected + 1)
    npcUtil.giveKeyItem(player, ki)

    -- collected all the orbs
    if mission:getVar(player, 'OrbsCollected') == 6 then
        player:messageSpecial(msgBase + 4) -- "You have retrieved all of the glowing Mana Orbs."
        player:setMissionStatus(mission.areaId, 5)
        mission:setVar(player, 'OrbsCollected', 0)
        mission:setVar(player, 'GizmoEmpty', 0)
    end
end

mission.sections =
{
    -- Player is offered mission from a gate guard. Note that retail will have the
    -- player be presented with the mission selection menu, choose, accept, and then
    -- start the events below, where you accept it again.
    -- Choosing to keep the existing flow we had already.
    {
        check = function(player, currentMission)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId and
                not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onEventFinish =
            {
                [93] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onEventFinish =
            {
                [111] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onEventFinish =
            {
                [114] = handleAcceptMission,
            },
        },
    },

    -- Mission has been accepted, these NPCs dialogue does not change during mission
    {
        check = function(player, currentMission)
            return currentMission == mission.missionId
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Janshura-Rashura'] = mission:event(105),
            ['Nine_of_Clubs']    = mission:event(106),
            ['Puo_Rhen']         = mission:event(108),
            ['Ten_of_Clubs']     = mission:event(107),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Chawo_Shipeynyo'] = mission:event(110),
            ['Keo-Koruo']       = mission:event(108),
            ['Pakke-Pokke']     = mission:event(109),
            ['Zokima-Rokima']   = mission:event(107),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Dagoza-Beruza'] = mission:event(132),
            ['Mokyokyo']      = mission:event(131),
            ['Panna-Donna']   = mission:event(133),
            ['Ten_of_Hearts'] = mission:event(134),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Miiri-Wohri'] = mission:event(133),
            ['Rakoh_Buuma'] = mission:event(136),
            ['Sola_Jaab']   = mission:event(134),
            ['Tih_Pikeh']   = mission:event(135),
        },
    },

    -- Head to the Manustery located in Windurst Woods (Home Point #1) to speak with Apururu at (H-9) who will give
    -- you 6 Dark Mana Orbs and tell you to go to the Outer Horutoto Ruins.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Apururu'] = mission:progressEvent(137),

            onEventFinish =
            {
                [137] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, {
                        xi.ki.FIRST_DARK_MANA_ORB,
                        xi.ki.SECOND_DARK_MANA_ORB,
                        xi.ki.THIRD_DARK_MANA_ORB,
                        xi.ki.FOURTH_DARK_MANA_ORB,
                        xi.ki.FIFTH_DARK_MANA_ORB,
                        xi.ki.SIXTH_DARK_MANA_ORB
                    })
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    -- Head to East Sarutabaruta and go to the Marguerite Tower at (J-11); speak with the Tarutaru named Pore-Ohre
    -- and he will give you a Key Item Southeastern Star Charm.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Apururu'] = mission:progressEvent(138),
        },

        [xi.zone.EAST_SARUTABARUTA] =
        {
            ['Pore-Ohre'] = mission:progressEvent(46),

            onEventFinish =
            {
                [46] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SOUTHEASTERN_STAR_CHARM)
                    player:setMissionStatus(mission.areaId, 3)
                end,
            },
        },
    },

    -- Handle both the placing and later collecting of mana orbs here
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and (missionStatus == 3 or missionStatus == 4)
        end,

        [xi.zone.EAST_SARUTABARUTA] =
        {
            ['Pore-Ohre'] = mission:event(47),
        },

        [xi.zone.OUTER_HORUTOTO_RUINS] =
        {
            ['_5ee'] =
            {
                onTrigger = function(player, npc)
                    return gizmoOnTrigger(player, 1, 58, 46)
                end,
            },

            ['_5ef'] =
            {
                onTrigger = function(player, npc)
                    return gizmoOnTrigger(player, 2, 59, 47)
                end,
            },

            ['_5eg'] =
            {
                onTrigger = function(player, npc)
                    return gizmoOnTrigger(player, 3, 60, 48)
                end,
            },

            ['_5eh'] =
            {
                onTrigger = function(player, npc)
                    return gizmoOnTrigger(player, 4, 61, 49)
                end,
            },

            ['_5ei'] =
            {
                onTrigger = function(player, npc)
                    return gizmoOnTrigger(player, 5, 62, 50)
                end,
            },

            ['_5ej'] =
            {
                onTrigger = function(player, npc)
                    return gizmoOnTrigger(player, 6, 63, 51)
                end,
            },

            onEventFinish =
            {
                -- Magical Gizmo #1
                [58] = placeOrb,
                [46] = collectOrb,

                -- Magical Gizmo #2
                [59] = placeOrb,
                [47] = collectOrb,

                -- Magical Gizmo #3
                [60] = placeOrb,
                [48] = collectOrb,

                -- Magical Gizmo #4
                [61] = placeOrb,
                [49] = collectOrb,

                -- Magical Gizmo #5
                [62] = placeOrb,
                [50] = collectOrb,

                -- Magical Gizmo #6
                [63] = placeOrb,
                [51] = collectOrb,
            },
        },
    },

    -- Once all of the orbs have been placed, head to the crack on the east outer wall. Examine the "Gate: Magical Gizmo" door for a cutscene
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 3 and
                mission:getVar(player, 'OrbsPlaced') == 6
        end,

        [xi.zone.OUTER_HORUTOTO_RUINS] =
        {
            ['_5e9'] = mission:event(44),

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.SOUTHEASTERN_STAR_CHARM)
                    player:setMissionStatus(mission.areaId, 4)
                    player:messageSpecial(outerHorutotoRuinsID.text.ALL_G_ORBS_ENERGIZED)
                    mission:setVar(player, 'GizmoUsed', 0)
                    mission:setVar(player, 'OrbsPlaced', 0)
                end,
            },
        },
    },

    -- Return the orbs to Apururu. If you zone out to East Saruta, you get jumped
    -- buy some cardians in a CS and lose the orbs, resulting in a different CS at the
    -- end of the mission. There is no lost KI message. If you homepoint or warp somehow, you keep them.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 5
        end,

        [xi.zone.EAST_SARUTABARUTA] =
        {
            onZoneIn = function(player, prevZone)
                return 48
            end,

            onEventFinish =
            {
                [48] = function(player, csid, option, npc)
                    for i = 1, 6 do
                        player:delKeyItem(glowingOrbKI[i])
                    end

                    player:setMissionStatus(mission.areaId, 6)
                end,
            },
        },

        -- You somehow avoided losing the orbs.
        [xi.zone.WINDURST_WOODS] =
        {
            ['Apururu'] = mission:event(145),

            onEventFinish =
            {
                [145] = function(player, csid, option, npc)
                    for i = 1, 6 do
                        player:delKeyItem(glowingOrbKI[i])
                    end

                    mission:complete(player)
                end,
            },
        },
    },

    -- Only occurs if you lost the mana orbs to the Cardians
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 6
        end,

        [xi.zone.EAST_SARUTABARUTA] =
        {
            ['Pore-Ohre']   = mission:messageText(eastSarutabarutaID.text.PORE_OHRE_STOLEN_ORBS),
            ['Quh_Berhuja'] = mission:messageText(eastSarutabarutaID.text.QUH_BERHUJA_STOLEN_ORBS),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Apururu'] = mission:progressEvent(143),

            onEventFinish =
            {
                [143] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    -- All of the optional post-mission dialogue!
    {
        check = function(player)
            return player:getNation() == mission.areaId and
                player:hasCompletedMission(mission.areaId, mission.missionId) and
                not player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_PRICE_OF_PEACE)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Nine_of_Clubs'] = mission:event(74),
            ['Puo_Rhen']      = mission:event(79),
            ['Ten_of_Clubs']  = mission:event(80),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Keo-Koruo']   = mission:event(105),
            ['Pakke-Pokke'] = mission:event(104),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Dagoza-Beruza'] = mission:event(112),
            ['Panna-Donna']   = mission:event(113),
            ['Ten_of_Hearts'] = mission:event(114),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Apururu']     = mission:event(144):importantOnce(),
            ['Miiri-Wohri'] = mission:event(118),
            ['Sola_Jaab']   = mission:event(117),
            ['Tih_Pikeh']   = mission:event(119),
        },
    },
}

return mission
