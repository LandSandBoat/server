-----------------------------------
-- Voidwatch Global
-----------------------------------
-- Voidwatch is a confrontation-style battle system where players fight NMs
-- at Planar Rift locations. Features spectral alignment mechanics that
-- determine reward quality/quantity, a weakness/stagger system, and
-- progression through chapters gated by stratum abyssite key items.
--
-- Reference: https://www.bg-wiki.com/ffxi/Voidwatch
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------
xi = xi or {}
xi.voidwatch = xi.voidwatch or {}

-----------------------------------
-- Spectral Alignment Colors
-----------------------------------
xi.voidwatch.alignmentType =
{
    RED    = 1, -- Reward quality (100-550%)
    BLUE   = 2, -- Reward quantity (100-550%, each 100% = 1 item)
    GREEN  = 3, -- Cruor yield (100-325%)
    YELLOW = 4, -- EXP yield (100-325%)
    WHITE  = 5, -- Atmacite/periapt drop chance (0-100%)
}

xi.voidwatch.alignmentCaps =
{
    [xi.voidwatch.alignmentType.RED   ] = 550,
    [xi.voidwatch.alignmentType.BLUE  ] = 550,
    [xi.voidwatch.alignmentType.GREEN ] = 325,
    [xi.voidwatch.alignmentType.YELLOW] = 325,
    [xi.voidwatch.alignmentType.WHITE ] = 100,
}

-----------------------------------
-- Stagger Tiers
-----------------------------------
xi.voidwatch.staggerType =
{
    EXTREME = 1, -- 1 per NM
    HIGH    = 2, -- 2 per NM
    NORMAL  = 3, -- 6 per NM
}

-- Stagger duration in seconds by chapter tier
xi.voidwatch.staggerDuration =
{
    [1] = 30, -- Chapter I
    [2] = 20, -- Chapter II
    [3] = 10, -- Chapter III
    [4] =  5, -- Provenance
}

-----------------------------------
-- Chapters and Paths
-----------------------------------
xi.voidwatch.chapter =
{
    I   = 1,
    II  = 2,
    III = 3,
    PROVENANCE = 4,
}

xi.voidwatch.path =
{
    -- Chapter I (3 parallel paths, 4 tiers each)
    SAN_DORIA = 1, -- Crimson Stratum Abyssite I-IV
    BASTOK    = 2, -- Indigo Stratum Abyssite I-IV
    WINDURST  = 3, -- Jade Stratum Abyssite I-IV

    -- Chapter II (2 paths)
    JEUNO     = 4, -- White Stratum Abyssite I-III
    ZILART    = 5, -- Ashen Stratum Abyssite I-III

    -- Chapter III (3 paths)
    JEUNO_II  = 6, -- White Stratum Abyssite IV-VI
    TAVNAZIA  = 7, -- Hyacinth Stratum Abyssite I-II
    AHT_URHGAN = 8, -- Amber Stratum Abyssite I-II
}

-----------------------------------
-- Stratum Abyssite Definitions
-- Maps path -> tier -> key item ID
-----------------------------------
xi.voidwatch.stratumAbyssites =
{
    [xi.voidwatch.path.SAN_DORIA] =
    {
        [1] = xi.ki.CRIMSON_STRATUM_ABYSSITE,
        [2] = xi.ki.CRIMSON_STRATUM_ABYSSITE_II,
        [3] = xi.ki.CRIMSON_STRATUM_ABYSSITE_III,
        [4] = xi.ki.CRIMSON_STRATUM_ABYSSITE_IV,
    },

    [xi.voidwatch.path.BASTOK] =
    {
        [1] = xi.ki.INDIGO_STRATUM_ABYSSITE,
        [2] = xi.ki.INDIGO_STRATUM_ABYSSITE_II,
        [3] = xi.ki.INDIGO_STRATUM_ABYSSITE_III,
        [4] = xi.ki.INDIGO_STRATUM_ABYSSITE_IV,
    },

    [xi.voidwatch.path.WINDURST] =
    {
        [1] = xi.ki.JADE_STRATUM_ABYSSITE,
        [2] = xi.ki.JADE_STRATUM_ABYSSITE_II,
        [3] = xi.ki.JADE_STRATUM_ABYSSITE_III,
        [4] = xi.ki.JADE_STRATUM_ABYSSITE_IV,
    },

    [xi.voidwatch.path.JEUNO] =
    {
        [1] = xi.ki.WHITE_STRATUM_ABYSSITE,
        [2] = xi.ki.WHITE_STRATUM_ABYSSITE_II,
        [3] = xi.ki.WHITE_STRATUM_ABYSSITE_III,
    },

    [xi.voidwatch.path.ZILART] =
    {
        [1] = xi.ki.ASHEN_STRATUM_ABYSSITE,
        [2] = xi.ki.ASHEN_STRATUM_ABYSSITE_II,
        [3] = xi.ki.ASHEN_STRATUM_ABYSSITE_III,
    },

    [xi.voidwatch.path.JEUNO_II] =
    {
        [4] = xi.ki.WHITE_STRATUM_ABYSSITE_IV,
        [5] = xi.ki.WHITE_STRATUM_ABYSSITE_V,
        [6] = xi.ki.WHITE_STRATUM_ABYSSITE_VI,
    },

    [xi.voidwatch.path.TAVNAZIA] =
    {
        [1] = xi.ki.HYACINTH_STRATUM_ABYSSITE,
        [2] = xi.ki.HYACINTH_STRATUM_ABYSSITE_II,
    },

    [xi.voidwatch.path.AHT_URHGAN] =
    {
        [1] = xi.ki.AMBER_STRATUM_ABYSSITE,
        [2] = xi.ki.AMBER_STRATUM_ABYSSITE_II,
    },
}

-----------------------------------
-- Chapter I NM Definitions
-- Maps path -> tier -> zone -> NM data
-- NM names/IDs TBD pending mob data dumps
-----------------------------------
xi.voidwatch.chapterOneZones =
{
    [xi.voidwatch.path.SAN_DORIA] =
    {
        [1] = xi.zone.EAST_RONFAURE,
        [2] = xi.zone.ORDELLES_CAVES,
        [3] = xi.zone.JUGNER_FOREST,
        [4] = xi.zone.KING_RANPERRES_TOMB,
    },

    [xi.voidwatch.path.BASTOK] =
    {
        [1] = xi.zone.NORTH_GUSTABERG,
        [2] = xi.zone.GUSGEN_MINES,
        [3] = xi.zone.PASHHOW_MARSHLANDS,
        [4] = xi.zone.DANGRUF_WADI,
    },

    [xi.voidwatch.path.WINDURST] =
    {
        [1] = xi.zone.WEST_SARUTABARUTA,
        [2] = xi.zone.MAZE_OF_SHAKHRAMI,
        [3] = xi.zone.MERIPHATAUD_MOUNTAINS,
        [4] = xi.zone.OUTER_HORUTOTO_RUINS,
    },
}

-----------------------------------
-- Voidstone Management
-----------------------------------
-- Base regeneration: 1 stone per 20 real hours
-- Reduced by 4 hours per exploration periapt (min 12 hours)
-- Base capacity: 3, expandable to 6 via frontier periapts
-----------------------------------

xi.voidwatch.VOIDSTONE_BASE_REGEN_HOURS = 20
xi.voidwatch.VOIDSTONE_REGEN_REDUCTION_PER_PERIAPT = 4
xi.voidwatch.VOIDSTONE_MIN_REGEN_HOURS = 12
xi.voidwatch.VOIDSTONE_BASE_CAPACITY = 3
xi.voidwatch.VOIDSTONE_MAX_CAPACITY = 6

-- Voidstone key items (represent capacity slots)
xi.voidwatch.voidstoneKIs =
{
    xi.ki.VOIDSTONE1,
    xi.ki.VOIDSTONE2,
    xi.ki.VOIDSTONE3,
    xi.ki.VOIDSTONE4,
    xi.ki.VOIDSTONE5,
    xi.ki.VOIDSTONE6,
}

-- Get the player's maximum voidstone capacity
xi.voidwatch.getVoidstoneCapacity = function(player)
    local capacity = xi.voidwatch.VOIDSTONE_BASE_CAPACITY

    if player:hasKeyItem(xi.ki.VIVID_PERIAPT_OF_FRONTIERS) then
        capacity = capacity + 1
    end

    if player:hasKeyItem(xi.ki.DUSKY_PERIAPT_OF_FRONTIERS) then
        capacity = capacity + 1
    end

    if player:hasKeyItem(xi.ki.NEUTRAL_PERIAPT_OF_FRONTIERS) then
        capacity = capacity + 1
    end

    return math.min(capacity, xi.voidwatch.VOIDSTONE_MAX_CAPACITY)
end

-- Get the player's voidstone regeneration time in seconds
xi.voidwatch.getVoidstoneRegenTime = function(player)
    local hours = xi.voidwatch.VOIDSTONE_BASE_REGEN_HOURS

    if player:hasKeyItem(xi.ki.VIVID_PERIAPT_OF_EXPLORATION) then
        hours = hours - xi.voidwatch.VOIDSTONE_REGEN_REDUCTION_PER_PERIAPT
    end

    if player:hasKeyItem(xi.ki.DUSKY_PERIAPT_OF_EXPLORATION) then
        hours = hours - xi.voidwatch.VOIDSTONE_REGEN_REDUCTION_PER_PERIAPT
    end

    return math.max(hours, xi.voidwatch.VOIDSTONE_MIN_REGEN_HOURS) * 3600
end

-- Get the number of voidstones the player currently has
xi.voidwatch.getVoidstoneCount = function(player)
    local count = 0
    for _, ki in ipairs(xi.voidwatch.voidstoneKIs) do
        if player:hasKeyItem(ki) then
            count = count + 1
        end
    end

    return count
end

-- Grant a voidstone to the player (returns true if successful)
xi.voidwatch.grantVoidstone = function(player)
    local capacity = xi.voidwatch.getVoidstoneCapacity(player)

    for i = 1, capacity do
        if not player:hasKeyItem(xi.voidwatch.voidstoneKIs[i]) then
            player:addKeyItem(xi.voidwatch.voidstoneKIs[i])
            return true
        end
    end

    return false -- at capacity
end

-- Consume a voidstone from the player (returns true if successful)
xi.voidwatch.consumeVoidstone = function(player)
    -- Consume from highest slot first
    for i = xi.voidwatch.VOIDSTONE_MAX_CAPACITY, 1, -1 do
        if player:hasKeyItem(xi.voidwatch.voidstoneKIs[i]) then
            player:delKeyItem(xi.voidwatch.voidstoneKIs[i])
            return true
        end
    end

    return false -- no stones
end

-----------------------------------
-- Periapt Helpers
-----------------------------------

-- Count how many emergence periapts the player has (max 3 = max 3 atmacites)
xi.voidwatch.getEmergenceCount = function(player)
    local count = 0

    if player:hasKeyItem(xi.ki.PERIAPT_OF_EMERGENCE1) then
        count = count + 1
    end

    if player:hasKeyItem(xi.ki.PERIAPT_OF_EMERGENCE2) then
        count = count + 1
    end

    if player:hasKeyItem(xi.ki.PERIAPT_OF_EMERGENCE3) then
        count = count + 1
    end

    return count
end

-----------------------------------
-- Atmacite Definitions
-- Maps key item ID -> { mod pairs at level 1 }
-- Each level multiplies the base values
-- Enrichment cost per level (cruor):
--   Levels 1-5:  1,050 each (5,250 total)
--   Levels 6-10: 10,500 each (52,500 total)
--   Levels 11-15: 105,000 each (525,000 total)
--   With Rhapsody in Mauve: costs reduced to 5%
-----------------------------------
xi.voidwatch.atmaciteList =
{
    xi.ki.ATMACITE_OF_DEVOTION,
    xi.ki.ATMACITE_OF_PERSISTENCE,
    xi.ki.ATMACITE_OF_EMINENCE,
    xi.ki.ATMACITE_OF_ONSLAUGHT,
    xi.ki.ATMACITE_OF_INCURSION,
    xi.ki.ATMACITE_OF_ENTICEMENT,
    xi.ki.ATMACITE_OF_DESTRUCTION,
    xi.ki.ATMACITE_OF_TEMPERANCE,
    xi.ki.ATMACITE_OF_DISCIPLINE,
    xi.ki.ATMACITE_OF_COERCION,
    xi.ki.ATMACITE_OF_FINESSE,
    xi.ki.ATMACITE_OF_LATITUDE,
    xi.ki.ATMACITE_OF_MYSTICISM,
    xi.ki.ATMACITE_OF_RAPIDITY,
    xi.ki.ATMACITE_OF_PREPAREDNESS,
    xi.ki.ATMACITE_OF_DELUGES,
    xi.ki.ATMACITE_OF_UNITY,
    xi.ki.ATMACITE_OF_EXHORTATION,
    xi.ki.ATMACITE_OF_SKYBLAZE,
    xi.ki.ATMACITE_OF_THE_SLAYER,
    xi.ki.ATMACITE_OF_THE_ADAMANT,
    xi.ki.ATMACITE_OF_THE_VALIANT,
    xi.ki.ATMACITE_OF_THE_SHREWD,
    xi.ki.ATMACITE_OF_THE_VANGUARD,
    xi.ki.ATMACITE_OF_ASSAILMENT,
    xi.ki.ATMACITE_OF_CATAPHRACT,
    xi.ki.ATMACITE_OF_THE_PARAPET,
    xi.ki.ATMACITE_OF_IMPERIUM,
    xi.ki.ATMACITE_OF_THE_SOLIPSIST,
    xi.ki.ATMACITE_OF_PROVENANCE,
    xi.ki.ATMACITE_OF_DARK_DESIGNS,
    xi.ki.ATMACITE_OF_THE_FORAGER,
    xi.ki.ATMACITE_OF_GLACIERS,
    xi.ki.ATMACITE_OF_AFFINITY,
    xi.ki.ATMACITE_OF_THE_DEPTHS,
    xi.ki.ATMACITE_OF_THE_ASSASSIN,
    xi.ki.ATMACITE_OF_APLOMB,
    xi.ki.ATMACITE_OF_THE_TROPICS,
    xi.ki.ATMACITE_OF_CURSES,
    xi.ki.ATMACITE_OF_PRESERVATION,
}

xi.voidwatch.ATMACITE_MAX_LEVEL = 15

-- Enrichment cost tiers (cruor per level)
xi.voidwatch.getEnrichmentCost = function(level, player)
    local cost = 0

    if level <= 5 then
        cost = 1050
    elseif level <= 10 then
        cost = 10500
    else
        cost = 105000
    end

    -- Rhapsody in Mauve reduces costs to 5%
    if player and player:hasKeyItem(xi.ki.RHAPSODY_IN_MAUVE) then
        cost = math.floor(cost * 0.05)
    end

    return cost
end

-- Get atmacite level from char_vars
-- Stored as: VW_Atmacite_<kiID> = level (1-15)
xi.voidwatch.getAtmaciteLevel = function(player, atmaciteKI)
    return player:getCharVar(string.format('VW_Atmacite_%d', atmaciteKI))
end

-- Set atmacite level
xi.voidwatch.setAtmaciteLevel = function(player, atmaciteKI, level)
    player:setCharVar(string.format('VW_Atmacite_%d', atmaciteKI), math.min(level, xi.voidwatch.ATMACITE_MAX_LEVEL))
end

-- Get currently infused atmacites (up to 3)
-- Stored as: VW_Infused_1, VW_Infused_2, VW_Infused_3 = key item ID (0 = empty)
xi.voidwatch.getInfusedAtmacites = function(player)
    local infused = {}
    for i = 1, 3 do
        local ki = player:getCharVar(string.format('VW_Infused_%d', i))
        if ki > 0 then
            table.insert(infused, ki)
        end
    end

    return infused
end

-- Infuse an atmacite into the next available slot
xi.voidwatch.infuseAtmacite = function(player, atmaciteKI)
    local maxSlots = xi.voidwatch.getEmergenceCount(player)
    for i = 1, maxSlots do
        if player:getCharVar(string.format('VW_Infused_%d', i)) == 0 then
            player:setCharVar(string.format('VW_Infused_%d', i), atmaciteKI)
            return true
        end
    end

    return false -- no free slots
end

-- Remove a specific infused atmacite
xi.voidwatch.removeAtmacite = function(player, atmaciteKI)
    for i = 1, 3 do
        if player:getCharVar(string.format('VW_Infused_%d', i)) == atmaciteKI then
            player:setCharVar(string.format('VW_Infused_%d', i), 0)
            return true
        end
    end

    return false
end

-- Remove all infused atmacites
xi.voidwatch.removeAllAtmacites = function(player)
    for i = 1, 3 do
        player:setCharVar(string.format('VW_Infused_%d', i), 0)
    end
end

-----------------------------------
-- Progression Helpers
-----------------------------------

-- Check if the player has the Voidwatch Alarum (entry key item)
xi.voidwatch.hasAlarum = function(player)
    return player:hasKeyItem(xi.ki.VOIDWATCH_ALARUM)
end

-- Get the player's current tier for a given path
xi.voidwatch.getPathTier = function(player, path)
    local abyssites = xi.voidwatch.stratumAbyssites[path]
    if not abyssites then
        return 0
    end

    local highestTier = 0
    for tier, ki in pairs(abyssites) do
        if player:hasKeyItem(ki) then
            highestTier = math.max(highestTier, tier)
        end
    end

    return highestTier
end

-- Check if the player can access a specific tier of a path
xi.voidwatch.canAccessTier = function(player, path, tier)
    if tier <= 1 then
        return xi.voidwatch.hasAlarum(player)
    end

    -- Need previous tier's abyssite
    local abyssites = xi.voidwatch.stratumAbyssites[path]
    if not abyssites or not abyssites[tier - 1] then
        return false
    end

    return player:hasKeyItem(abyssites[tier - 1])
end

-----------------------------------
-- Item Constants
-----------------------------------
xi.voidwatch.items =
{
    COBALT_CELL       = 3434, -- xi.item.COBALT_CELL
    RUBICUND_CELL     = 3435, -- xi.item.RUBICUND_CELL
    XANTHOUS_CELL     = 3436, -- xi.item.XANTHOUS_CELL
    JADE_CELL         = 3437, -- xi.item.JADE_CELL
    VOIDDUST          = 3450, -- xi.item.POUCH_OF_VOIDDUST
    PHASE_DISPLACER   = 3853,
    CRYSTAL_PETRIFACT = 3508,
}

-----------------------------------
-- Purveyor Currency Types (by zone nation)
-----------------------------------
xi.voidwatch.currencyType =
{
    CONQUEST  = 1, -- San d'Oria, Bastok, Windurst zones
    ALLIED    = 2, -- Campaign/WotG zones
    IMPERIAL  = 3, -- Aht Urhgan zones
}

xi.voidwatch.PURVEYOR_ITEM_COST = 2000 -- cost per cell/voiddust in nation currency

-----------------------------------
-- Officer Shop Prices (cruor)
-----------------------------------
xi.voidwatch.officerPrices =
{
    PERIAPT     = 50000,  -- base periapt cost (50k-150k varies)
    CELL        = 3000,   -- cellular items
    PETRIFACT   = 330000, -- crystal petrifact
}

-----------------------------------
-- Phase Displacer Pricing
-----------------------------------
xi.voidwatch.PHASE_DISPLACER_PRICE = 20000         -- 20,000 gil
xi.voidwatch.PHASE_DISPLACER_PRICE_MAUVE = 1000    -- 1,000 gil with Rhapsody in Mauve

xi.voidwatch.getPhaseDisplacerPrice = function(player)
    if player:hasKeyItem(xi.ki.RHAPSODY_IN_MAUVE) then
        return xi.voidwatch.PHASE_DISPLACER_PRICE_MAUVE
    end

    return xi.voidwatch.PHASE_DISPLACER_PRICE
end
