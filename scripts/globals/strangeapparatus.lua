-----------------------------------
--     Strange Apparatus
-- https://www.bg-wiki.com/bg/Strange_Apparatus
-- TODO: adjust drops rates per zone
-- TODO: add Rune Kris, Rune Algol, Rune Scythe
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}

-----------------------------------
-- Strange Apparatus data
-- [zone] =
-- {
--     suffix  = player variable suffix,
--     uid     = unique identifier from the 0x60 packet
--     chip    = correct colored chip to trade to avoid spawning elemental
--     cluster = elemental cluster that can possibly be rewarded
--     drop    = { itemid, cumulative drop rate, drop quantity, itemid, cumulative drop rate, drop quantity, ... } in ascending order by drop rate
-- }
-----------------------------------

-- TODO: Use xi.items enum
local strAppData =
{
    [xi.zone.DANGRUF_WADI] =
    {
        suffix  = 'DW',
        uid     = 0,
        chip    = xi.item.RED_CHIP,
        cluster = xi.item.FIRE_CLUSTER,
        drop    =
        {
            17093, 0.0400, 1, -- rune_staff
            17461, 0.0800, 1, -- rune_rod
            18084, 0.1200, 1, -- rune_halberd
            17158, 0.1600, 1, -- rune_bow
            16563, 0.2000, 1, -- rune_blade
            12742, 0.2400, 1, -- rune_bangles
            16647, 0.2800, 1, -- rune_axe
            18206, 0.3200, 1, -- rune_chopper
            16408, 0.3600, 1, -- rune_baghnakhs
            221,   0.4000, 1, -- arcane_flowerpot
            17333, 0.5200, 6, -- rune_arrow
            1229,  0.7000, 2, -- adaman_nugget
            931,   1.0000, 8, -- cermet_chunk
        },
    },
    [xi.zone.ORDELLES_CAVES] =
    {
        suffix  = 'OC',
        uid     = 3,
        chip    = xi.item.GREEN_CHIP,
        cluster = xi.item.WIND_CLUSTER,
        drop    =
        {
            17093, 0.0400, 1, -- rune_staff
            17461, 0.0800, 1, -- rune_rod
            18084, 0.1200, 1, -- rune_halberd
            17158, 0.1600, 1, -- rune_bow
            16563, 0.2000, 1, -- rune_blade
            12742, 0.2400, 1, -- rune_bangles
            16647, 0.2800, 1, -- rune_axe
            18206, 0.3200, 1, -- rune_chopper
            16408, 0.3600, 1, -- rune_baghnakhs
            221,   0.4000, 1, -- arcane_flowerpot
            17333, 0.5200, 6, -- rune_arrow
            1229,  0.7000, 2, -- adaman_nugget
            931,   1.0000, 8, -- cermet_chunk
        },
    },
    [xi.zone.OUTER_HORUTOTO_RUINS] =
    {
        suffix  = 'HR',
        uid     = 5,
        chip    = xi.item.PURPLE_CHIP,
        cluster = xi.item.LIGHTNING_CLUSTER,
        drop    =
        {
            17093, 0.0400, 1, -- rune_staff
            17461, 0.0800, 1, -- rune_rod
            18084, 0.1200, 1, -- rune_halberd
            17158, 0.1600, 1, -- rune_bow
            16563, 0.2000, 1, -- rune_blade
            12742, 0.2400, 1, -- rune_bangles
            16647, 0.2800, 1, -- rune_axe
            18206, 0.3200, 1, -- rune_chopper
            16408, 0.3600, 1, -- rune_baghnakhs
            221,   0.4000, 1, -- arcane_flowerpot
            17333, 0.5200, 6, -- rune_arrow
            1229,  0.7000, 2, -- adaman_nugget
            931,   1.0000, 8, -- cermet_chunk
        },
    },
    [xi.zone.THE_ELDIEME_NECROPOLIS] =
    {
        suffix  = 'EN',
        uid     = 4,
        chip    = xi.item.CLEAR_CHIP,
        cluster = xi.item.ICE_CLUSTER,
        drop    =
        {
            17093, 0.0400, 1, -- rune_staff
            17461, 0.0800, 1, -- rune_rod
            18084, 0.1200, 1, -- rune_halberd
            17158, 0.1600, 1, -- rune_bow
            16563, 0.2000, 1, -- rune_blade
            12742, 0.2400, 1, -- rune_bangles
            16647, 0.2800, 1, -- rune_axe
            18206, 0.3200, 1, -- rune_chopper
            16408, 0.3600, 1, -- rune_baghnakhs
            221,   0.4000, 1, -- arcane_flowerpot
            17333, 0.5200, 6, -- rune_arrow
            1229,  0.7000, 2, -- adaman_nugget
            931,   1.0000, 8, -- cermet_chunk
        },
    },
    [xi.zone.GUSGEN_MINES] =
    {
        suffix  = 'GM',
        uid     = 1,
        chip    = xi.item.YELLOW_CHIP,
        cluster = xi.item.EARTH_CLUSTER,
        drop    =
        {
            17093, 0.0400, 1, -- rune_staff
            17461, 0.0800, 1, -- rune_rod
            18084, 0.1200, 1, -- rune_halberd
            17158, 0.1600, 1, -- rune_bow
            16563, 0.2000, 1, -- rune_blade
            12742, 0.2400, 1, -- rune_bangles
            16647, 0.2800, 1, -- rune_axe
            18206, 0.3200, 1, -- rune_chopper
            16408, 0.3600, 1, -- rune_baghnakhs
            221,   0.4000, 1, -- arcane_flowerpot
            17333, 0.5200, 6, -- rune_arrow
            1229,  0.7000, 2, -- adaman_nugget
            931,   1.0000, 8, -- cermet_chunk
        },
    },
    [xi.zone.CRAWLERS_NEST] =
    {
        suffix  = 'CN',
        uid     = 2,
        chip    = xi.item.BLUE_CHIP,
        cluster = xi.item.WATER_CLUSTER,
        drop    =
        {
            17093, 0.0400, 1, -- rune_staff
            17461, 0.0800, 1, -- rune_rod
            18084, 0.1200, 1, -- rune_halberd
            17158, 0.1600, 1, -- rune_bow
            16563, 0.2000, 1, -- rune_blade
            12742, 0.2400, 1, -- rune_bangles
            16647, 0.2800, 1, -- rune_axe
            18206, 0.3200, 1, -- rune_chopper
            16408, 0.3600, 1, -- rune_baghnakhs
            221,   0.4000, 1, -- arcane_flowerpot
            17333, 0.5200, 6, -- rune_arrow
            1229,  0.7000, 2, -- adaman_nugget
            931,   1.0000, 8, -- cermet_chunk
        },
    },
    [xi.zone.MAZE_OF_SHAKHRAMI] =
    {
        suffix  = 'MS',
        uid     = 7,
        chip    = xi.item.BLACK_CHIP,
        cluster = xi.item.DARK_CLUSTER,
        drop    =
        {
            17093, 0.0400, 1, -- rune_staff
            17461, 0.0800, 1, -- rune_rod
            18084, 0.1200, 1, -- rune_halberd
            17158, 0.1600, 1, -- rune_bow
            16563, 0.2000, 1, -- rune_blade
            12742, 0.2400, 1, -- rune_bangles
            16647, 0.2800, 1, -- rune_axe
            18206, 0.3200, 1, -- rune_chopper
            16408, 0.3600, 1, -- rune_baghnakhs
            221,   0.4000, 1, -- arcane_flowerpot
            17333, 0.5200, 6, -- rune_arrow
            1229,  0.7000, 2, -- adaman_nugget
            931,   1.0000, 8, -- cermet_chunk
        },
    },
    [xi.zone.GARLAIGE_CITADEL] =
    {
        suffix  = 'GC',
        uid     = 6,
        chip    = xi.item.WHITE_CHIP,
        cluster = xi.item.LIGHT_CLUSTER,
        drop    =
        {
            17093, 0.0400, 1, -- rune_staff
            17461, 0.0800, 1, -- rune_rod
            18084, 0.1200, 1, -- rune_halberd
            17158, 0.1600, 1, -- rune_bow
            16563, 0.2000, 1, -- rune_blade
            12742, 0.2400, 1, -- rune_bangles
            16647, 0.2800, 1, -- rune_axe
            18206, 0.3200, 1, -- rune_chopper
            16408, 0.3600, 1, -- rune_baghnakhs
            221,   0.4000, 1, -- arcane_flowerpot
            17333, 0.5200, 6, -- rune_arrow
            1229,  0.7000, 2, -- adaman_nugget
            931,   1.0000, 8, -- cermet_chunk
        },
    },
}

-----------------------------------
-- Doctor status functions
-----------------------------------

local function addDoctorStatus(player)
    local data = strAppData[player:getZoneID()]
    player:setCharVar('StrangeApparatusDoctorStatus' .. data.suffix, os.time() + 172800) -- 2 days
end

local function delDoctorStatus(player)
    local data = strAppData[player:getZoneID()]
    player:setCharVar('StrangeApparatusDoctorStatus' .. data.suffix, 0)
end

local function hasDoctorStatus(player)
    local data = strAppData[player:getZoneID()]
    local docStatusExpires = player:getCharVar('StrangeApparatusDoctorStatus' .. data.suffix)

    if docStatusExpires ~= 0 then
        if os.time() <= docStatusExpires then
            return true
        else
            player:setCharVar('StrangeApparatusDoctorStatus' .. data.suffix, 0)
        end
    end

    return false
end

-----------------------------------
-- Password functions
-----------------------------------

local function ltrVal(letter)
    for x = 1, 26 do
        if letter == string.sub('abcdefghijklmnopqrstuvwxyz', x, x) then
            return x - 1
        end
    end
end

local function generatePassword(player)
    local data = strAppData[player:getZoneID()]
    local name = string.lower(player:getName())
    return string.format(
        '%02d%02d%02d%02d',
        ltrVal(string.sub(name, 1, 1)) + data.uid,
        ltrVal(string.sub(name, 2, 2)) + data.uid,
        ltrVal(string.sub(name, 3, 3)) + data.uid,
        string.sub(ltrVal(string.sub(name, 1, 1)) + ltrVal(string.sub(name, 2, 2)) + ltrVal(string.sub(name, 3, 3)) + data.uid * 4, -2, -1)
    )
end

-----------------------------------
-- strangeApparatus object
-----------------------------------

xi.strangeApparatus =
{
    onTrade = function(player, trade, eventId)
        local zone = player:getZoneID()
        local ID = zones[zone]
        local data = strAppData[zone]
        local drops = data.drop
        local foundChip = false

        for chipTraded = xi.item.RED_CHIP, xi.item.BLACK_CHIP do
            if npcUtil.tradeHasExactly(trade, { xi.item.INFINITY_CORE, chipTraded }) then
                player:confirmTrade()
                foundChip = true

                -- player traded a chip that matches this zone
                if chipTraded == data.chip then

                    -- determine drop
                    local rate = math.random()
                    local item = nil
                    local qty  = nil

                    for drop = 1, #drops, 3 do
                        if rate <= drops[drop + 1] then
                            item = drops[drop]
                            qty  = drops[drop + 2]
                            break
                        end
                    end

                    if not hasDoctorStatus(player) and math.random() < 0.5 then
                        item = data.cluster -- give clusters instead of reward
                        qty  = 2
                    end

                    player:setLocalVar('strAppDrop', item)
                    player:setLocalVar('strAppDropQty', qty)

                    -- start event
                    local doctorStatus = hasDoctorStatus(player) and 1 or 0
                    player:startEvent(eventId, item, qty, xi.item.INFINITY_CORE, 0, 0, 0, doctorStatus, 0)

                -- player traded a chip that does not match this zone. spawn elemental that matches apparatus.
                else
                    player:addItem(xi.item.INFINITY_CORE, 1)
                    player:messageSpecial(ID.text.SYS_OVERLOAD)
                    player:messageSpecial(ID.text.YOU_LOST_THE, chipTraded)
                    delDoctorStatus(player)
                    SpawnMob(ID.mob.APPARATUS_ELEMENTAL):updateEnmity(player)
                end

                break
            end
        end

        -- player traded something other than a chip. message and delete doctor status.
        if not foundChip then
            delDoctorStatus(player)
            player:messageSpecial(ID.text.DEVICE_NOT_WORKING)
        end
    end,

    -----------------------------------

    onTrigger = function(player, eventId)
        local doctorStatus = 0
        if hasDoctorStatus(player) then
            doctorStatus = 1
        else
            player:setLocalVar('strAppPass', 1)
        end

        player:startEvent(eventId, doctorStatus, 0, xi.item.INFINITY_CORE, 0, 0, 0, 0, player:getZoneID())
    end,

    -----------------------------------

    onEventUpdate = function(player, option)
        if not hasDoctorStatus(player) then
            local doctorStatus = 1
            if option == generatePassword(player) then -- good password
                doctorStatus = 0
                addDoctorStatus(player)
            end

            player:updateEvent(doctorStatus, 0, xi.item.INFINITY_CORE, 0, 0, 0, 0, 0)
        end
    end,

    -----------------------------------

    onEventFinish = function(player)
        local item = player:getLocalVar('strAppDrop')
        local qty = player:getLocalVar('strAppDropQty')

        if item ~= 0 then
            if qty == 0 then
                qty = 1
            end

            if npcUtil.giveItem(player, { { item, qty } }) then
                player:setLocalVar('strAppDrop', 0)
                player:setLocalVar('strAppDropQty', 0)
            end
        end
    end,
}
