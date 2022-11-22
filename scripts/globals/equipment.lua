require("scripts/globals/status")

xi.equipment = xi.equipment or {}

xi.equipment.baseNyzulWeapons =
{
    18492, -- (WAR) Sturdy Axe
    18753, -- (MNK) Burning Fists
    18851, -- (WHM) Werebuster
    18589, -- (BLM) Mage's Staff
    17742, -- (RDM) Vorpal Sword
    18003, -- (THF) Swordbreaker
    17744, -- (PLD) Brave Blade
    18944, -- (DRK) Death Sickle
    17956, -- (BST) Double Axe
    18034, -- (BRD) Dancing Dagger
    18719, -- (RNG) Killer Bow
    18443, -- (SAM) Windslicer
    18426, -- (NIN) Sasuke Katana
    18120, -- (DRG) Radiant Lance
    18590, -- (SMN) Scepter Staff
    17743, -- (BLU) Wightslayer
    18720, -- (COR) Quicksilver
    18754, -- (PUP) Inferno Claws
    19102, -- (DNC) Main Gauche
    18592  -- (SCH) Elder Staff
}

-----------------------------------
-- Relic/Mythic/Empyrean tables
-----------------------------------

xi.equipment.relic =
{
    SPHARAI       = 0,
    MANDAU        = 1,
    EXCALIBUR     = 2,
    RAGNAROK      = 3,
    GUTTLER       = 4,
    BRAVURA       = 5,
    APOCALYPSE    = 6,
    GUNGNIR       = 7,
    KIKOKU        = 8,
    AMANOMURAKUMO = 9,
    MJOLLNIR      = 10,
    CLAUSTRUM     = 11,
    YOICHINOYUMI  = 12,
    ANNIHILATOR   = 13,
    GJALLARHORN   = 14,
    AEGIS         = 15
}

xi.equipment.relicIDs =
{
    [xi.equipment.relic.SPHARAI] =
    {
        18264, 18265, 18637, 18651, 18665, 19746, 19839, 20480, 20481, 20509
    },
    [xi.equipment.relic.MANDAU] =
    {
        18270, 18271, 18638, 18652, 18666, 19747, 19840, 20555, 20556, 20583
    },
    [xi.equipment.relic.EXCALIBUR] =
    {
        18276, 18277, 18639, 18653, 18667, 19748, 19841, 20645, 20646, 20685
    },
    [xi.equipment.relic.RAGNAROK] =
    {
        18282, 18283, 18640, 18654, 18668, 19749, 19842, 20745, 20746, 21683
    },
    [xi.equipment.relic.GUTTLER] =
    {
        18288, 18289, 18641, 18655, 18669, 19750, 19843, 20790, 20791, 21750
    },
    [xi.equipment.relic.BRAVURA] =
    {
        18294, 18295, 18642, 18656, 18670, 19751, 19844, 20835, 20836, 21756
    },
    [xi.equipment.relic.APOCALYPSE] =
    {
        18306, 18307, 18644, 18658, 18672, 19753, 19846, 20880, 20881, 21808
    },
    [xi.equipment.relic.GUNGNIR] =
    {
        18300, 18301, 18643, 18657, 18671, 19752, 19845, 20925, 20926, 21857
    },
    [xi.equipment.relic.KIKOKU] =
    {
        18312, 18313, 18645, 18659, 18673, 19754, 19847, 20970, 20971, 21906
    },
    [xi.equipment.relic.AMANOMURAKUMO] =
    {
        18318, 18319, 18646, 18660, 18674, 19755, 19848, 21015, 21016, 21954
    },
    [xi.equipment.relic.MJOLLNIR] =
    {
        18324, 18325, 18647, 18661, 18675, 19756, 19849, 21060, 21061, 21077
    },
    [xi.equipment.relic.CLAUSTRUM] =
    {
        18330, 18331, 18648, 18662, 18676, 19757, 19850, 21135, 21136, 22060
    },
    [xi.equipment.relic.YOICHINOYUMI] =
    {
        18348, 18349, 18650, 18664, 18678, 19759, 19852, 21210, 21211, 22115, 22129
    },
    [xi.equipment.relic.ANNIHILATOR] =
    {
        18336, 18337, 18649, 18663, 18677, 19758, 19851, 21260, 21261, 21267, 22140
    },
    [xi.equipment.relic.GJALLARHORN] =
    {
        18342, 18577, 18578, 18579, 18580, 18572, 18840
    },
    [xi.equipment.relic.AEGIS] =
    {
        15070, 16195, 16196, 16197, 16198, 11927, 16200
    },
}

-----------------------------------
-- Place convenience functions
-- related to equipment here
-----------------------------------
-- TODO: Should Adoulin exist here as well?
local artifactArmorRanges =
{
--      Min,   Max
    { 12511, 12520 }, -- Original Head
    { 13855, 13857 },
    { 13868, 13869 },
    { 12638, 12650 }, -- Original Body
    { 13781, 13782 },
    { 13961, 13975 }, -- Original Hand
    { 14089, 14103 }, -- Original Feet
    { 14214, 14228 }, -- Original Legs
    { 15265, 15267 }, -- ToAU Head
    { 14521, 14523 }, -- ToAU Body
    { 14928, 14930 }, -- ToAU Hand
    { 15684, 15686 }, -- ToAU Feet
    { 15600, 15602 }, -- ToAU Legs
    { 16138, 16140 }, -- WotG Head
    { 14578, 14580 }, -- WotG Body
    { 15002, 15004 }, -- WotG Hand
    { 15746, 15748 }, -- WotG Feet
    { 15659, 15661 }, -- WotG Legs
}

xi.equipment.isArtifactArmor = function(itemId)
    for _, v in ipairs(artifactArmorRanges) do
        if itemId >= v[1] and itemId <= v[2] then
            return true
        end
    end

    return false
end

xi.equipment.isBaseNyzulWeapon = function(itemId)
    for i, wepId in pairs(xi.equipment.baseNyzulWeapons) do
        if itemId == wepId then
            return true
        end
    end

    return false
end

-----------------------------------
-- Returns true if player has any tier of given relic,
--  if tier is specified, returns true only if player
--  has that tier
-- Tier:
-- 1  = 75
-- 2  = 80
-- 3  = 85
-- 4  = 90
-- 5  = 95
-- 6  = 99 I
-- 7  = 99 II
-- 8  = 119 I
-- 9  = 119 II
-- 10 = 119 III
-- 11 = 119 III (ranged only)
-----------------------------------
xi.equipment.hasRelic = function(player, relic, tier)
    if tier ~= nil then
        return player:hasItem(xi.equipment.relicIDs[relic][tier])
    end

    for i, itemID in pairs(xi.equipment.relicIDs[relic]) do
        if player:hasItem(itemID) then
            return true
        end
    end

    return false
end

xi.equip = xi.equipment
