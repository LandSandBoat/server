-------------------------------------------
-- Escha/Reisenjima Portals Global
-------------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/status")
require("scripts/globals/utils")
-------------------------------------------
xi = xi or {}
xi.escha = xi.escha or {}
xi.escha.portals = xi.escha.portals or {}

local costReduction = -- Based on Luck+ Vorseal power
{-- Power, reduction (percentage based, will always be (100 minus reduction))
    [ 0] =  0,
    [ 1] =  5,
    [ 2] = 10,
    [ 3] = 15,
    [ 4] = 20,
    [ 5] = 25,
    [ 6] = 30,
    [ 7] = 35,
    [ 8] = 40,
    [ 9] = 45,
    [10] = 50,
    [11] = 55,
}

local portalOffsets =
{
--  [ZoneId] = { First Portal, Last Portal },
    [xi.zone.ESCHA_ZITAH] = {  0,  7 },
    [xi.zone.ESCHA_RUAUN] = {  8, 22 },
    [xi.zone.REISENJIMA ] = { 23, 30 },
}

-------------------------------------------------------------------------------------------------------------
-- Notes:
-- Portal base cost is 100 in every escha zone.
-- Vorseal Luck+ (Portal Cost per unpgrade) -5%, -10%, -15%, -20%, -25%, -30%, -35%, -40%, -45%, -50%, -55%
-- Vorseal status effect = 602
-------------------------------------------------------------------------------------------------------------
local function getPortalCost(player)
    local cost             = 100
    local luckVorsealPower = 0

    --TODO: get Vorseal Luck+ power amount.

    cost = cost - costReduction[luckVorsealPower]

    return cost
end

xi.escha.portals.eschanPortalOnTrigger = function(player, npc, portalGlobalNumber)
    local portalBitMask = player:getTeleport(xi.teleport.type.ESCHAN_PORTAL) -- Param 2.
    local zoneId        = player:getZoneID()                                 -- Param 3.

    -- Get lock / unlock info.
    local lockValue = 0 -- Assume activated. Param 5. TODO: KI affects it in Reisenjima?

    -- TODO: Having feather KI adds 4 to the value in Reisenjima?
    -- if
    --     zoneId == xi.zone.REISENJIMA and
    --     player:hasKeyItem(feather?)
    -- then
    --     lockValue = 4
    -- end

    -- Player has not activated this Portal.
    if not utils.mask.getBit(portalBitMask, portalGlobalNumber) then
        -- Unlock Portal.
        player:addTeleport(xi.teleport.type.ESCHAN_PORTAL, portalGlobalNumber)

        -- Update Variables.
        portalBitMask = player:getTeleport(xi.teleport.type.ESCHAN_PORTAL)
        lockValue     = lockValue + 1 -- We set it to "Locked" even if we JUST unlocked it.
    end

    -- Get Zone Portals and count how many we have unlocked.
    local zonePortalsUnlocked = 0

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
            portalBitMask = 256
        else
            portalBitMask = 65533 -- TODO: Get correct value for Reisenjima.
        end
    end

    player:startEvent(9100, 0, portalBitMask, zoneId, portalGlobalNumber, lockValue, player:getCurrency("escha_silt"), getPortalCost(player), 0)
end

xi.escha.portals.eschanPortalEventUpdate = function(player, csid, option)
end

xi.escha.portals.eschanPortalEventFinish = function(player, csid, option, npc)
    local portalCost = getPortalCost(player)

    if
        option ~= 0 and
        option ~= 1073741824
    then
        player:delCurrency("escha_silt", portalCost)
    end
end
