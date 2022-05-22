-----------------------------------
-- A Shantotto Ascension
-- A Shantotto Ascension M3
-----------------------------------
-- !addmission 11 2
-- Kuroido-Moido : !pos -113.78 -3.25 105.40 240
-- Faulpie       : !pos -178.88 -1 9.89 230
-- Abd-al-Raziq  : !pos 126.7 2.0 -0.23 234
-- Trodden Snow  : !pos -19.7 -17.3 104.4 126
-----------------------------------
require('scripts/globals/missions')
require('scripts/settings/main')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)

local function handleTradeEvent(player, trade, firstId)
    local asaKit = player:getCharVar("ASA_kit")
    if npcUtil.tradeHasExactly(trade, asaKit) then
        return mission:progressEvent(firstId)
    end
end

local handleTradeEventFinish = function(player, csid, option, npc)
    if mission:complete(player) then
        player:confirmTrade()

        npcUtil.giveKeyItem(player, {
            xi.ki.DOMINAS_SCARLET_SEAL,
            xi.ki.DOMINAS_CERULEAN_SEAL,
            xi.ki.DOMINAS_EMERALD_SEAL,
            xi.ki.DOMINAS_AMBER_SEAL,
            xi.ki.DOMINAS_VIOLET_SEAL,
            xi.ki.DOMINAS_AZURE_SEAL
        })
    end
end

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kuroido-Moido'] =
            {
                onTrigger = function(player, npc)
                    local kit = player:getCharVar("ASA_kit")
                    local potion = 0

                    if kit == xi.items.ENFEEBLEMENT_KIT_OF_POISON        then potion = xi.items.FLASK_OF_POISON_POTION
                    elseif kit == xi.items.ENFEEBLEMENT_KIT_OF_BLINDNESS then potion = xi.items.FLASK_OF_BLINDNESS_POTION
                    elseif kit == xi.items.ENFEEBLEMENT_KIT_OF_SLEEP     then potion = xi.items.FLASK_OF_SLEEPING_POTION
                    elseif kit == xi.items.ENFEEBLEMENT_KIT_OF_SILENCE   then potion = xi.items.FLASK_OF_SILENCING_POTION
                    end

                    return mission:progressEvent(858, kit, 1134, 0, 2778, potion, 4099)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Faulpie'] =
            {
                onTrigger = function(player, npc)
                    local kit = player:getCharVar("ASA_kit")

                    return mission:progressEvent(944, kit, 2773, 917, 917, 2776, 4103)
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Abd-al-Raziq'] =
            {
                onTrigger = function(player, npc)
                    local kit = player:getCharVar("ASA_kit")

                    return mission:progressEvent(590, kit, 2774, 929, 4103, 2777, 4103)
                end,
            },
        },

        [xi.zone.QUFIM_ISLAND] =
        {
            ['Trodden_Snow'] =
            {
                onTrade = function(player, npc, trade)
                    return handleTradeEvent(player, trade, 44)
                end,
            },
            onEventFinish =
            {
                [44] = handleTradeEventFinish,
            },
        },
    },
}

return mission
