-----------------------------------
-- ID: 11538
-- Item: Nexus Cape
-- Enchantment: "Teleport" (Party Leader)
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require('scripts/globals/zone')
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = tpz.msg.basic.ITEM_UNABLE_TO_USE -- Default is fail.
    local leader = target:getPartyLeader()
    -- In a party and we were able to find the leader
    -- (currently fails in cross map server situations)
    if leader ~= nil and not leader:isInMogHouse() then
        -- Don't try to teleport to self!
        if (target:getID() ~= leader:getID()) then
            local leaderZone = leader:getZoneID()

            -- Locations with "**" in comment:
            -- ** If the party leader is located in a battlefield or other special location,
            -- players will be forced to travel to a specific location.
            --
            -- Other commented locations:
            -- Players will travel of a specific location, not that of the party leader.
            local validZoneList =
            {
                tpz.zone.ULEGUERAND_RANGE,
                tpz.zone.ATTOHWA_CHASM,
                tpz.zone.WEST_RONFAURE,
                tpz.zone.EAST_RONFAURE,
                tpz.zone.LA_THEINE_PLATEAU,
                tpz.zone.VALKURM_DUNES,
                tpz.zone.JUGNER_FOREST,
                tpz.zone.BATALLIA_DOWNS,
                tpz.zone.NORTH_GUSTABERG,
                tpz.zone.SOUTH_GUSTABERG,
                tpz.zone.KONSCHTAT_HIGHLANDS,
                tpz.zone.PASHHOW_MARSHLANDS,
                tpz.zone.ROLANBERRY_FIELDS,
                tpz.zone.BEAUCEDINE_GLACIER,
                tpz.zone.XARCABARD,
                tpz.zone.CAPE_TERIGGAN,
                tpz.zone.EASTERN_ALTEPA_DESERT,
                tpz.zone.WEST_SARUTABARUTA,
                tpz.zone.EAST_SARUTABARUTA,
                tpz.zone.TAHRONGI_CANYON,
                tpz.zone.BUBURIMU_PENINSULA,
                tpz.zone.MERIPHATAUD_MOUNTAINS,
                tpz.zone.SAUROMUGUE_CHAMPAIGN,
                tpz.zone.YUHTUNGA_JUNGLE,
                tpz.zone.YHOATOR_JUNGLE,
                tpz.zone.WESTERN_ALTEPA_DESERT,
                tpz.zone.QUFIM_ISLAND,
                tpz.zone.BEHEMOTHS_DOMINION,
                tpz.zone.VALLEY_OF_SORROWS,
                tpz.zone.SOUTHERN_SAN_DORIA,
                tpz.zone.NORTHERN_SAN_DORIA,
                tpz.zone.PORT_SAN_DORIA,
                tpz.zone.BASTOK_MINES,
                tpz.zone.BASTOK_MARKETS,
                tpz.zone.PORT_BASTOK,
                tpz.zone.WINDURST_WATERS,
                tpz.zone.WINDURST_WALLS,
                tpz.zone.PORT_WINDURST,
                tpz.zone.WINDURST_WOODS,
                tpz.zone.RULUDE_GARDENS,
                tpz.zone.UPPER_JEUNO,
                tpz.zone.LOWER_JEUNO,
                tpz.zone.PORT_JEUNO,
                tpz.zone.RABAO,
                tpz.zone.SELBINA,
                tpz.zone.MHAURA,
                tpz.zone.KAZHAM,
                tpz.zone.NORG,
                tpz.zone.CARPENTERS_LANDING,
                tpz.zone.BIBIKI_BAY,
                tpz.zone.LUFAISE_MEADOWS,
                tpz.zone.MISAREAUX_COAST,
                -- tpz.zone.TAVNAZIAN_SAFEHOLD,
                tpz.zone.ALTAIEU,
                -- tpz.zone.AL_ZAHBI,
                -- tpz.zone.AHT_URHGAN_WHITEGATE,
                -- ** tpz.zone.WAJAOM_WOODLANDS,
                tpz.zone.BHAFLAU_THICKETS,
                -- tpz.zone.NASHMAU,
                -- ** tpz.zone.MOUNT_ZHAYOLM,
                -- ** tpz.zone.CAEDARVA_MIRE,
                -- tpz.zone.SOUTHERN_SAN_DORIA_S,
                tpz.zone.EAST_RONFAURE_S,
                tpz.zone.JUGNER_FOREST_S,
                tpz.zone.VUNKERL_INLET_S,
                tpz.zone.BATALLIA_DOWNS_S,
                -- tpz.zone.BASTOK_MARKETS_S,
                tpz.zone.NORTH_GUSTABERG_S,
                tpz.zone.GRAUBERG_S,
                tpz.zone.PASHHOW_MARSHLANDS_S,
                tpz.zone.ROLANBERRY_FIELDS_S,
                -- tpz.zone.WINDURST_WATERS_S,
                tpz.zone.WEST_SARUTABARUTA_S,
                tpz.zone.FORT_KARUGO_NARUGO_S,
                tpz.zone.MERIPHATAUD_MOUNTAINS_S,
                tpz.zone.SAUROMUGUE_CHAMPAIGN_S,
                tpz.zone.THE_SANCTUARY_OF_ZITAH,
                tpz.zone.ROMAEVE,
                tpz.zone.RUAUN_GARDENS,
                tpz.zone.BEAUCEDINE_GLACIER_S,
                tpz.zone.XARCABARD_S,
                -- tpz.zone.METALWORKS,
                -- tpz.zone.HEAVENS_TOWER,
                -- tpz.zone.WESTERN_ADOULIN,
                -- tpz.zone.EASTERN_ADOULIN,
                -- tpz.zone.YAHSE_HUNTING_GROUNDS,
                -- tpz.zone.CEIZAK_BATTLEGROUNDS,
                -- tpz.zone.FORET_DE_HENNETIEL,
                -- tpz.zone.YORCIA_WEALD,
                -- tpz.zone.MORIMAR_BASALT_FIELDS,
                -- tpz.zone.MARJAMI_RAVINE,
                -- tpz.zone.KAMIHR_DRIFTS,
                -- tpz.zone.LEAFALLIA,
            }
            -- Make sure we can actually tele to that zone..
            for _, validZone in ipairs(validZoneList) do
                if validZone == leaderZone and target:isZoneVisited(validZone) then
                    result = 0
                end
            end
        end
    end

    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.LEADER, 0, 1)
end

return item_object
