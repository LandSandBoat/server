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

local zoneMaskID =
{
    [xi.zone.ESCHA_ZITAH] = 0,
    [xi.zone.ESCHA_RUAUN] = 1,
    [xi.zone.REISENJIMA ] = 2,
}

local portalData =
{
    [xi.zone.ESCHA_ZITAH] =
    {--  NPC Name              Bit
        ['Eschan_Portal_#1' ] = 0,
        ['Eschan_Portal_#2' ] = 1,
        ['Eschan_Portal_#3' ] = 2,
        ['Eschan_Portal_#4' ] = 3,
        ['Eschan_Portal_#5' ] = 4,
        ['Eschan_Portal_#6' ] = 5,
        ['Eschan_Portal_#7' ] = 6,
        ['Eschan_Portal_#8' ] = 7,
    },

    [xi.zone.ESCHA_RUAUN] =
    {--  NPC Name              Bit
        ['Eschan_Portal_#1' ] = 0,
        ['Eschan_Portal_#2' ] = 1,
        ['Eschan_Portal_#3' ] = 2,
        ['Eschan_Portal_#4' ] = 3,
        ['Eschan_Portal_#5' ] = 4,
        ['Eschan_Portal_#6' ] = 5,
        ['Eschan_Portal_#7' ] = 6,
        ['Eschan_Portal_#8' ] = 7,
    },

    [xi.zone.REISENJIMA] =
    {--  NPC Name              Bit
        ['Eschan_Portal_#1' ] = 0,
        ['Eschan_Portal_#2' ] = 1,
        ['Eschan_Portal_#3' ] = 2,
        ['Eschan_Portal_#4' ] = 3,
        ['Eschan_Portal_#5' ] = 4,
        ['Eschan_Portal_#6' ] = 5,
        ['Eschan_Portal_#7' ] = 6,
        ['Eschan_Portal_#8' ] = 7,
        ['Eschan_Portal_#9' ] = 8,
        ['Eschan_Portal_#10'] = 9,
    },
}

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

xi.escha.portals.eschanPortalOnTrigger = function(player, npc)
    local zoneID          = player:getZoneID()
    local maskOffset      = zoneMaskID[zoneID]
    local activatedMask   = player:getTeleport(xi.teleport.type.ESCHAN_PORTAL, maskOffset)
    local portalNumber    = portalData[zoneID][npc:getName()]
    local portalsUnlocked = utils.mask.countBits(activatedMask)
    local unlockBit       = 1 -- Assume not activated.

    -- Player has already activated this Portal.
    if utils.mask.getBit(activatedMask, portalNumber) then
        unlockBit = 0

    -- Player has not activated this Portal, so unlock it and update variables.
    else
        player:addTeleport(xi.teleport.type.ESCHAN_PORTAL, portalNumber, maskOffset)
        portalsUnlocked = portalsUnlocked + 1
        activatedMask   = player:getTeleport(xi.teleport.type.ESCHAN_PORTAL, maskOffset)
    end

    -- Check if we have other portals to warp to. Do not display menu if not.
    if portalsUnlocked <= 1 then
        activatedMask = 1
    end

    player:startEvent(9100, 0, activatedMask, zoneID, portalNumber, unlockBit, player:getCurrency("escha_silt"), getPortalCost(player), 0)
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
