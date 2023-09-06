-----------------------------------
-- Mog Tablets
-----------------------------------
xi = xi or {}
xi.mogTablet = xi.mogTablet or {}

-- Announcement zone IDs
-- 0 : A mog tablet has been discovered in [West Ronfaure/East Ronfaure/the La Theine Plateau/the Valkurm Dunes/Jugner Forest/the Batallia Downs/North Gustaberg/South Gustaberg/the Konschtat Highlands/the Pashhow Marshlands/the Rolanberry Fields/Beaucedine Glacier/Xarcabard/West Sarutabaruta/East Sarutabaruta/the Tahrongi Canyon/the Buburimu Peninsula/the Meriphataud Mountains/the Sauromugue Champaign/Qufim Island/Behemoth's Dominion/Cape Teriggan/the Eastern Altepa Desert/the Sanctuary of Zi'Tah/Ro'Maeve/the Yuhtunga Jungle/the Yhoator Jungle/the Western Altepa Desert/the Valley of Sorrows]!
-- 1 : The complete set of mog tablets has been restored to Ru'Lude Gardens! The ancient magic of King Kupofried permeates the air to instill adventurers in this area with its Super Kupowers!
-- 2 : The strength of the ancient moogle magic has weakened, and the tablets have been scattered to the winds once more. You can feel your Super Kupowers begin to fade away...
-- 3 : This area is currently affected by the Super Kupower: Thrifty Transit!
-- 4 : This area is currently affected by the Super Kupower: Martial Master!
-- 5 : This area is currently affected by the Super Kupower: Blood of the Vampyr!
-- 6 : This area is currently affected by the Super Kupower: Treasure Hound!
-- 7 : This area is currently affected by the Super Kupower: Artisan's Advantage!
-- 8 : This area is currently affected by the Super Kupower: Myriad Mystery Boxes!
-- 9 : This area is currently affected by the Super Kupower: Dilatory Digestion!
-- 10 : This area is currently affected by the Super Kupower: Boundary Buster!
-- 11 : This area is currently affected by the Super Kupower: Bountiful Bazaar!
-- 12 : This area is currently affected by the Super Kupower: Swift Shoes!
-- 13 : This area is currently affected by the Super Kupower: Crystal Caboodle!
-- 14 : The ancient magic of King Kupofried fills the air, its glorious Super Kupowers bringing happiness and joy to the realm! Visit the Explorer Moogle in Ru'Lude Gardens to find out more.
-- 15 : This area is currently affected by the Super Kupower: [/Thrifty Transit/Martial Master/Blood of the Vampyr/Treasure Hound/Artisan's Advantage/Myriad Mystery Boxes/Dilatory Digestion/Boundary Buster/Bountiful Bazaar/Swift Shoes/Crystal Caboodle]! This area is currently affected by the Super Kupower: [/Thrifty Transit/Martial Master/Blood of the Vampyr/Treasure Hound/Artisan's Advantage/Myriad Mystery Boxes/Dilatory Digestion/Boundary Buster/Bountiful Bazaar/Swift Shoes/Crystal Caboodle]! This area is currently affected by the Super Kupower: [/Thrifty Transit/Martial Master/Blood of the Vampyr/Treasure Hound/Artisan's Advantage/Myriad Mystery Boxes/Dilatory Digestion/Boundary Buster/Bountiful Bazaar/Swift Shoes/Crystal Caboodle]!

-- Ru'Lude IDs
-- Discovered and handed in:
-- 14331 : The tablet of ≺Multiple Choice (Parameter 0)≻[temperance/fortitude/piety/justice/hope/wisdom/compassion/dignity/loyalty/charity/courage] was discovered there by ≺Player/Chocobo Parameter 0≻, kupo!

-- Discovered and not handed in:
-- 14332 : The tablet of ≺Multiple Choice (Parameter 0)≻[temperance/fortitude/piety/justice/hope/wisdom/compassion/dignity/loyalty/charity/courage] was discovered there, kupo!

-- Not yet discovered
-- 14333 : No tablet has been discovered there yet. It's not too late for you to stake your claim, kupo!

xi.mogTablet.zones =
{
    [0] = xi.zone.WEST_RONFAURE,
    [1] = xi.zone.EAST_RONFAURE,
    [2] = xi.zone.LA_THEINE_PLATEAU,
    [3] = xi.zone.VALKURM_DUNES,
    [4] = xi.zone.JUGNER_FOREST,
    [5] = xi.zone.BATALLIA_DOWNS,
    [6] = xi.zone.NORTH_GUSTABERG,
    [7] = xi.zone.SOUTH_GUSTABERG,
    [8] = xi.zone.KONSCHTAT_HIGHLANDS,
    [9] = xi.zone.PASHHOW_MARSHLANDS,
    [10] = xi.zone.ROLANBERRY_FIELDS,
    [11] = xi.zone.BEAUCEDINE_GLACIER,
    [12] = xi.zone.XARCABARD,
    [13] = xi.zone.WEST_SARUTABARUTA,
    [14] = xi.zone.EAST_SARUTABARUTA,
    [15] = xi.zone.TAHRONGI_CANYON,
    [16] = xi.zone.BUBURIMU_PENINSULA,
    [17] = xi.zone.MERIPHATAUD_MOUNTAINS,
    [18] = xi.zone.SAUROMUGUE_CHAMPAIGN,
    [19] = xi.zone.QUFIM_ISLAND,
    [20] = xi.zone.BEHEMOTHS_DOMINION,
    [21] = xi.zone.CAPE_TERIGGAN,
    [22] = xi.zone.EASTERN_ALTEPA_DESERT,
    [23] = xi.zone.THE_SANCTUARY_OF_ZITAH,
    [24] = xi.zone.ROMAEVE,
    [25] = xi.zone.YUHTUNGA_JUNGLE,
    [26] = xi.zone.YHOATOR_JUNGLE,
    [27] = xi.zone.WESTERN_ALTEPA_DESERT,
    [28] = xi.zone.VALLEY_OF_SORROWS,
}

-- [zoneId] = { { tabletZoneOffset, x, y, z }, { ... }, { ... }, }
xi.mogTablet.locations =
{
    [xi.zone.VALKURM_DUNES] =
    {
        { 3, 288.756, -0.262, 2.605 },
    },
}

-- For use with message 15
xi.mogTablet.powers =
{
    -- lshift 1 by amount
    THRIFTY_TRANSIT      = 1,
    MARTIAL_MASTER       = 2,
    BLOOD_OF_THE_VAMPYR  = 3,
    TREASURE_HOUND       = 4,
    ARTISANS_ADVANTAGE   = 5,
    MYRIAD_MYSTERY_BOXES = 6,
    DILATORY_DIGESTION   = 7,
    BOUNDARY_BUSTER      = 8,
    BOUNTIFUL_BAZAAR     = 9,
    SWIFT_SHOES          = 10,
    CRYSTAL_CABOODLE     = 11,
}

xi.mogTablet.tablets =
{
    TEMPERANCE = 0,
    FORTITUDE  = 1,
    PIETY      = 2,
    JUSTICE    = 3,
    HOPE       = 4,
    WISDOM     = 5,
    COMPASSION = 6,
    DIGNITY    = 7,
    LOYALTY    = 8,
    CHARITY    = 9,
    COURAGE    = 10,
}

xi.mogTablet.onZoneInitialize = function(zone)
    -- Lookup server vars
    -- See if we need to spawn any tablets
end

xi.mogTablet.onZoneIn = function(zone, player)
    -- Lookup server vars
    -- player:messageSpecial(15,
    --     xi.mogTablet.powers.THRIFTY_TRANSIT,
    --     xi.mogTablet.powers.MARTIAL_MASTER,
    --     xi.mogTablet.powers.BLOOD_OF_THE_VAMPYR)
end

xi.mogTablet.onZoneTick = function(zone)
    -- local now = os.clock()
    -- local lastCalled = zone:getLocalVar('MogTabletTick')
    -- Every 10s, rather than every tick
    -- if now > lastCalled + 10 then
    --     local tablets = zone:queryEntitiesByName('Mog-Tablet')
    --     for _, tablet in pairs(tablets) do
    --         for _, player in pairs(zone:getPlayers()) do
    --             -- Check their distance from the tablet(s) in the zone to see if we should reveal it (87')
    --             if tablet:checkDistance(player) <= 87 then
    --                tablet:setStatus(xi.status.NORMAL)
    --             end
    --         end
    --     end
    --     zone:setLocalVar('MogTabletTick', now)
    -- end
end

xi.mogTablet.hideAllTablets = function()
    for _, zoneId in pairs(xi.mogTablet.zones) do
        SendLuaFuncStringToZone(zoneId, string.format([[
            local zoneId = %i
            local zone = GetZone(zoneId)
            local results = zone:queryEntitiesByName('Mog-Tablet')
            for _, entity in pairs(results) do
                entity:setStatus(xi.status.DISAPPEAR)
            end
        ]], zoneId))
    end
end

xi.mogTablet.messageAllPlayers = function()
    for _, zoneId in pairs(xi.mogTablet.zones) do
        SendLuaFuncStringToZone(zoneId, string.format([[
            local zoneId = %i
            local ID = zones[zoneId]
            local zone = GetZone(zoneId)
            for _, player in pairs(zone:getPlayers()) do
                -- TODO: Hook up messages
            end
        ]], zoneId))
    end
end

xi.mogTablet.tabletFoundAnnouncement = function(player)
    local foundInZoneId = player:getZoneID()
    for _, zoneId in pairs(xi.mogTablet.zones) do
        SendLuaFuncStringToZone(zoneId, string.format([[
            local zoneId = %i
            local ID = zones[zoneId]
            local zone = GetZone(zoneId)
            for _, player in pairs(zone:getPlayers()) do
                -- player:messageSpecial(ID.text.MOG_TABLET_BASE, xi.mogTablet.locations[zoneId][1])
            end
        ]], foundInZoneId))
    end
end

xi.mogTablet.tabletOnTrigger = function(player, npc)
    local interactedWith = npc:getLocalVar('interactedWith')
    if interactedWith == 1 then
        local ID = zones[player:getZoneID()]
        player:messageSpecial(ID.text.YOU_RECOVERED_MOG_TABLET)
        player:setCharVar('[MOGTABLET]Found', 1)

        xi.mogTablet.tabletFoundAnnouncement(player)

        -- TODO: Update server var for this tablet so it can be
        -- tracked by the Moogle

        npc:setLocalVar('interactedWith', 1)
        npc:setAnimationSub(5) -- Play 'flying away' animation
        npc:timer(5000, function(npcArg)
            npcArg:setStatus(xi.status.DISAPPEAR)
            npcArg:setAnimationSub(6) -- Reset animation
        end)
    end
end

-- Explorer Moogle in Ru'Lude Gardens
-- Intro cs 10108
-- Thanks to your efforts they have been recovered cs 10109
-- Tablets have been scattered cs 10110
-- You found a tablet cs 10111, 10112
-- No menu options apart from story cs 10114

xi.mogTablet.moogleOnTrigger = function(player, npc)
    -- NOTE: This setting doesn't exist yet, because this feature isn't ready!
    if xi.settings.ENABLE_MOG_TABLETS then
        local allTabletsFound = false
        if allTabletsFound then
            player:startEvent(10109)
        else
            player:startEvent(10111, 1, 1, 1)
        end
    end
end

xi.mogTablet.moogleOnEventUpdate = function(player, csid, option, npc)
    -- print('update', csid, option)
    -- TODO: Check server vars

    local numCollected = 11
    local power1 = xi.mogTablet.powers.MARTIAL_MASTER
    local power2 = xi.mogTablet.powers.TREASURE_HOUND
    local power3 = xi.mogTablet.powers.SWIFT_SHOES

    -- The current Super Kupower
    if option == 1 then

        -- Overwrite with their shifted values
        if power1 then
            power1 = bit.lshift(1, power1 - 1)
        else
            power1 = 0
        end

        if power2 then
            power2 = bit.lshift(1, power2 - 1)
        else
            power2 = 0
        end

        if power3 then
            power3 = bit.lshift(1, power3 - 1)
        else
            power3 = 0
        end

        player:updateEvent(power1 + power2 + power3)

    -- Number collected
    elseif option == 3 then
        player:updateEvent(numCollected)

    -- Display List
    elseif option == 4 then
        local mask = 0xFFFFFFFF
        player:updateEvent(mask)

    -- Located tablets in zone
    elseif option > 4 then
        -- local zoneId = xi.mogTablet.zones[option - 3]

        -- Use zoneId to lookup

        -- Deliver results to player
        -- player:updateEventString('Test')
        -- player:messageSpecial(14331, xi.mogTablet.tablets.CHARITY)
    end
end

xi.mogTablet.moogleOnEventFinish = function(player, csid, option, npc)
    -- print('finish', csid, option)

    -- Hand out prizes
    if csid == 10111 then
        -- option 2: Here's a reward

        -- Obtained: <Kupofried's Ring>
        -- Obtained: <Other item>
    end
end
