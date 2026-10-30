-----------------------------------
-- Sugar-Coated Directive
-- A Shantotto Ascension M4
-----------------------------------
-- !addmission 11 3
-- Trodden Snow          : !pos -19.7 -17.3 104.4 126
-- DOMINAS_SCARLET_SEAL  : !addkeyitem 1191
-- DOMINAS_CERULEAN_SEAL : !addkeyitem 1192
-- DOMINAS_EMERALD_SEAL  : !addkeyitem 1193
-- DOMINAS_AMBER_SEAL    : !addkeyitem 1194
-- DOMINAS_VIOLET_SEAL   : !addkeyitem 1195
-- DOMINAS_AZURE_SEAL    : !addkeyitem 1196
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------
local qufimID = zones[xi.zone.QUFIM_ISLAND]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_I },
}

local seals =
{
    xi.keyItem.DOMINAS_SCARLET_SEAL,
    xi.keyItem.DOMINAS_CERULEAN_SEAL,
    xi.keyItem.DOMINAS_EMERALD_SEAL,
    xi.keyItem.DOMINAS_AMBER_SEAL,
    xi.keyItem.DOMINAS_VIOLET_SEAL,
    xi.keyItem.DOMINAS_AZURE_SEAL,
}

local counterseals =
{
    xi.keyItem.SCARLET_COUNTERSEAL,
    xi.keyItem.CERULEAN_COUNTERSEAL,
    xi.keyItem.EMERALD_COUNTERSEAL,
    xi.keyItem.AMBER_COUNTERSEAL,
    xi.keyItem.VIOLET_COUNTERSEAL,
    xi.keyItem.AZURE_COUNTERSEAL,
}

-- Observed on retail: 50000 gil for six seals. The rest follows the wiki.
local gilRewards =
{
    [3] = 3000,
    [4] = 10000,
    [5] = 30000,
    [6] = 50000,
}

-- Observed on retail: the first touch after zoning in refuses the seal, the next opens the fight.
local function protocrystalTrigger(player, npc)
    local cloister = xi.asa.helpers.sugarCoated[player:getZoneID()]
    if not player:hasKeyItem(cloister.seal) then
        return
    end

    if player:getCharVar(cloister.winVar) == 1 then
        return mission:progressEvent(2)
    end

    if player:getLocalVar(xi.asa.helpers.sugarCoatedStymiedVar) == 0 then
        return mission:progressEvent(3, player:getZoneID())
    end
end

-- Observed on retail: after a win the seal becomes the counterseal, even after zoning.
local function attachSeal(player, csid, option, npc)
    local cloister = xi.asa.helpers.sugarCoated[player:getZoneID()]

    player:setCharVar(cloister.winVar, 0)
    player:delKeyItem(cloister.seal)
    player:messageSpecial(zones[player:getZoneID()].text.ATTACH_SEAL, cloister.seal)
    npcUtil.giveKeyItem(player, cloister.counterseal)
end

local function refuseSeal(player, csid, option, npc)
    player:setLocalVar(xi.asa.helpers.sugarCoatedStymiedVar, 1)
    player:messageSpecial(zones[player:getZoneID()].text.POWER_STYMIES, xi.asa.helpers.sugarCoated[player:getZoneID()].seal)
end

mission.sections =
{
    -- The cloisters stay open after the mission for the Bird key repeat.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId
        end,

        [xi.zone.CLOISTER_OF_FLAMES] =
        {
            ['FP_Entrance'] = { onTrigger = protocrystalTrigger },

            onEventFinish =
            {
                [2] = attachSeal,
                [3] = refuseSeal,
            },
        },

        [xi.zone.CLOISTER_OF_FROST] =
        {
            ['IP_Entrance'] = { onTrigger = protocrystalTrigger },

            onEventFinish =
            {
                [2] = attachSeal,
                [3] = refuseSeal,
            },
        },

        [xi.zone.CLOISTER_OF_GALES] =
        {
            ['WP_Entrance'] = { onTrigger = protocrystalTrigger },

            onEventFinish =
            {
                [2] = attachSeal,
                [3] = refuseSeal,
            },
        },

        [xi.zone.CLOISTER_OF_STORMS] =
        {
            ['LP_Entrance'] = { onTrigger = protocrystalTrigger },

            onEventFinish =
            {
                [2] = attachSeal,
                [3] = refuseSeal,
            },
        },

        [xi.zone.CLOISTER_OF_TIDES] =
        {
            ['WP_Entrance'] = { onTrigger = protocrystalTrigger },

            onEventFinish =
            {
                [2] = attachSeal,
                [3] = refuseSeal,
            },
        },

        [xi.zone.CLOISTER_OF_TREMORS] =
        {
            ['EP_Entrance'] = { onTrigger = protocrystalTrigger },

            onEventFinish =
            {
                [2] = attachSeal,
                [3] = refuseSeal,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.QUFIM_ISLAND] =
        {
            ['Trodden_Snow'] =
            {
                onTrigger = function(player, npc)
                    if xi.asa.helpers.countKeyItems(player, counterseals) >= 3 then
                        return mission:progressEvent(45)
                    end

                    return mission:messageText(qufimID.text.ASA_SNOW)
                end,
            },

            onEventFinish =
            {
                [45] = function(player, csid, option, npc)
                    local completedSeals = xi.asa.helpers.countKeyItems(player, counterseals)
                    if mission:complete(player) then
                        if gilRewards[completedSeals] then
                            npcUtil.giveCurrency(player, 'gil', gilRewards[completedSeals])
                        end

                        xi.asa.helpers.delKeyItems(player, counterseals)
                        xi.asa.helpers.delKeyItems(player, seals)
                    end
                end,
            },
        },
    },
}

return mission
