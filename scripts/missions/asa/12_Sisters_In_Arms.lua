-----------------------------------
-- Sisters In Arms
-- A Shantotto Ascension M12
-----------------------------------
-- !addmission 11 11
-- Aldo          : !pos 19.7 3.9 -59 245
-- Mahogany Door : !pos 300 -1.85 355 163
-- qm_shining1 (Greed)  : !pos -143.485 -0.75 -103.572 159
-- qm_shining2 (Envy)   : !pos -180.135 -0.107 -34.973 159
-- qm_shining3 (Malice) : !pos 54.415 1.482 -82.916 159
-- qm_shining4 (Deceit) : !pos 64.920 -0.250 -20.862 159
-- qm_shining5 (Pride)  : !pos -30.667 -0.246 -130.950 159
-- qm_shining6 (Bale)   : !pos -60.852 -0.750 -14.651 159
-- qm_shiny_1  (Despair) : !pos 130.766 16 -320.017 160
-- qm_shiny_2  (Regret)  : !pos -71.103 15.822 7.508 160
-- qm_shiny_3  (Rage)    : !pos 178.235 17.308 -239.845 160
-- qm_shiny_4  (Agony)   : !pos -41.245 17.293 -180.431 160
-- qm_shiny_5  (Dolor)   : !pos 117.840 16.000 -159.482 160
-- qm_shiny_6  (Rancor)  : !pos -26.461 14.199 -223.929 160
-- qm_shiny_7  (Strife)  : !pos 37.884 15.999 -40.323 160
-- qm_shiny_8  (Penury)  : !pos -21.177 36.999 -360.999 160
-- qm_shiny_9  (Blight)  : !pos 41.580 36.978 -141.203 160
-- qm_shiny_10 (Death)   : !pos 210.994 35.957 -280.340 160
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.SISTERS_IN_ARMS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.PROJECT_SHANTOTTOFICATION },
}

-- A looted ??? has nothing more to give.
local function collectTablet(player, keyItem)
    if player:hasKeyItem(keyItem) then
        return mission:messageText(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY):replaceDefault()
    end

    return mission:keyItem(keyItem)
end

mission.sections =
{
    -- The tablets stay collectable after the mission so Project: Shantottofication can be repeated.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId
        end,

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['qm_shining1'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_GREED)
                end,
            },

            ['qm_shining2'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_ENVY)
                end,
            },

            ['qm_shining3'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_MALICE)
                end,
            },

            ['qm_shining4'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_DECEIT)
                end,
            },

            ['qm_shining5'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_PRIDE)
                end,
            },

            ['qm_shining6'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_BALE)
                end,
            },
        },

        [xi.zone.DEN_OF_RANCOR] =
        {
            ['qm_shiny_1'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_DESPAIR)
                end,
            },

            ['qm_shiny_2'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_REGRET)
                end,
            },

            ['qm_shiny_3'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_RAGE)
                end,
            },

            ['qm_shiny_4'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_AGONY)
                end,
            },

            ['qm_shiny_5'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_DOLOR)
                end,
            },

            ['qm_shiny_6'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_RANCOR)
                end,
            },

            ['qm_shiny_7'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_STRIFE)
                end,
            },

            ['qm_shiny_8'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_PENURY)
                end,
            },

            ['qm_shiny_9'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_BLIGHT)
                end,
            },

            ['qm_shiny_10'] =
            {
                onTrigger = function(player, npc)
                    return collectTablet(player, xi.keyItem.TABLET_OF_HEXES_DEATH)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] = mission:event(10103):importantOnce(),
        },

        [xi.zone.SACRIFICIAL_CHAMBER] =
        {
            ['_4j0'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Capture needed, retail was only seen with all sixteen tablets.
                    if xi.asa.helpers.countKeyItems(player, xi.asa.helpers.tabletsOfHexes) > 0 then
                        return mission:progressEvent(4, xi.zone.SACRIFICIAL_CHAMBER)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
