xi.equipment = xi.equipment or {}

xi.equipment.baseNyzulWeapons =
{
    xi.item.STURDY_AXE,     -- (WAR)
    xi.item.BURNING_FISTS,  -- (MNK)
    xi.item.WEREBUSTER,     -- (WHM)
    xi.item.MAGES_STAFF,    -- (BLM)
    xi.item.VORPAL_SWORD,   -- (RDM)
    xi.item.SWORDBREAKER,   -- (THF)
    xi.item.BRAVE_BLADE,    -- (PLD)
    xi.item.DEATH_SICKLE,   -- (DRK)
    xi.item.DOUBLE_AXE,     -- (BST)
    xi.item.DANCING_DAGGER, -- (BRD)
    xi.item.KILLER_BOW,     -- (RNG)
    xi.item.WINDSLICER,     -- (SAM)
    xi.item.SASUKE_KATANA,  -- (NIN)
    xi.item.RADIANT_LANCE,  -- (DRG)
    xi.item.SCEPTER_STAFF,  -- (SMN)
    xi.item.WIGHTSLAYER,    -- (BLU)
    xi.item.QUICKSILVER,    -- (COR)
    xi.item.INFERNO_CLAWS,  -- (PUP)
    xi.item.MAIN_GAUCHE,    -- (DNC)
    xi.item.ELDER_STAFF     -- (SCH)
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
        xi.item.SPHARAI,
        xi.item.SPHARAI_80,
        xi.item.SPHARAI_85,
        xi.item.SPHARAI_90,
        xi.item.SPHARAI_95,
        xi.item.SPHARAI_99,
        xi.item.SPHARAI_99_II,
        xi.item.SPHARAI_119,
        xi.item.SPHARAI_119_II,
        xi.item.SPHARAI_119_III,
    },

    [xi.equipment.relic.MANDAU] =
    {
        xi.item.MANDAU,
        xi.item.MANDAU_80,
        xi.item.MANDAU_85,
        xi.item.MANDAU_90,
        xi.item.MANDAU_95,
        xi.item.MANDAU_99,
        xi.item.MANDAU_99_II,
        xi.item.MANDAU_119,
        xi.item.MANDAU_119_II,
        xi.item.MANDAU_119_III,
    },

    [xi.equipment.relic.EXCALIBUR] =
    {
        xi.item.EXCALIBUR,
        xi.item.EXCALIBUR_80,
        xi.item.EXCALIBUR_85,
        xi.item.EXCALIBUR_90,
        xi.item.EXCALIBUR_95,
        xi.item.EXCALIBUR_99,
        xi.item.EXCALIBUR_99_II,
        xi.item.EXCALIBUR_119,
        xi.item.EXCALIBUR_119_II,
        xi.item.EXCALIBUR_119_III,
    },

    [xi.equipment.relic.RAGNAROK] =
    {
        xi.item.RAGNAROK,
        xi.item.RAGNAROK_80,
        xi.item.RAGNAROK_85,
        xi.item.RAGNAROK_90,
        xi.item.RAGNAROK_95,
        xi.item.RAGNAROK_99,
        xi.item.RAGNAROK_99_II,
        xi.item.RAGNAROK_119,
        xi.item.RAGNAROK_119_II,
        xi.item.RAGNAROK_119_III,
    },

    [xi.equipment.relic.GUTTLER] =
    {
        xi.item.GUTTLER,
        xi.item.GUTTLER_80,
        xi.item.GUTTLER_85,
        xi.item.GUTTLER_90,
        xi.item.GUTTLER_95,
        xi.item.GUTTLER_99,
        xi.item.GUTTLER_99_II,
        xi.item.GUTTLER_119,
        xi.item.GUTTLER_119_II,
        xi.item.GUTTLER_119_III,
    },

    [xi.equipment.relic.BRAVURA] =
    {
        xi.item.BRAVURA,
        xi.item.BRAVURA_80,
        xi.item.BRAVURA_85,
        xi.item.BRAVURA_90,
        xi.item.BRAVURA_95,
        xi.item.BRAVURA_99,
        xi.item.BRAVURA_99_II,
        xi.item.BRAVURA_119,
        xi.item.BRAVURA_119_II,
        xi.item.BRAVURA_119_III,
    },

    [xi.equipment.relic.APOCALYPSE] =
    {
        xi.item.APOCALYPSE,
        xi.item.APOCALYPSE_80,
        xi.item.APOCALYPSE_85,
        xi.item.APOCALYPSE_90,
        xi.item.APOCALYPSE_95,
        xi.item.APOCALYPSE_99,
        xi.item.APOCALYPSE_99_II,
        xi.item.APOCALYPSE_119,
        xi.item.APOCALYPSE_119_II,
        xi.item.APOCALYPSE_119_III,
    },

    [xi.equipment.relic.GUNGNIR] =
    {
        xi.item.GUNGNIR,
        xi.item.GUNGNIR_80,
        xi.item.GUNGNIR_85,
        xi.item.GUNGNIR_90,
        xi.item.GUNGNIR_95,
        xi.item.GUNGNIR_99,
        xi.item.GUNGNIR_99_II,
        xi.item.GUNGNIR_119,
        xi.item.GUNGNIR_119_II,
        xi.item.GUNGNIR_119_III,
    },

    [xi.equipment.relic.KIKOKU] =
    {
        xi.item.KIKOKU,
        xi.item.KIKOKU_80,
        xi.item.KIKOKU_85,
        xi.item.KIKOKU_90,
        xi.item.KIKOKU_95,
        xi.item.KIKOKU_99,
        xi.item.KIKOKU_99_II,
        xi.item.KIKOKU_119,
        xi.item.KIKOKU_119_II,
        xi.item.KIKOKU_119_III,
    },

    [xi.equipment.relic.AMANOMURAKUMO] =
    {
        xi.item.AMANOMURAKUMO,
        xi.item.AMANOMURAKUMO_80,
        xi.item.AMANOMURAKUMO_85,
        xi.item.AMANOMURAKUMO_90,
        xi.item.AMANOMURAKUMO_95,
        xi.item.AMANOMURAKUMO_99,
        xi.item.AMANOMURAKUMO_99_II,
        xi.item.AMANOMURAKUMO_119,
        xi.item.AMANOMURAKUMO_119_II,
        xi.item.AMANOMURAKUMO_119_III,
    },

    [xi.equipment.relic.MJOLLNIR] =
    {
        xi.item.MJOLLNIR,
        xi.item.MJOLLNIR_80,
        xi.item.MJOLLNIR_85,
        xi.item.MJOLLNIR_90,
        xi.item.MJOLLNIR_95,
        xi.item.MJOLLNIR_99,
        xi.item.MJOLLNIR_99_II,
        xi.item.MJOLLNIR_119,
        xi.item.MJOLLNIR_119_II,
        xi.item.MJOLLNIR_119_III,
    },

    [xi.equipment.relic.CLAUSTRUM] =
    {
        xi.item.CLAUSTRUM,
        xi.item.CLAUSTRUM_80,
        xi.item.CLAUSTRUM_85,
        xi.item.CLAUSTRUM_90,
        xi.item.CLAUSTRUM_95,
        xi.item.CLAUSTRUM_99,
        xi.item.CLAUSTRUM_99_II,
        xi.item.CLAUSTRUM_119,
        xi.item.CLAUSTRUM_119_II,
        xi.item.CLAUSTRUM_119_III,
    },

    [xi.equipment.relic.YOICHINOYUMI] =
    {
        xi.item.YOICHINOYUMI,
        xi.item.YOICHINOYUMI_80,
        xi.item.YOICHINOYUMI_85,
        xi.item.YOICHINOYUMI_90,
        xi.item.YOICHINOYUMI_95,
        xi.item.YOICHINOYUMI_99,
        xi.item.YOICHINOYUMI_99_II,
        xi.item.YOICHINOYUMI_119,
        xi.item.YOICHINOYUMI_119_II,
        xi.item.YOICHINOYUMI_119_III,
        xi.item.YOICHINOYUMI_119_III_NO_QUIVER,
    },

    [xi.equipment.relic.ANNIHILATOR] =
    {
        xi.item.ANNIHILATOR,
        xi.item.ANNIHILATOR_80,
        xi.item.ANNIHILATOR_85,
        xi.item.ANNIHILATOR_90,
        xi.item.ANNIHILATOR_95,
        xi.item.ANNIHILATOR_99,
        xi.item.ANNIHILATOR_99_II,
        xi.item.ANNIHILATOR_119,
        xi.item.ANNIHILATOR_119_II,
        xi.item.ANNIHILATOR_119_III,
        xi.item.ANNIHILATOR_119_III_NO_QUIVER,
    },

    [xi.equipment.relic.GJALLARHORN] =
    {
        xi.item.GJALLARHORN,
        xi.item.GJALLARHORN_80,
        xi.item.GJALLARHORN_85,
        xi.item.GJALLARHORN_90,
        xi.item.GJALLARHORN_95,
        xi.item.GJALLARHORN_99,
        xi.item.GJALLARHORN_99_II,
    },

    [xi.equipment.relic.AEGIS] =
    {
        xi.item.AEGIS,
        xi.item.AEGIS_80,
        xi.item.AEGIS_85,
        xi.item.AEGIS_90,
        xi.item.AEGIS_95,
        xi.item.AEGIS_99,
        xi.item.AEGIS_99_II,
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
    { xi.item.FIGHTERS_MASK,       xi.item.EVOKERS_HORN         }, -- Original Head
    { xi.item.HEALERS_CAP,         xi.item.CHORAL_ROUNDLET      },
    { xi.item.MYOCHIN_KABUTO,      xi.item.NINJA_HATSUBURI      },
    { xi.item.FIGHTERS_LORICA,     xi.item.EVOKERS_DOUBLET      }, -- Original Body
    { xi.item.MYOCHIN_DOMARU,      xi.item.NINJA_CHAINMAIL      },
    { xi.item.FIGHTERS_MUFFLERS,   xi.item.EVOKERS_BRACERS      }, -- Original Hand
    { xi.item.FIGHTERS_CALLIGAE,   xi.item.EVOKERS_PIGACHES     }, -- Original Feet
    { xi.item.FIGHTERS_CUISSES,    xi.item.EVOKERS_SPATS        }, -- Original Legs
    { xi.item.MAGUS_KEFFIYEH,      xi.item.PUPPETRY_TAJ         }, -- ToAU Head
    { xi.item.MAGUS_JUBBAH,        xi.item.PUPPETRY_TOBE        }, -- ToAU Body
    { xi.item.MAGUS_BAZUBANDS,     xi.item.PUPPETRY_DASTANAS    }, -- ToAU Hand
    { xi.item.MAGUS_CHARUQS,       xi.item.PUPPETRY_BABOUCHES   }, -- ToAU Feet
    { xi.item.MAGUS_SHALWAR,       xi.item.PUPPETRY_CHURIDARS   }, -- ToAU Legs
    { xi.item.DANCERS_TIARA_M,     xi.item.SCHOLARS_MORTARBOARD }, -- WotG Head
    { xi.item.DANCERS_CASAQUE_M,   xi.item.SCHOLARS_GOWN        }, -- WotG Body
    { xi.item.DANCERS_BANGLES_M,   xi.item.SCHOLARS_BRACERS     }, -- WotG Hand
    { xi.item.DANCERS_TOE_SHOES_M, xi.item.SCHOLARS_LOAFERS     }, -- WotG Feet
    { xi.item.DANCERS_TIGHTS_M,    xi.item.HOMAM_GAMBIERAS      }, -- WotG Legs "TODO / BUG?": SCHOLARS_PANTS = 16311
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
