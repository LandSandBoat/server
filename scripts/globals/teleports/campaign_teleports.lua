-----------------------------------
-- Campaign teleport-related functions
-----------------------------------
require('scripts/globals/campaign')
require('scripts/globals/teleports')
-----------------------------------
xi = xi or {}
xi.campaign = xi.campaign or {}
xi.campaign.teleports = xi.campaign.teleports or {}

local baseCampaignCSID = 454
local baseTeleportCSID = 458

-----------------------------------
-- Campaign Zones enum
-- Used to drive Campaign Teleport Menus and logic
-----------------------------------
local campaignZone = {
    [1] =
    {
        zone = xi.zone.XARCABARD_S,
        fee = 60,
    },
    [2] =
    {
        zone = xi.zone.BEAUCEDINE_GLACIER_S,
        fee = 60,
    },
    [3] =
    {
        zone = xi.zone.BATALLIA_DOWNS_S,
        fee = 50,
    },
    [4] =
    {
        zone = xi.zone.ROLANBERRY_FIELDS_S,
        fee = 50,
    },
    [5] =
    {
        zone = xi.zone.SAUROMUGUE_CHAMPAIGN_S,
        fee = 50,
    },
    [6] =
    {
        zone = xi.zone.JUGNER_FOREST_S,
        fee = 40,
    },
    [7] =
    {
        zone = xi.zone.PASHHOW_MARSHLANDS_S,
        fee = 40,
    },
    [8] =
    {
        zone = xi.zone.MERIPHATAUD_MOUNTAINS_S,
        fee = 40,
    },
    [9] =
    {
        zone = xi.zone.VUNKERL_INLET_S,
        fee = 30,
    },
    [10] =
    {
        zone = xi.zone.GRAUBERG_S,
        fee = 30,
    },
    [11] =
    {
        zone = xi.zone.FORT_KARUGO_NARUGO_S,
        fee = 30,
    },
    [12] =
    {
        zone = xi.zone.EAST_RONFAURE_S,
        fee = 20,
    },
    [13] =
    {
        zone = xi.zone.NORTH_GUSTABERG_S,
        fee = 20,
    },
    [14] =
    {
        zone = xi.zone.WEST_SARUTABARUTA_S,
        fee = 20,
    },
    [15] =
    {
        zone = xi.zone.SOUTHERN_SAN_DORIA_S,
        fee = 20,
    },
    [16] =
    {
        zone = xi.zone.BASTOK_MARKETS_S,
        fee = 20,
    },
    [17] =
    {
        zone = xi.zone.WINDURST_WATERS_S,
        fee = 20,
    },
    -- have not found documentation on the cost of these zones other than that they are enabled
    -- going by the "distance from home nation" trend, these zones are one step further than Rolanberry/Batallia/Sauromugue
    [18] =
    {
        zone = xi.zone.GARLAIGE_CITADEL_S,
        fee = 60,
    },
    [19] =
    {
        zone = xi.zone.CRAWLERS_NEST_S,
        fee = 60,
    },
    [20] =
    {
        zone = xi.zone.THE_ELDIEME_NECROPOLIS_S,
        fee = 60,
    },
}

local zoneToAlliedNation = {
    [xi.zone.SOUTHERN_SAN_DORIA_S] = xi.alliedNation.SANDORIA,
    [xi.zone.BASTOK_MARKETS_S] = xi.alliedNation.BASTOK,
    [xi.zone.WINDURST_WATERS_S] = xi.alliedNation.WINDURST,
}

local function deductFeeAndRetrace(player, fee)
    if player:getCurrency('allied_notes') >= fee then
        player:delCurrency('allied_notes', fee)
        player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.RETRACE, 0, 1)
    end
end

-- -----------------------------------------------------------------------------------------------
-- getAllowedCampaignTeleports()
-- Returns the WotG allowed teleport zones that the player has previously visted in a set of bits
-- -----------------------------------------------------------------------------------------------
local function getAllowedCampaignTeleports(player)
    local allowedTeleports = 0
    for i, v in pairs(campaignZone) do
        if player:hasVisitedZone(v.zone) then
            local teleBit = i
            -- Note: There is a gap here for bits 15, 16, and 17.  The menu supports but does not use these slots for the 3 WotG Towns
            if
                teleBit < 15 or
                teleBit > 17
            then
                allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1, teleBit))
            end
        end
    end

    if allowedTeleports == 0 then
        -- If a player manages to get to a CA in town w/o going through any past zones - dont show an empty menu - show a "no thanks option"
        allowedTeleports = 1
    end

    return allowedTeleports
end

 ----------------------------------------------------------------------------------------------------------
 -- showTeleportOption
 -- returns 32 (the hide teleport option flag value) if the npc is in the zone the player would retrace to
 ----------------------------------------------------------------------------------------------------------
local function showTeleportOption(npc, campaignAllegiance)
    -- Note all CampaignNPCs should reject players with no allegiance
    local menuOptions = 0
    if
        zoneToAlliedNation[npc:getZoneID()] == campaignAllegiance
    then
        menuOptions = 32
    end

    return menuOptions
end

-- ----------------------------------------------------------------------------
-- teleportFee()
-- Determines fee for a player teleporting from the teleport nation to the destination
-- ----------------------------------------------------------------------------
local function getTeleportFee(player, destination)
    -- TODO:Campgain_Control - We dont have control modeled yet - until we do, we cannot calculate cost based on control
    -- Cost Source: https://ffxiclopedia.fandom.com/wiki/Allied_Notes#Teleportation

    local campaignAllegiance = player:getCampaignAllegiance()
    local npcAllegiance = zoneToAlliedNation[player:getZoneID()]

    local fee = 0
    local destinationDict = campaignZone[destination]
    if destinationDict ~= nil then
        fee = destinationDict.fee
    else
        fee = 60
    end

    -- Calculate control cost - Until control is modeled treat all zones as allied controlled
    fee = fee + 20
    -- if not getCampaignZoneControl(destination) == campaignAllegiance then -- controlled by player's allegiance
        -- if getCampaignZoneControl(destination) == 0 then  -- Beastmen Controlled
        --      -- fee = fee + 40
        -- else -- Allied controlled
        --      -- fee = fee + 20
        -- end
    -- end
    if campaignAllegiance ~= npcAllegiance then
        fee = fee * 1.2
    end

    return fee
end

local getNPCAllegiance = function(npc)
    local npcSuffix = string.sub(npc:getName(), -3)
    if
        npcSuffix == '_TK' or
        npcSuffix == '_RK'
    then
        return 1
    elseif
        npcSuffix == '_LC' or
        npcSuffix == '_IM'
    then
        return 2
    elseif
        npcSuffix == '_CC' or
        npcSuffix == '_MC'
    then
        return 3
    else
        return 4
    end
end

-- ----------------------------------------------------------------------------
-- teleporterOnTrigger()
-- Triggered when a campaign teleport NPC is triggered
-- Will perform initial campaign teleport setup by providing allegiance and AN
-- ----------------------------------------------------------------------------
xi.campaign.teleports.teleporterOnTrigger = function(player, npc)
    -- Priming event - sends allegiance and current allied notes
    local campaignAllegiance = player:getCampaignAllegiance()  -- 0 = none, 1 = San d'Oria Iron Rams, 2 = Bastok Fighting Fourth, 3 = Windurst Cobras
    if campaignAllegiance == 0 then
        -- player not allied with any WotG nation
        player:startEvent(baseTeleportCSID + 1) -- Civilian
    else
        player:startEvent(baseTeleportCSID, campaignAllegiance, 0, player:getCurrency('allied_notes'))
    end
end

-- ----------------------------------------------------------------------------
-- teleporterOnEventUpdate()
-- Triggered when a campaign teleport NPC provides an update
-- Will provide allowed zones and their control (control is future) on intiial update (50)
-- Will provide fee required on destination selection
-- ----------------------------------------------------------------------------
xi.campaign.teleports.teleporterOnEventUpdate = function(player, csid, option)
    if csid == baseTeleportCSID and option == 50 then
        -- TODO:Campgain_Control - We dont have control modeled yet - until we do, do not show control in the teleport menu
        local ownershipFlags1 = 0 -- Xarc to Pashhow
        local ownershipFlags2 = 0 -- Meriphataud to West Saru
        local ownershipFlags3 = 0 -- Garliage, Crawlers, and Eldime

        local campaignAllegiance = player:getCampaignAllegiance()
        local allowedTeleports = getAllowedCampaignTeleports(player)

        -- Update with allowed teleports and ownership
        player:updateEvent(allowedTeleports, ownershipFlags1, ownershipFlags2, ownershipFlags3, campaignAllegiance, 4, 1, 0) -- TODO research on the last 3 params
    elseif csid == baseTeleportCSID and option <= 20 and option >= 1 then
        -- interestingly - the handling of not enough AN is done client side
        -- we could add an anti-cheat mechanism on envent finish to ensure no exploitation
        local fee = getTeleportFee(player, option)
        player:updateEvent(0, fee)
    end
end

-- ----------------------------------------------------------------------------
-- teleporterOnEventFinish()
-- Triggered when a campaign teleport NPC provides an EventFinish
-- Will deduct AN and teleport player when provided a destination option
-- ----------------------------------------------------------------------------
xi.campaign.teleports.teleporterOnEventFinish = function(player, csid, option)
    if csid == baseTeleportCSID and option <= 20 and option >= 1 then
        local fee = getTeleportFee(player, option)
        if player:getCurrency('allied_notes') >= fee then
            player:delCurrency('allied_notes', fee)
            -- TODO:Campaign_Control - We dont have control modeled yet - until we do there is only one telepoint per zone
            -- Once control is modeled - 2 telepoint per zone - one for nation controlled one for beastmen controlled
            player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.CAMPAIGN, 0, 1, 0, option)
        end
    end
end

-- ----------------------------------------------------------------------------
-- campaignArbiterOnTrigger()
-- Triggered when a campaign NPC is interacted with
-- ----------------------------------------------------------------------------
xi.campaign.teleports.campaignArbiterOnTrigger = function(player, npc)
    -- Priming event - sends allegiance and current allied notes
    -- 32 will hide teleportation
    -- 4 will show New Allied Tags and allow you to get new allied tags
    -- 4 and 8 will show New Allied Tags and not allow you to get new tags (medal has expired)
    -- 16 enables Performance Assessment and Union Registration
    -- 1 will reduce the Retrace cost, signaling ownership
    local campaignAllegiance = player:getCampaignAllegiance()
    local npcAllegiance = getNPCAllegiance(npc)
    local npcBaseCampaignCSID = baseCampaignCSID + npcAllegiance - 1
    if player:getCampaignAllegiance() == 0 then
        player:startEvent(npcBaseCampaignCSID - 4)
    else
        local ownershipOffset = 0
        if npcAllegiance == campaignAllegiance then
            ownershipOffset = 1
        end

        local menuOptions = showTeleportOption(npc, campaignAllegiance) + ownershipOffset

        player:startEvent(npcBaseCampaignCSID, campaignAllegiance, menuOptions, player:getCurrency('allied_notes'))
    end
end

-- ----------------------------------------------------------------------------
-- campaignArbiterOnEventUpdate()
-- Triggered when a campaign arbiter provides an update
-- ----------------------------------------------------------------------------
xi.campaign.teleports.campaignArbiterOnEventUpdate = function(player, csid, option)
    --printf("campaignArbiterOnEventUpdate - csid %u  option %u", csid, option)
end

-- ----------------------------------------------------------------------------
-- campaignArbiterOnEventFinish()
-- Triggered when a campaign arbiter provides an finish
-- ----------------------------------------------------------------------------
xi.campaign.teleports.campaignArbiterOnEventFinish = function(player, csid, option)
    if option == 1 then
        local fee = 0
        -- csid offsets in order:
        -- Sandorian Retrace NPC (TK/RK)
        -- Bastokan Retrace NPC (LC/IM)
        -- Windurstian Retrace NPC (CC/MC)
        if baseCampaignCSID - csid - 1 == player:getCampaignAllegiance() then
            -- player's allegiance matches npc's
            fee = 10
        elseif baseCampaignCSID - csid >= 3 then
            -- Juenonian Retrace NPC (CA) -- we cannot match - we are paying 50
            fee = 50
        else
            -- npc allegiance is mismatched from player
            fee = 30
        end

        deductFeeAndRetrace(player, fee)
    end
end
