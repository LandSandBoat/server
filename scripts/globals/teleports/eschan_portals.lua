-------------------------------------------
-- Escha/Reisenjima Portals Global
-------------------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/teleports")
require("scripts/globals/utils")
require("scripts/globals/zone")
-------------------------------------------
xi = xi or {}
xi.escha = xi.escha or {}
xi.escha.portals = xi.escha.portals or {}

local costReduction = -- Based on Luck+ Vorseal power
{-- Power, reduction (percentage based, will always be (100 minus reduction))
    [ 0] = 100,
    [ 1] =  95,
    [ 2] =  90,
    [ 3] =  85,
    [ 4] =  80,
    [ 5] =  75,
    [ 6] =  70,
    [ 7] =  65,
    [ 8] =  60,
    [ 9] =  55,
    [10] =  50,
    [11] =  45,
}

local portalOffsets =
{
--  [ZoneId] = { First Portal, Last Portal },
    [xi.zone.ESCHA_ZITAH] = {  0,  7 },
    [xi.zone.ESCHA_RUAUN] = {  8, 22 },
    [xi.zone.REISENJIMA ] = { 23, 31 },
}

-------------------------------------------------------------------------------------------------------------
-- Notes:
-- Portal base cost is 50 in every escha zone.
-- Vorseal Luck+ (Portal Cost per unpgrade) -5%, -10%, -15%, -20%, -25%, -30%, -35%, -40%, -45%, -50%, -55%
-- Vorseal status effect = 602
-------------------------------------------------------------------------------------------------------------
local function getPortalCost(player)
    local cost             = 50
    local luckVorsealPower = 0

    -- TODO: get Vorseal Luck+ power amount.
    -- Note: Rounded down. Base 50 with luck+ 3 (-15%) results in 42. (17/march/2023)

    cost = math.floor(cost * costReduction[luckVorsealPower] / 100)

    return cost
end

xi.escha.portals.eschanPortalOnTrigger = function(player, npc, portalGlobalNumber)
    local portalBitMask       = player:getTeleport(xi.teleport.type.ESCHAN_PORTAL) -- Param 2.
    local zoneId              = player:getZoneID()                                 -- Param 3.
    local lockValue           = 0                                                  -- Param 5.
    local zonePortalsUnlocked = 0

    -- Reisenjima only.
    if zoneId == xi.zone.REISENJIMA then
        -- Scintillating Rhapsody. Unlocks Portal #8 and #10.
        if player:hasKeyItem(xi.ki.SCINTILLATING_RHAPSODY) then
            lockValue           = lockValue + 4
            zonePortalsUnlocked = zonePortalsUnlocked + 1
        end

        -- Ethereal droplet. Warps you to Portal #1.
        if player:hasItem(xi.items.ETHEREAL_DROPLET, xi.inv.TEMPITEMS) then
            lockValue = lockValue + 2
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
        portalBitMask = player:getTeleport(xi.teleport.type.ESCHAN_PORTAL)
        lockValue     = lockValue + 1 -- We set it to "Locked" even if we JUST unlocked it.
    end

    -- Get Zone Portals and count how many we have unlocked.
    for v = portalOffsets[zoneId][1], portalOffsets[zoneId][2] do
        if utils.mask.getBit(portalBitMask, v) then
            zonePortalsUnlocked = zonePortalsUnlocked + 1
        end
    end

    -- Check if we have other portals to warp to. Do not display menu if not.
    if zonePortalsUnlocked <= 1 then
        if zoneId == xi.zone.ESCHA_ZITAH then
            portalBitMask = 1
        elseif zoneId == xi.zone.ESCHA_RUAUN then
            portalBitMask = 256 -- 8 "true" bits + 1
        else
            portalBitMask = 8388608 -- 23 "true" bits + 1
        end
    end

    player:startEvent(9100, 0, portalBitMask, zoneId, portalGlobalNumber, lockValue, player:getCurrency("escha_silt"), getPortalCost(player), 0)
end

xi.escha.portals.eschanPortalEventUpdate = function(player, csid, option)
end

xi.escha.portals.eschanPortalEventFinish = function(player, csid, option, npc)
    local portalCost = getPortalCost(player)

    if option == 3 then-- Ethereal droplet usage.
        player:delItem(xi.items.ETHEREAL_DROPLET, 1, xi.inv.TEMPITEMS)
        player:messageSpecial(ID.text.YOU_HAVE_USED, xi.items.ETHEREAL_DROPLET)
    elseif
        option ~= 0 and
        option ~= 4 and -- Scintillating Rhapsody usage.
        option ~= 1073741824
    then
        player:delCurrency("escha_silt", portalCost)
    end
end
