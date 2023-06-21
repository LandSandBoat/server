-----------------------------------
-- A Moogle Kupo d'Etat Helpers
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------

xi = xi or {}
xi.amk = xi.amk or {}
xi.amk.helpers = xi.amk.helpers or {}

xi.amk.helpers.helmTrade = function(player, helmType, broke)
    local amkChance = 5
    local regionId = player:getCurrentRegion()

    if
        player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE and
        broke ~= 1
    then
        if
            helmType == xi.helm.type.MINING and
            not player:hasKeyItem(xi.ki.STURDY_METAL_STRIP) and
            xi.expansionRegion.ORIGINAL_ROTZ[regionId] and
            math.random(1, 100) <= amkChance
        then
            npcUtil.giveKeyItem(player, xi.ki.STURDY_METAL_STRIP)
        elseif
            helmType == xi.helm.type.LOGGING and
            not player:hasKeyItem(xi.ki.PIECE_OF_RUGGED_TREE_BARK) and
            xi.expansionRegion.ORIGINAL_ROTZ[regionId] and
            math.random(1, 100) <= amkChance
        then
            npcUtil.giveKeyItem(player, xi.ki.PIECE_OF_RUGGED_TREE_BARK)
        elseif
            helmType == xi.helm.type.HARVESTING and
            not player:hasKeyItem(xi.ki.SAVORY_LAMB_ROAST) and
            xi.expansionRegion.ORIGINAL_ROTZ[regionId] and
            math.random(1, 100) <= amkChance
        then
            npcUtil.giveKeyItem(player, xi.ki.SAVORY_LAMB_ROAST)
        end
    end
end

local digZoneIds =
{
    xi.zone.VALKURM_DUNES,
    xi.zone.JUGNER_FOREST,
    xi.zone.KONSCHTAT_HIGHLANDS,
    xi.zone.PASHHOW_MARSHLANDS,
    xi.zone.TAHRONGI_CANYON,
    xi.zone.BUBURIMU_PENINSULA,
    xi.zone.MERIPHATAUD_MOUNTAINS,
    xi.zone.THE_SANCTUARY_OF_ZITAH,
    xi.zone.YUHTUNGA_JUNGLE,
    xi.zone.YHOATOR_JUNGLE,
    xi.zone.WESTERN_ALTEPA_DESERT,
    xi.zone.EASTERN_ALTEPA_DESERT,
}

-- AMK07 - Select/lookup the digging zone
xi.amk.helpers.getDiggingZone = function(player)
    local diggingZone = player:getCharVar('AMK6_DIGGING_ZONE')
    if diggingZone == 0 then
        -- 1 = Valkurm Dunes
        -- 2 = Jugner Forest
        -- 3 = Konschtat Highlands
        -- 4 = Pashhow Marshlands
        -- 5 = Tahrongi Canyon
        -- 6 = Buburimu Peninsula
        -- 7 = Meriphataud Mountains
        -- 8 = The Sanctuary of Zi'tah
        -- 9 = Yuhtunga Jungle
        -- 10 = Yhoator Jungle
        -- 11 = Western Altepa Desert
        -- 12 = Eastern Altepa Desert
        diggingZone = math.random(1, 12)
        player:setCharVar('AMK6_DIGGING_ZONE', diggingZone)
    end

    return diggingZone
end

xi.amk.helpers.digSites =
{
    -- NOTE: These have been picked at random, and not checked against
    --       possible points that might exist in retail

    -- 1 = Valkurm Dunes
    [1] =
    {
        { x = 141, z =  28 },
        { x = 392, z = -91 },
    },
    -- 2 = Jugner Forest
    [2] =
    {
        { x = 247, z = -130 },
    },
    -- 3 = Konschtat Highlands
    [3] =
    {
        { x = 366, z = 468 },
    },
    -- 4 = Pashhow Marshlands
    [4] =
    {
        { x = 542, z = 498 },
    },
    -- 5 = Tahrongi Canyon
    [5] =
    {
        { x = 91, z = -106 },
    },
    -- 6 = Buburimu Peninsula
    [6] =
    {
        { x = -111, z = -235 },
    },
    -- 7 = Meriphataud Mountains
    [7] =
    {
        { x = 698, z = -33 },
    },
    -- 8 = The Sanctuary of Zi'tah
    [8] =
    {
        { x = 421, z = -303 },
    },
    -- 9 = Yuhtunga Jungle
    [9] =
    {
        { x = -162, z = 250 },
    },
    -- 10 = Yhoator Jungle
    [10] =
    {
        { x = 198, z = -487 },
    },
    -- 11 = Western Altepa Desert
    [11] =
    {
        { x = -37, z = 398 },
    },
    -- 12 = Eastern Altepa Desert
    [12] =
    {
        { x = 14, z = 187 },
    },
}

xi.amk.helpers.tryRandomlyPlaceDiggingLocation = function(player)
    local diggingZoneOffset = xi.amk.helpers.getDiggingZone(player)
    local diggingSiteTable  = xi.amk.helpers.digSites[diggingZoneOffset]

    player:setLocalVar('AMK_DIG_SITE_INDEX', math.random(1, #diggingSiteTable))
end

xi.amk.helpers.chocoboDig = function(player, zoneID, text)
    local diggingZoneOffset = xi.amk.helpers.getDiggingZone(player)

    if
        player:hasKeyItem(xi.ki.MOLDY_WORM_EATEN_CHEST) or
        player:getZoneID() ~= digZoneIds[diggingZoneOffset]
    then
        return false
    end

    local playerPos = player:getPos()

    -- Get target position from the digSites table using AMK_DIG_SITE_INDEX
    local diggingSiteTable  = xi.amk.helpers.digSites[diggingZoneOffset]
    local digSiteIndex      = player:getLocalVar('AMK_DIG_SITE_INDEX')

    local targetPos = diggingSiteTable[digSiteIndex]
    local targetX   = targetPos.x
    local targetZ   = targetPos.z

    local distance = player:checkDistance(targetX, playerPos.y, targetZ)

    -- Success!
    if distance < 2.5 then
        npcUtil.giveKeyItem(player, xi.ki.MOLDY_WORM_EATEN_CHEST)
        return true
    end

    -- Angle between points
    -- NOTE: This is mapped to 0-255
    local angle = player:getWorldAngle(targetX, playerPos.y, targetZ)

    -- Map angle from 0-255 to 0-7 for the messageSpecial arg, with a small offset for cardinal direction
    local offset = 255 / 8
    local direction = math.floor(((7 - 0) / (255 - 0)) * ((angle + offset) - 0))

    -- Your Chocobo is pulling at the bit
    -- You Sense that it is leading you to the [compass direction]
    player:messageSpecial(text.AMK_DIGGING_OFFSET + 6, direction)

    -- No additional hint (Approx: 201'+ from target)
    if distance > 200 then
    -- You have a hunch this area would be favored by moogles... (Approx. 81-200' from target or two map grids)
    elseif distance > 80 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 5, direction)
    -- You have a vague feeling that a moogle would enjoy traversing this terrain... (Approx. 51-80' from target)
    elseif distance > 50 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 4, direction)
    -- You suspect that the scenery around here would be to a moogle's liking... (Approx. 21-50' from target)
    elseif distance > 20 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 3, direction)
    -- You have a feeling your moogle friend has been through this way... (Approx. 11-20' from target)
    elseif distance > 10 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 2, direction)
    -- You get the distinct sense that your moogle friend frequents this spot... (Approx. 5-10' from target)
    elseif distance > 5 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 1, direction)
    -- You are convinced that your moogle friend has been digging in the immediate vicinity. (Less than 5' from target)
    elseif distance > 2.5 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 0, direction)
    end

    return false
end
