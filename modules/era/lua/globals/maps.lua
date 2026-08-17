-----------------------------------
-- Map Vendor Era Module
-- Restores the maps each vendor sold before their lists were merged.
-- Also restores the original costs for each map.
-- The November 5, 2013 version update put the Original area maps from quests on sale.
-- The July 8, 2014 version update merged the Original and Zilart area lists across every vendor.
-- The December 10, 2014 version update added the Promathia and Altana maps and the rest of the Aht Urhgan maps.
-- The vendor menu lists every map the player does not own. Anything out of era is reported as owned.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/38100
-- Source: https://wiki.ffo.jp/html/29812.html
-- Source: https://forum.square-enix.com/ffxi/threads/45365-Dec-10-2014-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/23621.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_map_vendors', xi.pre(xi.expansion.SOA))

-- IDs are the ones the client sends with a purchase. Prices are the ones the vendor charged before the July 8, 2014 version update.
local eraMaps =
{
--   ID      Key Item                             Cost
    [ 0] = { xi.ki.MAP_OF_THE_SAN_DORIA_AREA,      200 },
    [ 1] = { xi.ki.MAP_OF_THE_BASTOK_AREA,         200 },
    [ 2] = { xi.ki.MAP_OF_THE_WINDURST_AREA,       200 },
    [ 3] = { xi.ki.MAP_OF_THE_JEUNO_AREA,          600 },
    [ 4] = { xi.ki.MAP_OF_ORDELLES_CAVES,          600 },
    [ 5] = { xi.ki.MAP_OF_GHELSBA,                 600 },
    [ 6] = { xi.ki.MAP_OF_DAVOI,                  3000 },
    [ 7] = { xi.ki.MAP_OF_CARPENTERS_LANDING,     3000 },
    [ 8] = { xi.ki.MAP_OF_THE_ZERUHN_MINES,        200 },
    [ 9] = { xi.ki.MAP_OF_THE_PALBOROUGH_MINES,    600 },
    [10] = { xi.ki.MAP_OF_BEADEAUX,               3000 }, -- The base table has 600.
    [11] = { xi.ki.MAP_OF_GIDDEUS,                 600 },
    [12] = { xi.ki.MAP_OF_CASTLE_OZTROJA,         3000 },
    [13] = { xi.ki.MAP_OF_THE_MAZE_OF_SHAKHRAMI,   600 },
    [14] = { xi.ki.MAP_OF_THE_LITELOR_REGION,     3000 },
    [15] = { xi.ki.MAP_OF_BIBIKI_BAY,             3000 },
    [16] = { xi.ki.MAP_OF_QUFIM_ISLAND,           3000 },
    [17] = { xi.ki.MAP_OF_THE_ELDIEME_NECROPOLIS, 3000 },
    [18] = { xi.ki.MAP_OF_THE_GARLAIGE_CITADEL,   3000 },
    [19] = { xi.ki.MAP_OF_THE_ELSHIMO_REGIONS,    3000 },
    [32] = { xi.ki.MAP_OF_THE_KUZOTZ_REGION,      3000 },
    [37] = { xi.ki.MAP_OF_THE_KORROLOKA_TUNNEL,   3000 },
    [44] = { xi.ki.MAP_OF_THE_VOLLBOW_REGION,     3000 },
    [58] = { xi.ki.MAP_OF_AL_ZAHBI,                600 },
    [59] = { xi.ki.MAP_OF_NASHMAU,                3000 },
    [60] = { xi.ki.MAP_OF_WAJAOM_WOODLANDS,       3000 },
    [68] = { xi.ki.MAP_OF_BHAFLAU_THICKETS,       3000 },
}

local sandoriaStock =
{
    xi.ki.MAP_OF_THE_SAN_DORIA_AREA,
    xi.ki.MAP_OF_THE_BASTOK_AREA,
    xi.ki.MAP_OF_THE_WINDURST_AREA,
    xi.ki.MAP_OF_THE_JEUNO_AREA,
    xi.ki.MAP_OF_ORDELLES_CAVES,
    xi.ki.MAP_OF_GHELSBA,
    xi.ki.MAP_OF_DAVOI,
    xi.ki.MAP_OF_CARPENTERS_LANDING,
}

local bastokStock =
{
    xi.ki.MAP_OF_THE_SAN_DORIA_AREA,
    xi.ki.MAP_OF_THE_BASTOK_AREA,
    xi.ki.MAP_OF_THE_WINDURST_AREA,
    xi.ki.MAP_OF_THE_JEUNO_AREA,
    xi.ki.MAP_OF_THE_ZERUHN_MINES,
    xi.ki.MAP_OF_THE_PALBOROUGH_MINES,
    xi.ki.MAP_OF_BEADEAUX,
}

local windurstStock =
{
    xi.ki.MAP_OF_THE_SAN_DORIA_AREA,
    xi.ki.MAP_OF_THE_BASTOK_AREA,
    xi.ki.MAP_OF_THE_WINDURST_AREA,
    xi.ki.MAP_OF_THE_JEUNO_AREA,
    xi.ki.MAP_OF_GIDDEUS,
    xi.ki.MAP_OF_CASTLE_OZTROJA,
    xi.ki.MAP_OF_THE_MAZE_OF_SHAKHRAMI,
}

local selbinaStock =
{
    xi.ki.MAP_OF_THE_SAN_DORIA_AREA,
    xi.ki.MAP_OF_THE_BASTOK_AREA,
    xi.ki.MAP_OF_THE_WINDURST_AREA,
    xi.ki.MAP_OF_THE_JEUNO_AREA,
}

local mhauraStock =
{
    xi.ki.MAP_OF_THE_SAN_DORIA_AREA,
    xi.ki.MAP_OF_THE_BASTOK_AREA,
    xi.ki.MAP_OF_THE_WINDURST_AREA,
    xi.ki.MAP_OF_THE_JEUNO_AREA,
    xi.ki.MAP_OF_THE_LITELOR_REGION,
    xi.ki.MAP_OF_BIBIKI_BAY,
}

local jeunoStock =
{
    xi.ki.MAP_OF_THE_SAN_DORIA_AREA,
    xi.ki.MAP_OF_THE_BASTOK_AREA,
    xi.ki.MAP_OF_THE_WINDURST_AREA,
    xi.ki.MAP_OF_THE_JEUNO_AREA,
    xi.ki.MAP_OF_QUFIM_ISLAND,
    xi.ki.MAP_OF_THE_ELDIEME_NECROPOLIS,
    xi.ki.MAP_OF_THE_GARLAIGE_CITADEL,
    xi.ki.MAP_OF_THE_ELSHIMO_REGIONS,
}

local rabaoStock =
{
    xi.ki.MAP_OF_THE_KUZOTZ_REGION,
    xi.ki.MAP_OF_THE_KORROLOKA_TUNNEL,
    xi.ki.MAP_OF_THE_VOLLBOW_REGION,
}

local whitegateStock =
{
    xi.ki.MAP_OF_AL_ZAHBI,
    xi.ki.MAP_OF_NASHMAU,
    xi.ki.MAP_OF_WAJAOM_WOODLANDS,
    xi.ki.MAP_OF_BHAFLAU_THICKETS,
}

local mapVendors =
{
    ['Ashu_Bolkhomo']   = { event =  1006, stock = rabaoStock     },
    ['Elesca']          = { event =   567, stock = sandoriaStock  },
    ['Karine']          = { event =   210, stock = bastokStock    },
    ['Lombaria']        = { event =   500, stock = selbinaStock   },
    ['Ludwig']          = { event =   500, stock = mhauraStock    },
    ['Mhoji_Roccoruh']  = { event = 10000, stock = windurstStock  },
    ['Pehki_Machumaht'] = { event = 10000, stock = windurstStock  },
    ['Promurouve']      = { event = 10000, stock = jeunoStock     },
    ['Rex']             = { event =   115, stock = bastokStock    },
    ['Riyadahf']        = { event =   563, stock = whitegateStock },
    ['Rusese']          = { event = 10000, stock = jeunoStock     },
    ['Violitte']        = { event =   595, stock = sandoriaStock  },
}

-- Maps the vendor never carried get the owned bit. The menu leaves those out.
local function stockParams(player, vendor)
    local paramTable = { 0, 0, 0 }

    for mapId = 0, 71 do -- A slot left clear shows as purchasable.
        local map = eraMaps[mapId]

        if
            not map or
            not utils.contains(map[1], vendor.stock) or
            player:hasKeyItem(map[1])
        then
            local paramPos = math.floor(mapId / 32) + 1

            paramTable[paramPos] = bit.bor(paramTable[paramPos], bit.lshift(1, mapId))
        end
    end

    return paramTable
end

m:addOverride('xi.maps.onTrigger', function(player, npc)
    local vendor = mapVendors[npc:getName()]

    -- Any vendor added after this era keeps the base list.
    if not vendor then
        return super(player, npc)
    end

    player:startEvent(vendor.event, unpack(stockParams(player, vendor)))
end)

m:addOverride('xi.maps.onEventUpdate', function(player, csid, option, npc)
    local vendor = mapVendors[npc:getName()]

    if
        not vendor or
        csid ~= vendor.event
    then
        return super(player, csid, option, npc)
    end

    if bit.band(option, 0xF) == 1 then
        local map = eraMaps[bit.rshift(option, 16)]

        -- The menu hides these. Only a crafted option reaches here.
        if
            not map or
            not utils.contains(map[1], vendor.stock)
        then
            player:printToPlayer('You cannot purchase that item on this server.', xi.msg.channel.SYSTEM_3)
        elseif map[2] > player:getGil() then
            player:messageSpecial(zones[player:getZoneID()].text.NOT_HAVE_ENOUGH_GIL)
        else
            player:delGil(map[2])
            npcUtil.giveKeyItem(player, map[1])
        end
    end

    player:updateEvent(unpack(stockParams(player, vendor)))
end)
