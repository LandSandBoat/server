-----------------------------------
-- Ancestry Moogle (Race Change)
--
-- Player must have CharVar '[RaceChange]Eligible' set to a non-zero value to use the service.
-----------------------------------

xi = xi or {}
xi.ancestryMoogle = {}

local settings =
{
    -- Interactions disabled if set to false.
    enabled  = xi.settings.main.RACE_CHANGE_ENABLED or true,

    -- The time in seconds that the player has to wait before they can use the service again.
    -- Default is 14 days (1209600 seconds).
    cooldown = xi.settings.main.RACE_CHANGE_COOLDOWN or 1209600,
}

local csidKey =
{
    NOT_ELIGIBLE = 1,
    RACE_CHANGE  = 2,
}

local csidLookup =
{
    [xi.zone.PORT_BASTOK]    = { 480, 479 },
    [xi.zone.PORT_SAN_DORIA] = { 833, 832 },
    [xi.zone.WINDURST_WALLS] = { 580, 579 },
}

local swappableItems =
{
    [0] = -- Female trading Male gear
    {
        xi.item.DANCERS_TIARA_M,
        xi.item.DANCERS_CASAQUE_M,
        xi.item.DANCERS_BANGLES_M,
        xi.item.DANCERS_TIGHTS_M,
        xi.item.DANCERS_TOE_SHOES_M,

        xi.item.DANCERS_TIARA_M_P1,
        xi.item.DANCERS_CASAQUE_M_P1,
        xi.item.DANCERS_BANGLES_M_P1,
        xi.item.DANCERS_TIGHTS_M_P1,
        xi.item.DANCERS_TOE_SHOES_M_P1,

        xi.item.MAXIXI_TIARA_M,
        xi.item.MAXIXI_CASAQUE_M,
        xi.item.MAXIXI_BANGLES_M,
        xi.item.MAXIXI_TIGHTS_M,
        xi.item.MAXIXI_TOE_SHOES_M,

        xi.item.MAXIXI_TIARA_M_P1,
        xi.item.MAXIXI_CASAQUE_M_P1,
        xi.item.MAXIXI_BANGLES_M_P1,
        xi.item.MAXIXI_TIGHTS_M_P1,
        xi.item.MAXIXI_TOE_SHOES_M_P1,

        xi.item.MAXIXI_TIARA_M_P2,
        xi.item.MAXIXI_CASAQUE_M_P2,
        xi.item.MAXIXI_BANGLES_M_P2,
        xi.item.MAXIXI_TIGHTS_M_P2,
        xi.item.MAXIXI_TOE_SHOES_M_P2,

        xi.item.MAXIXI_TIARA_M_P3,
        xi.item.MAXIXI_CASAQUE_M_P3,
        xi.item.MAXIXI_BANGLES_M_P3,
        xi.item.MAXIXI_TIGHTS_M_P3,
        xi.item.MAXIXI_TOE_SHOES_M_P3,
    },

    [1] = -- Male trading Female gear
    {
        xi.item.DANCERS_TIARA_F,
        xi.item.DANCERS_CASAQUE_F,
        xi.item.DANCERS_BANGLES_F,
        xi.item.DANCERS_TIGHTS_F,
        xi.item.DANCERS_TOE_SHOES_F,

        xi.item.DANCERS_TIARA_F_P1,
        xi.item.DANCERS_CASAQUE_F_P1,
        xi.item.DANCERS_BANGLES_F_P1,
        xi.item.DANCERS_TIGHTS_F_P1,
        xi.item.DANCERS_TOE_SHOES_F_P1,

        xi.item.MAXIXI_TIARA_F,
        xi.item.MAXIXI_CASAQUE_F,
        xi.item.MAXIXI_BANGLES_F,
        xi.item.MAXIXI_TIGHTS_F,
        xi.item.MAXIXI_TOE_SHOES_F,

        xi.item.MAXIXI_TIARA_F_P1,
        xi.item.MAXIXI_CASAQUE_F_P1,
        xi.item.MAXIXI_BANGLES_F_P1,
        xi.item.MAXIXI_TIGHTS_F_P1,
        xi.item.MAXIXI_TOE_SHOES_F_P1,

        xi.item.MAXIXI_TIARA_F_P2,
        xi.item.MAXIXI_CASAQUE_F_P2,
        xi.item.MAXIXI_BANGLES_F_P2,
        xi.item.MAXIXI_TIGHTS_F_P2,
        xi.item.MAXIXI_TOE_SHOES_F_P2,

        xi.item.MAXIXI_TIARA_F_P3,
        xi.item.MAXIXI_CASAQUE_F_P3,
        xi.item.MAXIXI_BANGLES_F_P3,
        xi.item.MAXIXI_TIGHTS_F_P3,
        xi.item.MAXIXI_TOE_SHOES_F_P3,
    },
}

xi.ancestryMoogle.onTrade = function(player, npc, trade)
    if not settings.enabled then
        return
    end

    local confirmedItems = {}

    for slotId = 0, 7 do
        local item = trade:getItem(slotId)
        if item then
            local itemId = item:getID()
            if utils.contains(itemId, swappableItems[player:getGender()]) then
                print('Item eligible for swap: ' .. itemId)
                -- Player submitted an eligible item from the opposite gender.
                table.insert(confirmedItems, itemId)
            end
        end
    end

    for _, v in ipairs(confirmedItems) do
        -- Give new item. Item ID + 1 for MtoF, -1 for FtoM.
        -- getGender returns 0 for F and 1 for M.
        if npcUtil.giveItem(player, player:getGender() == 1 and v - 1 or v + 1) then
            trade:confirmItem(v, 1)
        end
    end

    player:confirmTrade()
    return true
end

xi.ancestryMoogle.onTrigger = function(player, npc)
    if not settings.enabled then
        return
    end

    local zoneID           = player:getZoneID()
    local raceChangeLast   = player:getCharVar('[RaceChange]Last')
    local raceChangeExpiry = player:getCharVar('[RaceChange]Eligible')

    -- If the player is on cooldown, show a message and exit.
    if raceChangeLast + settings.cooldown >= GetSystemTime() then
        player:startEvent(csidLookup[zoneID][csidKey.NOT_ELIGIBLE],
            236,
            0, -- unknown, seen 0
            0, -- unknown, seen 0
            0, -- unknown, seen 0
            0, -- unknown, time remaining for an unknown variant of the event
            5, -- 0 is message when service not purchased, 1+ when on cooldown.
            1, -- 1+ displays "Thank you for using the service!". Capture shows misc values.
            0  -- unknown, seen random values.
        )
        return
    end

    -- Player must have "purchased" the service and have enough time left to use it.
    if
        raceChangeExpiry == 0 or          -- Expired charvar
        raceChangeExpiry - GetSystemTime() <= 0 -- If the charvar is set but expired.
    then
        player:startEvent(csidLookup[zoneID][csidKey.NOT_ELIGIBLE], 236)
        player:setCharVar('[RaceChange]Eligible', 0)
        return
    end

    -- The upcoming event need the Previous_Race NPC set to the player current race/face.
    -- The Previous_Race NPC is 2 IDs higher than the Ancestry Moogle NPC.
    local previousRaceNpc = GetNPCByID(npc:getID() + 2)
    if previousRaceNpc then
        previousRaceNpc:setLook({ race = player:getRace(), face = player:getFace() })
        player:sendEntityUpdateToPlayer(previousRaceNpc, xi.entityUpdate.ENTITY_UPDATE, xi.updateType.UPDATE_ALL_CHAR)
    end

    player:startEvent(csidLookup[zoneID][csidKey.RACE_CHANGE],
        player:getRace(),                -- current race
        bit.rshift(player:getFace(), 1), -- current face, flattened from 0-15 to 0-7
        player:getSize(),                -- current size
        player:getFace() % 2,            -- current hair color (face variant)
        raceChangeExpiry - GetSystemTime(),    -- Time left to use the service, in seconds.
        0,                               -- unknown, seen 0
        0,                               -- unknown, seen random values
        0                                -- unknown, seen random values
    )
end

xi.ancestryMoogle.onEventFinish = function(player, csid, option, npc)
    if not settings.enabled then
        return
    end

    local zoneID = player:getZoneID()
    local raceChangeExpiry = player:getCharVar('[RaceChange]Eligible')

    if
        csid == csidLookup[zoneID][csidKey.RACE_CHANGE] and
        option ~= utils.EVENT_CANCELLED_OPTION
    then
        -- If timer expired between the event start and finish, reset
        if
            raceChangeExpiry == 0 or          -- Expired charvar
            raceChangeExpiry - GetSystemTime() <= 0 -- If the charvar is set but expired.
        then
            player:messageSpecial(zones[zoneID].text.UNABLE_RACE_CHANGE)
            -- Must rezone character to exit the special event.
            player:forceRezone()
            return
        end

        -- Bits 8-11:  Race ID (4 bits, values 1-8)
        -- Bits 12-15: Face/Hair combination (4 bits, values 0-15)
        -- Bits 16-17: Size (2 bits, values 0(small)-2(large))
        local newRace = bit.band(bit.rshift(option, 8), 0xF)
        local newFace = bit.band(bit.rshift(option, 12), 0xF)
        local newSize = bit.band(bit.rshift(option, 16), 0x3)

        -- Sanity checks
        if
            (not newRace or not newFace or not newSize) or
            (newRace < xi.race.HUME_M or newRace > xi.race.GALKA) or
            (newFace > 15) or -- 1A (0) to 8B (15)
            (newSize > 2)     -- 0 (small) to 2 (large)
        then
            printf('bad race change data: player=%s, newRace=%d, newFace=%d, newSize=%d',
                player:getName(), newRace, newFace, newSize)
            player:messageSpecial(zones[zoneID].text.UNABLE_RACE_CHANGE)
            -- Must rezone character to exit the special event.
            player:forceRezone()
            return
        end

        printf('race change: player=%s, race %d -> %d, face %d -> %d, size %d -> %d',
            player:getName(),
            player:getRace(), newRace,
            player:getFace(), newFace,
            player:getSize(), newSize)

        -- Set the timer to 0 so the player can't use the service again
        -- This is done before the actual race change since it will teleport the player
        -- and player may no longer be valid
        player:setCharVar('[RaceChange]Eligible', 0)
        player:setCharVar('[RaceChange]Last', GetSystemTime())

        if not player:raceChange(newRace, newFace, newSize) then
            player:messageSpecial(zones[zoneID].text.UNABLE_RACE_CHANGE)
            -- Must rezone character to exit the special event.
            player:forceRezone()
        end
    end
end
