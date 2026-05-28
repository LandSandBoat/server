-----------------------------------
-- Expeditionary Force - Sign-up & overseer integration
-----------------------------------
require('scripts/globals/expeditionary_force_data')
require('scripts/globals/expeditionary_force_battle')
require('scripts/globals/npc_util')
require('scripts/globals/teleports')
-----------------------------------
xi = xi or {}
xi.expeditionaryForce = xi.expeditionaryForce or {}

-- Required fields for a region.
local requiredRegionFields = { 'eventOption', 'menuBit', 'zoneId', 'insignia', 'minLevel', 'levelCap' }

-- A region is active if global-enabled, region-enabled, and all required data exists.
xi.expeditionaryForce.isRegionActive = function(regionId)
    if not xi.expeditionaryForce.enabled then
        return false
    end

    local region = xi.expeditionaryForce.regions[regionId]
    if region == nil or not region.enabled then
        return false
    end

    for _, field in ipairs(requiredRegionFields) do
        if region[field] == nil then
            printf('[ExpeditionaryForce] Region %d enabled but missing field "%s".', regionId, field)
            return false
        end
    end

    if region.bannerSpawns == nil or #region.bannerSpawns == 0 then
        printf('[ExpeditionaryForce] Region %d enabled but bannerSpawns is empty.', regionId)
        return false
    end

    return true
end

-- Check if the player can sign up for the region.
xi.expeditionaryForce.isRegionAvailableToPlayer = function(player, regionId)
    if not xi.expeditionaryForce.isRegionActive(regionId) then
        return false
    end

    local region  = xi.expeditionaryForce.regions[regionId]
    local pNation = player:getNation()

    -- Region must not be owned by the player's nation or a Conquest ally.
    local owner = GetRegionOwner(regionId)
    if owner == pNation or xi.conquest.areAllies(pNation, owner) then
        return false
    end

    if not player:hasVisitedZone(region.zoneId) then
        return false
    end

    return true
end

-- Bitmask of every region this player can sign up for. 0 = the EF menu does not appear.
-- Resolve gate glyph in commit.
-- Oddly enough, even if you have the key item for a region, you can sign up again.
xi.expeditionaryForce.getMenuBitmask = function(player, guardNation)
    if
        not xi.expeditionaryForce.enabled or
        player:getNation() ~= guardNation
    then
        return 0
    end

    local mask = 0
    for regionId, region in pairs(xi.expeditionaryForce.regions) do
        if
            region.enabled and
            xi.expeditionaryForce.isRegionAvailableToPlayer(player, regionId)
        then
            mask = bit.bor(mask, region.menuBit)
        end
    end

    return mask
end

-- TODO: Pending reward for overseer. This is all just a guess.... please do not read this...
xi.expeditionaryForce.getRewardArg = function(player, guardNation)
    if
        not xi.expeditionaryForce.enabled or
        player:getNation() ~= guardNation
    then
        return 0
    end

    local badge = player:getStatusEffect(xi.effect.EF_BADGE)
    if badge == nil then
        return 0
    end

    local region = xi.expeditionaryForce.regions[badge:getPower()]
    if region == nil or region.eventOption == nil then
        return 0
    end

    -- regionRow 6-20 = eventOption (0x20006-0x20014) minus the 0x20000 base.
    local regionRow = region.eventOption - 0x20000

    -- Numeric add
    return 0x80000000 + bit.lshift(regionRow, 5)
end

-- Map an overseer menu option back to its region id.
local function regionFromEventOption(option)
    for regionId, region in pairs(xi.expeditionaryForce.regions) do
        if region.eventOption == option then
            return regionId
        end
    end

    -- Catch if no mapping exists. This should never occur if data is correct.
    return nil
end

-- Minimum qualifying party members needed in zone.
xi.expeditionaryForce.getRequiredPartySize = function(player)
    local place = GetNationRank(player:getNation())                  -- 0 = no standing, else 1/2/3
    return xi.expeditionaryForce.config.partySizeByPlace[place] or 4 -- Default to 4
end

local function grantGateGlyph(player)
    local npc = player:getEventTarget()
    if npc == nil then
        return
    end

    local glyphId = xi.expeditionaryForce.gateGlyphs[npc:getName()]
    if glyphId == nil then
        return
    end

    for _, ownGlyph in ipairs(xi.expeditionaryForce.gateGlyphsByNation[player:getNation()] or {}) do
        if player:hasItem(ownGlyph) then
            return
        end
    end

    npcUtil.giveItem(player, glyphId)
end

-- Teleport the player to the EF target zone. It's just like outpost warp.
local function teleportToRegion(player, regionId)
    player:addStatusEffect(xi.effect.TELEPORT, {
        power    = xi.teleport.id.OUTPOST,
        duration = 1,
        origin   = player,
        icon     = 0,
        subPower = regionId,
    })
end

-- Trade EF badge for insignia and gate glyph, and warp.
local handleCommit = function(player)
    local badge = player:getStatusEffect(xi.effect.EF_BADGE)
    if badge == nil then
        return
    end

    local regionId = badge:getPower()
    local region   = xi.expeditionaryForce.regions[regionId]
    if region == nil then
        return
    end

    -- Replace badge with glyph
    -- TODO: Verify this is giving the Temporary Key Item in game
    player:delStatusEffect(xi.effect.EF_BADGE)
    npcUtil.giveKeyItem(player, region.insignia) -- Already has a check to not double give the item
    grantGateGlyph(player)

    -- Bestow Signet
    local pNation  = player:getNation()
    local duration = (player:getRank(pNation) + GetNationRank(pNation) + 3) * 3600
    local mOffset  = zones[player:getZoneID()].text.CONQUEST
    player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
    player:addStatusEffect(xi.effect.SIGNET, { duration = duration, origin = player })
    player:messageSpecial(mOffset + 1) -- 'You've received your nation's Signet!'
    -- TODO: Need to say "You are now taking part in your nation's conquest campaign!"

    teleportToRegion(player, regionId)
end

-- Validate the sign-up party. 
-- Returns the overseer result code for the first failed check (1-4), or nil if every check passes.
local function validateSignupParty(player, guardNation, region, required)
    local zoneId = player:getZoneID()
    local inZone = {}
    for _, member in pairs(player:getParty()) do
        if member:getZoneID() == zoneId then
            table.insert(inZone, member)
        end
    end

    -- 1: not enough members present in the overseer's zone
    if #inZone < required then
        return 1
    end

    -- 2: a member is not a citizen of the overseer's nation
    for _, member in ipairs(inZone) do
        if member:getNation() ~= guardNation then
            return 2
        end
    end

    -- 3: a member is below the Conquest rank requirement
    for _, member in ipairs(inZone) do
        if member:getRank(guardNation) < xi.expeditionaryForce.config.minRank then
            return 3
        end
    end

    -- 4: a member is below the region's minimum level
    for _, member in ipairs(inZone) do
        if member:getMainLvl() < region.minLevel then
            return 4
        end
    end

    return nil
end

-- Overseer EF menu dispatch (event update). 
-- Validates the party and tells the cutscene which result message to show. 
-- The badge is granted in overseerOnEventFinish, after the cutscene animation. 
-- Result codes -> params[0] of updateEvent:
--   1 = not enough members / not all in the overseer's zone
--   2 = a member is not a citizen of the overseer's nation
--   3 = a member is below Conquest rank 3
--   4 = a member is below the region's min level (level passed as updateEvent arg 7)
--   5 = success (cutscene plays the animation, then overseerOnEventFinish fires)
xi.expeditionaryForce.overseerOnEventUpdate = function(player, csid, option, guardNation)
    -- Quick quit
    if option < 0x20006 or option > 0x20014 then
        return false
    end

    local regionId = regionFromEventOption(option)
    if regionId == nil then
        return false
    end

    local region   = xi.expeditionaryForce.regions[regionId]
    local required = xi.expeditionaryForce.getRequiredPartySize(player)
    local failCode = validateSignupParty(player, guardNation, region, required)

    if failCode == 4 then
        player:updateEvent(4, 0, 0, 0, 0, 0, region.minLevel)
    elseif failCode ~= nil then
        player:updateEvent(failCode)
    else
        player:updateEvent(5) -- Badge granted in overseerOnEventFinish
    end

    return true
end

xi.expeditionaryForce.overseerOnEventFinish = function(player, csid, option, guardNation)
    -- Region codes
    if option >= 0x20006 and option <= 0x20014 then
        local regionId = regionFromEventOption(option)
        if regionId == nil then
            return false
        end

        if not player:hasStatusEffect(xi.effect.EF_BADGE) then
            player:addStatusEffect(xi.effect.EF_BADGE, { power = regionId, origin = player, flag = xi.effectFlag.ON_ZONE })
        end

        return true
    end

    -- Badge holder confirmed the teleport branch.
    if option == 5 and player:hasStatusEffect(xi.effect.EF_BADGE) then
        handleCommit(player)
        return true
    end

    -- Player confirmed the quit branch.
    if option == 8 and player:hasStatusEffect(xi.effect.EF_BADGE) then
        player:delStatusEffect(xi.effect.EF_BADGE)
        return true
    end

    return false
end
