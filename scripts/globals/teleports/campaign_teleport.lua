-----------------------------------
-- Campaign Teleport
--
-- Each nation's Campaign Arbiter (Wenonah for Windurst, Scarlette for San
-- d'Oria, Narkissa for Bastok) teleports players to WOTG "[S]" zones for
-- Allied Notes, gated by visited zones. Each destination zone also has 4
-- return-trip arbiters, one per campaign allegiance, gated on Bronze Ribbon
-- of Service or higher.
--
-- Fixed 20-destination network; only Xarcabard [S] is wired up here as a
-- proof of the pattern (capture: Wiggo, https://www.youtube.com/watch?v=png3EUxWE5E).
-- The other 19 destinations use the same shared code; adding one is a new
-- destinationsByNation entry plus its own thin NPC script.
-----------------------------------
xi = xi or {}
xi.campaignTeleport = xi.campaignTeleport or {}

-- baseFee per https://ffxiclopedia.fandom.com/wiki/Allied_Notes:
-- total = (baseFee + controlCost) * surcharge. controlCost (0/20/40 by area
-- control) isn't tracked for these WOTG "_FRONT" zones, so it's left at 0;
-- only the surcharge (1.2x for a foreign arbiter) is computed, in computeFee
-- below. Confirmed against Wiggo's capture: Xarcabard, Beastman-controlled,
-- own nation = 60 + 40 = 100 (this server currently quotes 60 until
-- controlCost is tracked).
--
-- bit/option: destination's position in Wenonah's fixed 20-item menu, also
-- the value returned in `option` when selected. Xarcabard is item/bit 1.
xi.campaignTeleport.destinationsByNation =
{
    [xi.nation.WINDURST] =
    {
        -- x/y/z/rot: character Damisha's own position right after zoning in,
        -- from Wiggo's capture, which also confirms event 458 / option 1.
        { zone = xi.zone.XARCABARD_S, baseFee = 60, option = 1, bit = 1, x = 205.973, y = -23.589, z = -206.606, rot = 167 },
    },

    [xi.nation.SANDORIA] =
    {
        { zone = xi.zone.XARCABARD_S, baseFee = 60, option = 1, bit = 1, x = 205.973, y = -23.589, z = -206.606, rot = 167 },
    },

    [xi.nation.BASTOK] =
    {
        { zone = xi.zone.XARCABARD_S, baseFee = 60, option = 1, bit = 1, x = 205.973, y = -23.589, z = -206.606, rot = 167 },
    },
}

-- Return trip: keyed by player:getCampaignAllegiance() (WOTG-era campaign
-- allegiance), not present-day home nation. fee is the flat 10 Allied Notes
-- return-trip base per the Allied Notes wiki page.
xi.campaignTeleport.returnDestinationsByNation =
{
    [xi.alliedNation.SANDORIA] =
    {
        zone = xi.zone.SOUTHERN_SAN_DORIA_S, fee = 10,
        x = -98.000, y = 1.000, z = -41.000, rot = 224,
    },

    [xi.alliedNation.BASTOK] =
    {
        zone = xi.zone.BASTOK_MARKETS_S, fee = 10,
        x = -292.921, y = -10.000, z = -105.802, rot = 0,
    },

    [xi.alliedNation.WINDURST] =
    {
        zone = xi.zone.WINDURST_WATERS_S, fee = 10,
        x = -31.442, y = -5.000, z = 129.202, rot = 128,
    },
}

-- One bit per visited destination, plus bit 0 always set (required for the
-- menu to show anything -- confirmed in-client, matches the real capture's
-- own mask of 3).
xi.campaignTeleport.getAvailableMask = function(player, nation)
    local mask = 1
    local destinations = xi.campaignTeleport.destinationsByNation[nation]

    if destinations == nil then
        return mask
    end

    for _, dest in ipairs(destinations) do
        if player:hasVisitedZone(dest.zone) then
            mask = bit.bor(mask, bit.lshift(1, dest.bit))
        end
    end

    return mask
end

local function findDestination(nation, option)
    local destinations = xi.campaignTeleport.destinationsByNation[nation]
    if destinations == nil then
        return nil
    end

    for _, dest in ipairs(destinations) do
        if dest.option == option then
            return dest
        end
    end

    return nil
end

xi.campaignTeleport.arbiterOnTrigger = function(player, nation)
    local mask = xi.campaignTeleport.getAvailableMask(player, nation)
    player:startEvent(458, mask, 1, player:getCurrency('allied_notes'), 0, 0, 0, 0)
end

-- Only the surcharge is computed (1.2x for a different nation's arbiter than
-- your own); controlCost is left at 0, see destinationsByNation's comment.
xi.campaignTeleport.computeFee = function(player, nation, dest)
    local surcharge = (nation ~= player:getNation()) and 1.2 or 1.0
    return math.floor(dest.baseFee * surcharge)
end

xi.campaignTeleport.arbiterOnEventUpdate = function(player, csid, option, nation)
    if csid ~= 458 then
        return
    end

    local dest = findDestination(nation, option)
    if dest ~= nil then
        player:updateEvent(0, xi.campaignTeleport.computeFee(player, nation, dest), 0, 0, 0, 0, 0, 0)
    end
end

xi.campaignTeleport.arbiterOnEventFinish = function(player, csid, option, nation)
    if csid ~= 458 then
        return
    end

    local dest = findDestination(nation, option)
    if dest ~= nil then
        local fee = xi.campaignTeleport.computeFee(player, nation, dest)
        if player:getCurrency('allied_notes') >= fee then
            player:delCurrency('allied_notes', fee)
            player:setPos(dest.x, dest.y, dest.z, dest.rot, dest.zone)
        end
    end
end

-- Zone arbiter quartets: 4 NPCs per destination zone (San d'Oria/Bastok/
-- Windurst/generic-Beastman), each with its own dismissal event (450-453)
-- and teleport-menu event (454-457), gated on Bronze Ribbon of Service or
-- higher (xi.campaign.getMedalRank >= 1). Keyed by npc:getName(), same shape
-- as eschan_portals.lua's portalData.
xi.campaignTeleport.zoneArbiterEvents =
{
    ['Estaud_RK']         = { default = 450, teleport = 454 },
    ['Timid_Scorpion_LC'] = { default = 451, teleport = 455 },
    ['Yimi_Jomkeh_MC']    = { default = 452, teleport = 456 },
    ['Sleiney_CA']        = { default = 453, teleport = 457 },
}

xi.campaignTeleport.zoneArbiterOnTrigger = function(player, npc)
    local events = xi.campaignTeleport.zoneArbiterEvents[npc:getName()]
    if events == nil then
        return
    end

    if xi.campaign.getMedalRank(player) >= 1 then
        player:startEvent(events.teleport, 0, 1, player:getCurrency('allied_notes'), 0, 0, 0, 0)
    else
        player:startEvent(events.default)
    end
end

xi.campaignTeleport.zoneArbiterOnEventUpdate = function(player, csid, option, npc)
    local events = xi.campaignTeleport.zoneArbiterEvents[npc:getName()]
    if events == nil or csid ~= events.teleport then
        return
    end

    local dest = xi.campaignTeleport.returnDestinationsByNation[player:getCampaignAllegiance()]
    if dest ~= nil then
        player:updateEvent(0, dest.fee, 0, 0, 0, 0, 0, 0)
    end
end

-- option == 1 is the only real confirm (single-destination menu, no bitmask).
-- Escaping sends utils.EVENT_CANCELLED_OPTION, picking "No" sends 0 -- an
-- allowlist on 1 rejects both plus anything else, rather than chasing each
-- decline value individually.
xi.campaignTeleport.zoneArbiterOnEventFinish = function(player, csid, option, npc)
    local events = xi.campaignTeleport.zoneArbiterEvents[npc:getName()]
    if events == nil or csid ~= events.teleport or option ~= 1 then
        return
    end

    local dest = xi.campaignTeleport.returnDestinationsByNation[player:getCampaignAllegiance()]
    if dest ~= nil and player:getCurrency('allied_notes') >= dest.fee then
        player:delCurrency('allied_notes', dest.fee)
        player:setPos(dest.x, dest.y, dest.z, dest.rot, dest.zone)
    end
end
