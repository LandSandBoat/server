-----------------------------------
-- Treasure Hunter tuning
-- Custom TH curve:
-- TH1 = +15%
-- TH2 = +30%
-- TH3 = +50%
-- TH4+ = +75%
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.treasureHunter = xi.combat.treasureHunter or {}
-----------------------------------

-- NOTE:
-- These tables are kept for compatibility / reference,
-- but getDropRate below uses our custom flat-per-tier model
-- instead of this old SE-style bracket table.

-- https://forum.square-enix.com/ffxi/threads/56550
xi.combat.treasureHunter.treasureHunterTable =
{
-- TH lvl    VC    C     UC    R     VR    SR   UR
    [ 0] = { 2400, 1500, 1000,  500,  100,  50,  10 },
    [ 1] = { 4800, 3000, 1200,  600,  150,  75,  20 },
    [ 2] = { 5600, 4000, 1500,  700,  200, 100,  30 },
    [ 3] = { 6000, 4250, 1650,  750,  225, 120,  35 },
    [ 4] = { 6400, 4500, 1800,  800,  250, 140,  40 },
    [ 5] = { 6666, 4750, 1900,  850,  300, 160,  45 },
    [ 6] = { 6800, 5000, 2000,  900,  350, 180,  50 },
    [ 7] = { 6900, 5250, 2100,  950,  400, 200,  60 },
    [ 8] = { 7050, 5500, 2250, 1050,  475, 230,  70 },
    [ 9] = { 7200, 5750, 2400, 1150,  550, 260,  80 },
    [10] = { 7350, 6000, 2650, 1250,  650, 300,  90 },
    [11] = { 7400, 6250, 2800, 1350,  750, 350, 100 },
    [12] = { 7600, 6500, 2950, 1550,  825, 400, 115 },
    [13] = { 7800, 6750, 3100, 1750,  900, 450, 130 },
    [14] = { 8000, 7000, 3250, 2000, 1000, 500, 150 },
}

xi.combat.treasureHunter.dropBracketTable =
{
    [1] = { 2400 },
    [2] = { 1500 },
    [3] = { 1000 },
    [4] = {  500 },
    [5] = {  100 },
    [6] = {   50 },
    [7] = {    0 }, -- Set to 0, for weird cases in DB.
}

-----------------------------------
-- Custom TH getDropRate
-- Input:  thLevel  = Treasure Hunter tier (0–14)
--         dropRate = base drop chance (0–10000)
-- Output: new drop chance (0–10000)
-----------------------------------
xi.combat.treasureHunter.getDropRate = function(thLevel, dropRate)
    -- Sanitize parameters
    local thTier   = utils.defaultIfNil(thLevel, 0)
    local baseRate = utils.defaultIfNil(dropRate, 0)

    -- Clamp values
    thTier   = utils.clamp(thTier, 0, 14)
    baseRate = utils.clamp(baseRate, 0, 10000)

    -- Early exits: no drop or guaranteed drop
    if baseRate == 0 then
        return 0
    elseif baseRate == 10000 then
        return 10000
    end

    -- Custom bonus per TH tier (as a multiplier of base rate)
    -- TH1 = +25%, TH2 = +45%, TH3 = +65%, TH4+ = +85%
    local bonus = 0.0

    if thTier == 0 then
        bonus = 0.00
    elseif thTier == 1 then
        bonus = 0.25
    elseif thTier == 2 then
        bonus = 0.45
    elseif thTier == 3 then
        bonus = 0.65
    elseif thTier >= 4 then
        bonus = 0.85
    end

    -- Apply bonus to base rate
    local newRate = math.floor(baseRate * (1.0 + bonus))

    -- Cap at 100%
    if newRate > 10000 then
        newRate = 10000
    end

    return newRate
end
