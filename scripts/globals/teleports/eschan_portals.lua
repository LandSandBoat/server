-----------------------------------
-- Escha/Reisenjima Portals Global
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/teleports')
-----------------------------------
xi = xi or {}
xi.escha = xi.escha or {}
xi.escha.portals = xi.escha.portals or {}

local portalOffsets =
{
--  [ZoneId] = { First Portal, Last Portal },
    [xi.zone.ESCHA_ZITAH] = {  0,  7 },
    [xi.zone.ESCHA_RUAUN] = {  8, 22 },
    [xi.zone.REISENJIMA ] = { 23, 31 },
}

local portalData =
{
    [xi.zone.ESCHA_ZITAH] =
    {
        ['Eschan_Portal_#1'] = 0,
        ['Eschan_Portal_#2'] = 1,
        ['Eschan_Portal_#3'] = 2,
        ['Eschan_Portal_#4'] = 3,
        ['Eschan_Portal_#5'] = 4,
        ['Eschan_Portal_#6'] = 5,
        ['Eschan_Portal_#7'] = 6,
        ['Eschan_Portal_#8'] = 7,
    },
    [xi.zone.ESCHA_RUAUN] =
    {
        ['Eschan_Portal_#1' ] =  8,
        ['Eschan_Portal_#2' ] =  9,
        ['Eschan_Portal_#3' ] = 10,
        ['Eschan_Portal_#4' ] = 11,
        ['Eschan_Portal_#5' ] = 12,
        ['Eschan_Portal_#6' ] = 13,
        ['Eschan_Portal_#7' ] = 14,
        ['Eschan_Portal_#8' ] = 15,
        ['Eschan_Portal_#9' ] = 16,
        ['Eschan_Portal_#10'] = 17,
        ['Eschan_Portal_#11'] = 18,
        ['Eschan_Portal_#12'] = 19,
        ['Eschan_Portal_#13'] = 20,
        ['Eschan_Portal_#14'] = 21,
        ['Eschan_Portal_#15'] = 22,
    },
    [xi.zone.REISENJIMA] =
    {
        ['Ethereal_Ingress_#1' ] = 23,
        ['Ethereal_Ingress_#2' ] = 24,
        ['Ethereal_Ingress_#3' ] = 25,
        ['Ethereal_Ingress_#4' ] = 26,
        ['Ethereal_Ingress_#5' ] = 27,
        ['Ethereal_Ingress_#6' ] = 28,
        ['Ethereal_Ingress_#7' ] = 29,
        ['Ethereal_Ingress_#8' ] = 30,
        ['Ethereal_Ingress_#9' ] = 31,
        ['Ethereal_Ingress_#10'] = 32,
    },
}

-----------------------------------
-- Notes:
-- Portal base cost is 50 in every escha zone.
-- Vorseal Luck+ (Portal Cost per unpgrade) -5%, -10%, -15%, -20%, -25%, -30%, -35%, -40%, -45%, -50%, -55%
-- Vorseal status effect = 602
-----------------------------------
local function getPortalCost(player)
    -- TODO: get Vorseal Luck+ power amount.
    -- Note: Rounded down. Base 50 with luck+ 3 (-15%) results in 42. (17/march/2023)

    local cost                  = 50
    local luckVorsealPower      = 0
    local luckVorsealMultiplier = utils.clamp(100 - 5 * luckVorsealPower, 45, 100) / 100
    cost                        = math.floor(cost * luckVorsealMultiplier)

    return cost
end

xi.escha.portals.eschanPortalOnTrigger = function(player, npc)
    local portalBitMask       = player:getTeleport(xi.teleport.type.ESCHAN_PORTAL) -- Param 2.
    local zoneId              = player:getZoneID()                                 -- Param 3.
    local lockValue           = 0                                                  -- Param 5.
    local portalGlobalNumber  = portalData[zoneId][npc:getName()]                  -- Bit number used to track portals unlocked.
    local zonePortalsUnlocked = 0

    -- Get zone portals and count how many we have unlocked.
    for bit = portalOffsets[zoneId][1], portalOffsets[zoneId][2] do
        if utils.mask.getBit(portalBitMask, bit) then
            zonePortalsUnlocked = zonePortalsUnlocked + 1
        end
    end

    -- Reisenjima only.
    if zoneId == xi.zone.REISENJIMA then
        -- Scintillating Rhapsody. Unlocks Portal #8 and #10.
        if player:hasKeyItem(xi.ki.SCINTILLATING_RHAPSODY) then
            lockValue           = lockValue + 4
            zonePortalsUnlocked = zonePortalsUnlocked + 1
        end

        -- Ethereal droplet.
        if player:hasItem(xi.item.ETHEREAL_DROPLET, xi.inv.TEMPITEMS) then
            lockValue = lockValue + 2
        end

    -- Escha Ru'Aun only.
    elseif zoneId == xi.zone.ESCHA_RUAUN then
        -- Eschan droplet.
        if player:hasItem(xi.item.CLUMP_OF_ESCHAN_DROPLETS, xi.inv.TEMPITEMS) then
            lockValue = lockValue + 2

        -- Default message.
        elseif zonePortalsUnlocked == 0 then
            player:messageSpecial(zones[zoneId].text.BLINDING_LIGHT_OBSCURES_YOUR_VISION)

            return
        end
    end

    -- Player has not activated this Portal.
    if
        portalGlobalNumber ~= 32 and -- Reisenjima Portal #10 exception.
        not utils.mask.getBit(portalBitMask, portalGlobalNumber)
    then
        -- Unlock Portal.
        player:addTeleport(xi.teleport.type.ESCHAN_PORTAL, portalGlobalNumber)

        -- Update Variables.
        portalBitMask       = player:getTeleport(xi.teleport.type.ESCHAN_PORTAL)
        zonePortalsUnlocked = zonePortalsUnlocked + 1
        lockValue           = lockValue + 1 -- We set it to "Locked" even if we JUST unlocked it.
    end

    -- Check if we have other portals to warp to. Do not display menu if not.
    if zonePortalsUnlocked <= 1 then
        if zoneId == xi.zone.ESCHA_ZITAH then
            portalBitMask = bit.lshift(1, 0) -- Bit 0 (Base 0) true.
        elseif zoneId == xi.zone.ESCHA_RUAUN then
            portalBitMask = bit.lshift(1, 8) -- Bit 8 (base 0) true.
        else
            portalBitMask = bit.lshift(1, 16) -- Bit 16 (Base 0) true.
        end
    end

    player:startEvent(9100, 0, portalBitMask, zoneId, portalGlobalNumber, lockValue, player:getCurrency('escha_silt'), getPortalCost(player), 0)
end

xi.escha.portals.eschanPortalEventUpdate = function(player, csid, option, npc)
end

xi.escha.portals.eschanPortalEventFinish = function(player, csid, option, npc)
    local portalCost = getPortalCost(player)
    local zoneId     = player:getZoneID()

    -- Reisenjima only: Ethereal Droplet usage.
    if
        zoneId == xi.zone.REISENJIMA and
        option == 3 and
        player:hasItem(xi.item.ETHEREAL_DROPLET, xi.inv.TEMPITEMS)
    then
        player:delItem(xi.item.ETHEREAL_DROPLET, 1, xi.inv.TEMPITEMS)
        player:messageSpecial(zones[zoneId].text.YOU_HAVE_USED, xi.item.ETHEREAL_DROPLET)

    -- Escha Ru'Aun: Eschan Droplet usage.
    elseif
        zoneId == xi.zone.ESCHA_RUAUN and
        (option == 2 or option == 3) and
        player:hasItem(xi.item.CLUMP_OF_ESCHAN_DROPLETS, xi.inv.TEMPITEMS)
    then
        player:delItem(xi.item.CLUMP_OF_ESCHAN_DROPLETS, 1, xi.inv.TEMPITEMS)
        player:messageSpecial(zones[zoneId].text.YOU_HAVE_USED, xi.item.CLUMP_OF_ESCHAN_DROPLETS)

    -- Consume Escha Silt currency.
    elseif
        option ~= 0 and
        option ~= 4 and -- Scintillating Rhapsody usage.
        option ~= utils.EVENT_CANCELLED_OPTION
    then
        -- Standard warp: deduct Escha Silt
        player:delCurrency('escha_silt', portalCost)
    end
end
