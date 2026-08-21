-----------------------------------
-- Campaign Teleport
--
-- Each nation's "Campaign Arbiter" NPC (Wenonah for Windurst, Scarlette for San
-- d'Oria, Narkissa for Bastok) teleports players to WOTG-era contested zones for
-- an Allied Notes fee, gated by which of those zones the player has actually
-- visited before. Each destination zone also has its own set of 4 return-trip
-- arbiters (one per campaign-allegiance state: San d'Oria/Bastok/Windurst/
-- generic-Beastman), gated on holding Bronze Ribbon of Service or higher.
--
-- This is a real, fixed 20-destination network -- only Xarcabard [S] is wired
-- up here as a proof of the pattern, backed by a real capture (credit: Wiggo,
-- https://www.youtube.com/watch?v=png3EUxWE5E). The other 19 destinations use
-- the same shared code below; adding one is just a new destinationsByNation
-- entry plus its own thin NPC script.
-----------------------------------
xi = xi or {}
xi.campaignTeleport = xi.campaignTeleport or {}

-- `baseFee` per the FFXIclopedia Allied Notes page
-- (https://ffxiclopedia.fandom.com/wiki/Allied_Notes): total cost is
-- (baseFee + controlCost) * surcharge, where controlCost is 0/20/40 for
-- own-nation/other-Allied/Beastmen control of the destination, and surcharge
-- is 1.2x for using a different nation's arbiter than your own. Verified
-- against Wiggo's capture: Xarcabard, Beastman-controlled, own nation, no
-- surcharge = 60 + 40 = 100, matching the capture exactly. Only the surcharge
-- is computed here (real-time knowable from player:getNation()) --
-- controlCost needs live area-control state this server doesn't track for
-- these WOTG "_FRONT" regions, so it's left at an implicit 0. That means this
-- server will currently quote 60 for Xarcabard, not the real 100, until that
-- gap is closed -- documented here rather than silently wrong.
--
-- bit/option: found empirically -- with every destination bit set, the
-- resulting menu is a fixed 20-item list; Xarcabard is item/bit 1. Selecting
-- a destination sends its own bit number back as `option`.
xi.campaignTeleport.destinationsByNation =
{
    [xi.nation.WINDURST] =
    {
        -- x/y/z/rot: character Damisha's own position right after zoning in,
        -- from Wiggo's capture. Also confirms the event/option encoding:
        -- the capture shows event 0x01CA (458, matches arbiterOnTrigger
        -- below) and Option: 1 for choosing Xarcabard, matching bit/option 1.
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

-- Builds the availability mask the same way conquest.lua's getExForceAvailable does:
-- one bit per destination, set only if the player has actually been there.
--
-- Bit 0 is always set -- confirmed necessary in-client (a mask of 1, only the
-- destination bit, still showed no options; the real capture's own param was 3,
-- i.e. bit 0 AND bit 1 both set). Most likely a baseline "eligible to talk to
-- this arbiter at all" flag distinct from any specific destination, though its
-- real meaning isn't confirmed -- just that it needs to be on. Destination bits
-- start at 1, not 0.
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

xi.campaignTeleport.computeFee = function(player, nation, dest)
    local surcharge = (nation ~= player:getNation()) and 1.2 or 1.0
    return math.floor(dest.baseFee * surcharge)
end

-- Mid-dialogue fee quote. Confirmed via capture: selecting a destination first
-- produces an Event Update (0x05C) quoting the fee, matching the outpost
-- teleporters' own split between onEventUpdate (quote) and onEventFinish
-- (charge + teleport) -- copied for the same reason, not because Wenonah's own
-- option-value encoding is known to match the outpost system's (it doesn't;
-- hers repeats the same option both times rather than switching ranges).
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

-- The return trip: each destination zone has its own 4 arbiters (one per
-- campaign-allegiance state), keyed by returnDestinationsByNation
-- (player:getCampaignAllegiance() / xi.alliedNation) -- not the player's
-- present-day home nation, and not tied to which outbound arbiter sent them
-- out. `fee`: per the FFXIclopedia Allied Notes page, "the cost to return to
-- your nation of allegiance" is a flat base of 10 Allied Notes plus a control
-- cost, same unresolved-controlCost caveat as above.
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

-- Zone arbiter quartets -- 4 NPCs per destination zone, one per
-- campaign-allegiance state (San d'Oria/Bastok/Windurst/generic-Beastman),
-- same allegiance-keyed returnDestinationsByNation lookup and single-option
-- no-bitmask menu shape as each other. Gated: each NPC has its own default
-- (dismissal) event and its own teleport-menu event, exactly 4 apart --
-- e.g. Xarcabard's Sleiney, C.A. is default 453 / teleport 457. Reaching the
-- teleport menu requires Bronze Ribbon of Service or higher
-- (xi.campaign.getMedalRank, campaign.lua, counts consecutive held ribbon
-- key items starting at BRONZE_RIBBON_OF_SERVICE).
xi.campaignTeleport.zoneArbiterOnTrigger = function(player, defaultEventId, teleportEventId)
    if xi.campaign.getMedalRank(player) >= 1 then
        player:startEvent(teleportEventId, 0, 1, player:getCurrency('allied_notes'), 0, 0, 0, 0)
    else
        player:startEvent(defaultEventId)
    end
end

xi.campaignTeleport.zoneArbiterOnEventUpdate = function(player, csid, option, teleportEventId)
    if csid ~= teleportEventId then
        return
    end

    local dest = xi.campaignTeleport.returnDestinationsByNation[player:getCampaignAllegiance()]
    if dest ~= nil then
        player:updateEvent(0, dest.fee, 0, 0, 0, 0, 0, 0)
    end
end

-- Confirmed in-client 2026-08-21: closing the menu without choosing still
-- fires onEventFinish, skipping onEventUpdate entirely, with a garbage
-- option (1073741824 observed) -- not 0. A real confirm goes through
-- onEventUpdate(option=1) first, then onEventFinish(option=1). So option==1
-- is the real "confirmed" signal, not "any option for this csid".
xi.campaignTeleport.zoneArbiterOnEventFinish = function(player, csid, option, teleportEventId)
    if csid ~= teleportEventId or option ~= 1 then
        return
    end

    local dest = xi.campaignTeleport.returnDestinationsByNation[player:getCampaignAllegiance()]
    if dest ~= nil and player:getCurrency('allied_notes') >= dest.fee then
        player:delCurrency('allied_notes', dest.fee)
        player:setPos(dest.x, dest.y, dest.z, dest.rot, dest.zone)
    end
end
