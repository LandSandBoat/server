-----------------------------------
-- Functions for Map Vendor NPCs
-----------------------------------
xi = xi or {}
xi.maps = xi.maps or {}

-- TODO: When WotG Map Vendors are implemented, use this table to
-- store additional data regarding map discounts in past areas.
local mapVendors =
{
    ['Ashu_Bolkhomo']   = 1006,
    ['Elesca']          = 567,
    ['Karine']          = 210,
    ['Lombaria']        = 500,
    ['Ludwig']          = 500,
    ['Mhoji_Roccoruh']  = 10000,
    ['Pehki_Machumaht'] = 10000,
    ['Promurouve']      = 10000,
    ['Rex']             = 115,
    ['Riyadahf']        = 563,
    ['Rusese']          = 10000,
    ['Violitte']        = 595,
}

local mapInfo =
{
--   ID      Key Item                                  Cost
    [ 0] = { xi.ki.MAP_OF_THE_SAN_DORIA_AREA,           200 },
    [ 1] = { xi.ki.MAP_OF_THE_BASTOK_AREA,              200 },
    [ 2] = { xi.ki.MAP_OF_THE_WINDURST_AREA,            200 },
    [ 3] = { xi.ki.MAP_OF_THE_JEUNO_AREA,               600 },
    [ 4] = { xi.ki.MAP_OF_ORDELLES_CAVES,               600 },
    [ 5] = { xi.ki.MAP_OF_GHELSBA,                      600 },
    [ 6] = { xi.ki.MAP_OF_DAVOI,                       3000 },
    [ 7] = { xi.ki.MAP_OF_CARPENTERS_LANDING,          3000 },
    [ 8] = { xi.ki.MAP_OF_THE_ZERUHN_MINES,             200 },
    [ 9] = { xi.ki.MAP_OF_THE_PALBOROUGH_MINES,         600 },
    [10] = { xi.ki.MAP_OF_BEADEAUX,                     600 },
    [11] = { xi.ki.MAP_OF_GIDDEUS,                      600 },
    [12] = { xi.ki.MAP_OF_CASTLE_OZTROJA,              3000 },
    [13] = { xi.ki.MAP_OF_THE_MAZE_OF_SHAKHRAMI,        600 },
    [14] = { xi.ki.MAP_OF_THE_LITELOR_REGION,          3000 },
    [15] = { xi.ki.MAP_OF_BIBIKI_BAY,                  3000 },
    [16] = { xi.ki.MAP_OF_QUFIM_ISLAND,                3000 },
    [17] = { xi.ki.MAP_OF_THE_ELDIEME_NECROPOLIS,      3000 },
    [18] = { xi.ki.MAP_OF_THE_GARLAIGE_CITADEL,        3000 },
    [19] = { xi.ki.MAP_OF_THE_ELSHIMO_REGIONS,         3000 },
    [20] = { xi.ki.MAP_OF_THE_NORTHLANDS_AREA,         3000 },
    [21] = { xi.ki.MAP_OF_KING_RANPERRES_TOMB,          600 },
    [22] = { xi.ki.MAP_OF_THE_DANGRUF_WADI,             600 },
    [23] = { xi.ki.MAP_OF_THE_HORUTOTO_RUINS,           600 },
    [24] = { xi.ki.MAP_OF_BOSTAUNIEUX_OUBLIETTE,       3000 },
    [25] = { xi.ki.MAP_OF_THE_TORAIMARAI_CANAL,        3000 },
    [26] = { xi.ki.MAP_OF_THE_GUSGEN_MINES,             600 },
    [27] = { xi.ki.MAP_OF_THE_CRAWLERS_NEST,           3000 },
    [28] = { xi.ki.MAP_OF_THE_RANGUEMONT_PASS,         3000 },
    [29] = { xi.ki.MAP_OF_DELKFUTTS_TOWER,             3000 },
    [30] = { xi.ki.MAP_OF_FEIYIN,                      3000 },
    [31] = { xi.ki.MAP_OF_CASTLE_ZVAHL,                3000 },
    [32] = { xi.ki.MAP_OF_THE_KUZOTZ_REGION,           3000 },
    [33] = { xi.ki.MAP_OF_THE_RUAUN_GARDENS,           3000 },
    [34] = { xi.ki.MAP_OF_NORG,                        3000 },
    [35] = { xi.ki.MAP_OF_TEMPLE_OF_UGGALEPIH,         3000 },
    [36] = { xi.ki.MAP_OF_THE_DEN_OF_RANCOR,           3000 },
    [37] = { xi.ki.MAP_OF_THE_KORROLOKA_TUNNEL,        3000 },
    [38] = { xi.ki.MAP_OF_THE_KUFTAL_TUNNEL,           3000 },
    [39] = { xi.ki.MAP_OF_THE_BOYAHDA_TREE,            3000 },
    [40] = { xi.ki.MAP_OF_VELUGANNON_PALACE,           3000 },
    [41] = { xi.ki.MAP_OF_IFRITS_CAULDRON,             3000 },
    [42] = { xi.ki.MAP_OF_THE_QUICKSAND_CAVES,         3000 },
    [43] = { xi.ki.MAP_OF_SEA_SERPENT_GROTTO,          3000 },
    [44] = { xi.ki.MAP_OF_THE_VOLLBOW_REGION,          3000 },
    [45] = { xi.ki.MAP_OF_LABYRINTH_OF_ONZOZO,         3000 },
    [46] = { xi.ki.MAP_OF_THE_ULEGUERAND_RANGE,        3000 },
    [47] = { xi.ki.MAP_OF_THE_ATTOHWA_CHASM,           3000 },
    [48] = { xi.ki.MAP_OF_PSOXJA,                      3000 },
    [49] = { xi.ki.MAP_OF_OLDTON_MOVALPOLOS,           3000 },
    [50] = { xi.ki.MAP_OF_NEWTON_MOVALPOLOS,           3000 },
    [51] = { xi.ki.MAP_OF_TAVNAZIA,                    3000 },
    [52] = { xi.ki.MAP_OF_THE_AQUEDUCTS,               3000 },
    [53] = { xi.ki.MAP_OF_THE_SACRARIUM,               3000 },
    [54] = { xi.ki.MAP_OF_CAPE_RIVERNE,                3000 },
    [55] = { xi.ki.MAP_OF_ALTAIEU,                     3000 },
    [56] = { xi.ki.MAP_OF_HUXZOI,                      3000 },
    [57] = { xi.ki.MAP_OF_RUHMET,                      3000 },
    [58] = { xi.ki.MAP_OF_AL_ZAHBI,                     600 },
    [59] = { xi.ki.MAP_OF_NASHMAU,                     3000 },
    [60] = { xi.ki.MAP_OF_WAJAOM_WOODLANDS,            3000 },
    [61] = { xi.ki.MAP_OF_CAEDARVA_MIRE,               3000 },
    [62] = { xi.ki.MAP_OF_MOUNT_ZHAYOLM,               3000 },
    [63] = { xi.ki.MAP_OF_AYDEEWA_SUBTERRANE,          3000 },
    [64] = { xi.ki.MAP_OF_MAMOOK,                      3000 },
    [65] = { xi.ki.MAP_OF_HALVUNG,                     3000 },
    [66] = { xi.ki.MAP_OF_ARRAPAGO_REEF,               3000 },
    [67] = { xi.ki.MAP_OF_ALZADAAL_RUINS,              3000 },
    [68] = { xi.ki.MAP_OF_BHAFLAU_THICKETS,            3000 },
    [69] = { xi.ki.MAP_OF_VUNKERL_INLET,              30000 },
    [70] = { xi.ki.MAP_OF_GRAUBERG,                   30000 },
    [71] = { xi.ki.MAP_OF_FORT_KARUGO_NARUGO,         30000 },
}

local function getMapEventParams(player)
    local paramTable = { 0, 0, 0 }

    for mapId = 0, #mapInfo do
        if player:hasKeyItem(mapInfo[mapId][1]) then
            local paramPos = math.floor(mapId / 32) + 1

            paramTable[paramPos] = bit.bor(paramTable[paramPos], bit.lshift(1, mapId))
        end
    end

    return paramTable
end

xi.maps.onTrigger = function(player, npc)
    local eventParams = getMapEventParams(player)

    player:startEvent(mapVendors[npc:getName()], eventParams[1], eventParams[2], eventParams[3])
end

xi.maps.onEventUpdate = function(player, csid, option, npc)
    local mapId = bit.rshift(option, 16)

    if csid ~= mapVendors[npc:getName()] then
        return
    end

    if
        mapId >= 0 and
        mapId <= #mapInfo and
        bit.band(option, 0xF) == 1
    then
        local mapCost = mapInfo[mapId][2]

        if mapCost <= player:getGil() then
            player:delGil(mapCost)
            npcUtil.giveKeyItem(player, mapInfo[mapId][1])
        else
            player:messageSpecial(zones[player:getZoneID()].text.NOT_HAVE_ENOUGH_GIL)
        end
    end

    player:updateEvent(unpack(getMapEventParams(player)))
end
