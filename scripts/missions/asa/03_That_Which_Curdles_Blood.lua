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
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)

mission.reward =
{
    ki          =
    {
        xi.ki.DOMINAS_SCARLET_SEAL,
        xi.ki.DOMINAS_CERULEAN_SEAL,
        xi.ki.DOMINAS_EMERALD_SEAL,
        xi.ki.DOMINAS_AMBER_SEAL,
        xi.ki.DOMINAS_VIOLET_SEAL,
        xi.ki.DOMINAS_AZURE_SEAL
    },
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE },
}

local function handleTradeEvent(player, trade, firstId)
    local asaKit = mission:getVar(player, 'Option')
    if npcUtil.tradeHasExactly(trade, asaKit) then
        return mission:progressEvent(firstId)
    end
end

local handleTradeEventFinish = function(player, csid, option, npc)
    if mission:complete(player) then
        player:confirmTrade()
    end
end

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
                    local potionInfo =
                    {
                        { xi.items.ENFEEBLEMENT_KIT_OF_POISON, xi.items.FLASK_OF_POISON_POTION },
                        { xi.items.ENFEEBLEMENT_KIT_OF_BLINDNES, xi.items.FLASK_OF_BLINDNESS_POTION },
                        { xi.items.ENFEEBLEMENT_KIT_OF_SLEEP, xi.items.FLASK_OF_SLEEPING_POTION },
                        { xi.items.ENFEEBLEMENT_KIT_OF_SILENCE, xi.items.FLASK_OF_SILENCING_POTION }
                    }

                    local kit = mission:getVar(player, 'Option')

                    for _, potionData in ipairs(potionInfo) do
                        if kit == potionData[1] then
                            return mission:progressEvent(858, kit, xi.items.SHEET_OF_BAST_PARCHMENT, 0, xi.items.INFERIOR_COCOON, potionData[2], xi.items.EARTH_CRYSTAL)
                        end
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Faulpie'] =
            {
                onTrigger = function(player, npc)
                    local kit = mission:getVar(player, 'Option')

                    return mission:progressEvent(944, kit, xi.items.SHEET_OF_FINE_PARCHMENT, xi.items.SHEET_OF_PARCHMENT, xi.items.SHEET_OF_PARCHMENT, xi.items.PUMICE_STONE, xi.items.DARK_CRYSTAL)
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Abd-al-Raziq'] =
            {
                onTrigger = function(player, npc)
                    local kit = mission:getVar(player, 'Option')

                    return mission:progressEvent(590, kit, xi.items.JAR_OF_ENCHANTED_INK, xi.items.JAR_OF_BLACK_INK, xi.items.DARK_CRYSTAL, xi.items.VIAL_OF_MAGICKED_BLOOD, xi.items.DARK_CRYSTAL)
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
