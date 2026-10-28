-----------------------------------
-- Fountain Of Trouble
-- A Shantotto Ascension M9
-----------------------------------
-- !addmission 11 8
-- qm1 (Fire)      : !pos -20.344 20.499 -19.461 169
-- qm2 (Water)     : !pos -179.871 20.499 98.223 169
-- qm3 (Wind)      : !pos 160.512 8.432 -120.236 169
-- qm4 (Earth)     : !pos 20.060 16.999 60.461 169
-- qm5 (Lightning) : !pos -184.436 15.999 139.719 169
-- qm6 (Ice)       : !pos 219.927 16.999 -60.704 169
-- qm7 (Light)     : !pos 80.171 20.433 -39.799 169
-- qm8 (Dark)      : !pos -300.800 24.999 59.860 169
-- Moon Spiral     : !pos -303.257 9.5 -260.069 170
-----------------------------------
local toraimaraiID = zones[xi.zone.TORAIMARAI_CANAL]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.FOUNTAIN_OF_TROUBLE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.BATTARU_ROYALE },
}

-- A looted ??? has nothing more to give.
local function collectSap(player, keyItem)
    if player:hasKeyItem(keyItem) then
        return mission:messageText(toraimaraiID.text.NOTHING_OUT_OF_ORDINARY):replaceDefault()
    end

    return mission:keyItem(keyItem)
end

mission.sections =
{
    -- The saps stay collectable after the mission so Battaru Royale can be repeated.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId
        end,

        [xi.zone.TORAIMARAI_CANAL] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    return collectSap(player, xi.keyItem.FIRE_SAP_CRYSTAL)
                end,
            },

            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    return collectSap(player, xi.keyItem.WATER_SAP_CRYSTAL)
                end,
            },

            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    return collectSap(player, xi.keyItem.WIND_SAP_CRYSTAL)
                end,
            },

            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    return collectSap(player, xi.keyItem.EARTH_SAP_CRYSTAL)
                end,
            },

            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    return collectSap(player, xi.keyItem.LIGHTNING_SAP_CRYSTAL)
                end,
            },

            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    return collectSap(player, xi.keyItem.ICE_SAP_CRYSTAL)
                end,
            },

            ['qm7'] =
            {
                onTrigger = function(player, npc)
                    return collectSap(player, xi.keyItem.LIGHT_SAP_CRYSTAL)
                end,
            },

            ['qm8'] =
            {
                onTrigger = function(player, npc)
                    return collectSap(player, xi.keyItem.DARK_SAP_CRYSTAL)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.FULL_MOON_FOUNTAIN] =
        {
            ['MS_Entrance'] =
            {
                onTrigger = function(player, npc)
                    if xi.asa.helpers.countKeyItems(player, xi.asa.helpers.sapCrystals) > 0 then
                        return mission:progressEvent(63, xi.zone.FULL_MOON_FOUNTAIN)
                    end
                end,
            },

            onEventFinish =
            {
                [63] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
