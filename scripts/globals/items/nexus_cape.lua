-----------------------------------
-- ID: 11538
-- Item: Nexus Cape
-- Enchantment: "Teleport" (Party Leader)
-----------------------------------
require("scripts/globals/teleports")
require('scripts/globals/zone')
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = xi.msg.basic.ITEM_UNABLE_TO_USE
    local leader = target:getPartyLeader()
    -- In a party and we were able to find the leader
    -- (currently fails in cross map server situations)
    if leader ~= nil and not leader:isInMogHouse() then
        -- Don't try to teleport to self!
        if target:getID() ~= leader:getID() then
            local leaderZone = leader:getZoneID()

            -- Locations with "**" in comment:
            -- ** If the party leader is located in a battlefield or other special location,
            -- players will be forced to travel to a specific location.
            --
            -- Other commented locations:
            -- Players will travel of a specific location, not that of the party leader.
            local validZoneList =
            {
                xi.zone.ULEGUERAND_RANGE,
                xi.zone.ATTOHWA_CHASM,
                xi.zone.WEST_RONFAURE,
                xi.zone.EAST_RONFAURE,
                xi.zone.LA_THEINE_PLATEAU,
                xi.zone.VALKURM_DUNES,
                xi.zone.JUGNER_FOREST,
                xi.zone.BATALLIA_DOWNS,
                xi.zone.NORTH_GUSTABERG,
                xi.zone.SOUTH_GUSTABERG,
                xi.zone.KONSCHTAT_HIGHLANDS,
                xi.zone.PASHHOW_MARSHLANDS,
                xi.zone.ROLANBERRY_FIELDS,
                xi.zone.BEAUCEDINE_GLACIER,
                xi.zone.XARCABARD,
                xi.zone.CAPE_TERIGGAN,
                xi.zone.EASTERN_ALTEPA_DESERT,
                xi.zone.WEST_SARUTABARUTA,
                xi.zone.EAST_SARUTABARUTA,
                xi.zone.TAHRONGI_CANYON,
                xi.zone.BUBURIMU_PENINSULA,
                xi.zone.MERIPHATAUD_MOUNTAINS,
                xi.zone.SAUROMUGUE_CHAMPAIGN,
                xi.zone.YUHTUNGA_JUNGLE,
                xi.zone.YHOATOR_JUNGLE,
                xi.zone.WESTERN_ALTEPA_DESERT,
                xi.zone.QUFIM_ISLAND,
                xi.zone.BEHEMOTHS_DOMINION,
                xi.zone.VALLEY_OF_SORROWS,
                xi.zone.SOUTHERN_SAN_DORIA,
                xi.zone.NORTHERN_SAN_DORIA,
                xi.zone.PORT_SAN_DORIA,
                xi.zone.BASTOK_MINES,
                xi.zone.BASTOK_MARKETS,
                xi.zone.PORT_BASTOK,
                xi.zone.WINDURST_WATERS,
                xi.zone.WINDURST_WALLS,
                xi.zone.PORT_WINDURST,
                xi.zone.WINDURST_WOODS,
                xi.zone.RULUDE_GARDENS,
                xi.zone.UPPER_JEUNO,
                xi.zone.LOWER_JEUNO,
                xi.zone.PORT_JEUNO,
                xi.zone.RABAO,
                xi.zone.SELBINA,
                xi.zone.MHAURA,
                xi.zone.KAZHAM,
                xi.zone.NORG,
                xi.zone.CARPENTERS_LANDING,
                xi.zone.BIBIKI_BAY,
                xi.zone.LUFAISE_MEADOWS,
                xi.zone.MISAREAUX_COAST,
                -- xi.zone.TAVNAZIAN_SAFEHOLD,
                xi.zone.ALTAIEU,
                -- xi.zone.AL_ZAHBI,
                -- xi.zone.AHT_URHGAN_WHITEGATE,
                -- ** xi.zone.WAJAOM_WOODLANDS,
                xi.zone.BHAFLAU_THICKETS,
                -- xi.zone.NASHMAU,
                -- ** xi.zone.MOUNT_ZHAYOLM,
                -- ** xi.zone.CAEDARVA_MIRE,
                -- xi.zone.SOUTHERN_SAN_DORIA_S,
                xi.zone.EAST_RONFAURE_S,
                xi.zone.JUGNER_FOREST_S,
                xi.zone.VUNKERL_INLET_S,
                xi.zone.BATALLIA_DOWNS_S,
                -- xi.zone.BASTOK_MARKETS_S,
                xi.zone.NORTH_GUSTABERG_S,
                xi.zone.GRAUBERG_S,
                xi.zone.PASHHOW_MARSHLANDS_S,
                xi.zone.ROLANBERRY_FIELDS_S,
                -- xi.zone.WINDURST_WATERS_S,
                xi.zone.WEST_SARUTABARUTA_S,
                xi.zone.FORT_KARUGO_NARUGO_S,
                xi.zone.MERIPHATAUD_MOUNTAINS_S,
                xi.zone.SAUROMUGUE_CHAMPAIGN_S,
                xi.zone.THE_SANCTUARY_OF_ZITAH,
                xi.zone.ROMAEVE,
                xi.zone.RUAUN_GARDENS,
                xi.zone.BEAUCEDINE_GLACIER_S,
                xi.zone.XARCABARD_S,
                -- xi.zone.METALWORKS,
                -- xi.zone.HEAVENS_TOWER,
                -- xi.zone.WESTERN_ADOULIN,
                -- xi.zone.EASTERN_ADOULIN,
                -- xi.zone.YAHSE_HUNTING_GROUNDS,
                -- xi.zone.CEIZAK_BATTLEGROUNDS,
                -- xi.zone.FORET_DE_HENNETIEL,
                -- xi.zone.YORCIA_WEALD,
                -- xi.zone.MORIMAR_BASALT_FIELDS,
                -- xi.zone.MARJAMI_RAVINE,
                -- xi.zone.KAMIHR_DRIFTS,
                -- xi.zone.LEAFALLIA,
            }

            -- Make sure we can actually tele to that zone..
            result = xi.msg.basic.ITEM_UNABLE_TO_USE_PARTY_LEADER

            for _, validZone in ipairs(validZoneList) do
                if validZone == leaderZone and target:hasVisitedZone(validZone) then
                    result = 0
                    break
                end
            end
        end
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.LEADER, 0, 1)
end

return itemObject
