-----------------------------------
-- Monstrosity
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-----------------------------------
-- Enums
-----------------------------------

xi.monstrosity.species =
{
    RABBIT    = 1,
    BEHEMOTH  = 2,
    TIGER     = 3,
    SHEEP     = 4,
    RAM       = 5,
    DHALMEL   = 6,
    COEURL    = 7,
    OPO_OPO   = 8,
    MANTICORE = 9,
    BUFFALO   = 10,
    MARID     = 11,
    CERBERUS  = 12,
    GNOLE     = 13,

    FUNGUAR        = 15,
    TREANT_SAPLING = 16,
    MORBOL         = 17,
    MANDRAGORA     = 18,
    SABOTENDER     = 19,
    FLYTRAP        = 20,
    GOOBBUE        = 21,
    RAFFLESIA      = 22,
    PANOPT         = 23,

    BEE          = 27,
    BEETLE       = 28,
    CRAWLER      = 29,
    FLY          = 30,
    SCORPION     = 31,
    SPIDER       = 32,
    ANTLION      = 33,
    DIREMITE     = 34,
    CHIGOE       = 35,
    WAMOURACAMPA = 36,
    LADYBUG      = 37,
    GNAT         = 38,

    LIZARD      = 43,
    RAPTOR      = 44,
    ADAMANTOISE = 45,
    BUGARD      = 46,
    EFT         = 47,
    WIVRE       = 48,
    PEISTE      = 49,

    SLIME    = 52,
    HECTEYES = 53,
    FLAN     = 54,
    SLUG     = 56,
    SANDWORM = 57,
    LEECH    = 58,

    CRAB     = 60,
    PUGIL    = 61,
    SEA_MONK = 62,
    URAGNITE = 63,
    OROBON   = 64,
    RUSZOR   = 65,
    TOAD     = 66,

    BIRD       = 69,
    COCKATRICE = 70,
    ROC        = 71,
    BAT        = 72,
    HIPPOGRYPH = 73,
    APKALLU    = 74,
    COLIBRI    = 75,
    AMPHIPTERE = 76,

    ASTOLTIAN_SLIME  = 126,
    EORZEAN_SPRIGGAN = 127,
}

xi.monstrosity.variants =
{
    -- Rabbit
    ONYX_RABBIT      = 0,
    ALABASTER_RABBIT = 1,
    LAPINION         = 2,

    -- Behemoth
    ELSAMOTH = 3,

    -- Tiger
    LEGENDARY_TIGER = 5,
    SMILODON        = 6,

    -- Sheep
    KARAKUL = 7,

    -- Coeurl
    LYNX = 10,
    COLLARED_LYNX = 11,

    -- Manticore
    LEGENDARY_MANTICORE = 12,

    -- Cerberus
    ORTHRUS = 13,

    -- Gnole
    BIPEDAL_GNOLE = 14,

    -- Funguar
    COPPERCAP = 15,

    -- Treant Sapling
    TREANT                = 16,
    FLOWERING_TREANT      = 17,
    SCARLET_TINGED_TREANT = 18,
    BARREN_TREANT         = 19,
    NECKLACED_TREANT      = 20,

    -- Morbol
    PYGMY_MORBOL = 21,
    SCARE_MORBOL = 22,
    AMERETAT     = 23,
    PURBOL       = 24,

    -- Mandragora
    KORRIGAN               = 25,
    LYCOPODIUM             = 26,
    PYGMY_MANDRAGORA       = 27,
    ADENIUM                = 28,
    PACHYPODIUM            = 29,
    ENLIGHTENED_MANDRAGORA = 30,
    NEW_YEAR_MANDRAGORA    = 31,

    -- Sabotender
    SABOTENDER_FLORIDO = 32,

    -- Rafflesia
    MITRASTEMA = 33,

    -- Bee
    VERMILLION_AND_ONYX_BEE = 34,
    ZAFFRE_BEE              = 35,

    -- Beetle
    ONYX_BEETLE    = 36,
    GAMBOGE_BEETLE = 37,

    -- Crawler
    ERUCA                 = 38,
    EMERALD_CRAWLER       = 39,
    PYGMY_EMERALD_CRAWLER = 40,

    -- Fly
    VERMILLION_FLY = 41,

    -- Scorpion
    SCOLOPENDRID         = 42,
    UNUSUAL_SCOLOPENDRID = 43,

    -- Spider
    RETICULATED_SPIDER         = 44,
    VERMILLION_AND_ONYX_SPIDER = 45,

    -- Antlion
    ONYX_ANTLION = 46,
    FORMICEROS   = 47,

    -- Diremite
    ARUNDIMITE = 48,

    -- Chigoe
    AZURE_CHIGOE = 49,

    -- Wamouracampa
    COILED_WAMOURACAMPA = 50,

    -- Wamoura
    WAMOURA       = 51,
    CORAL_WAMOURA = 52,

    -- Ladybug
    GOLD_LADYBUG = 53,

    -- Gnat
    MIDGE = 54,

    -- Lizard
    ASHEN_LIZARD = 59,

    -- Raptor
    EMERALD_RAPTOR    = 60,
    VERMILLION_RAPTOR = 61,

    -- Adamantoise
    PYGMY_ADAMANTOISE     = 62,
    LEGENDARY_ADAMANTOISE = 63,
    FERROMANTOISE         = 64,

    -- Bugard
    ABYSSOBUGARD = 65,

    -- Eft
    TARICHUK = 66,

    -- Wivre
    UNUSUAL_WIVRE = 67,

    -- Peiste
    SIBILUS = 68,

    -- Slime
    CLOT       = 73,
    GOLD_SLIME = 74,
    BOIL       = 75,

    -- Flan
    GOLD_FLAN  = 76,
    BLANCMANGE = 77,

    -- Sandworm
    PYGMY_SANDWORM = 78,
    GIGAWORM       = 79,

    -- Leech
    AZURE_LEECH = 80,
    OBDELLA     = 81,

    -- Crab
    VERMILLION_CRAB                 = 84,
    BASKET_BURDENED_CRAB            = 85,
    VERMILLION_BASKET_BURDENED_CRAB = 86,
    PORTER_CRAB                     = 87,

    -- Pugil
    JAGIL = 88,

    -- Sea Monk
    AZURE_SEA_MONK = 89,

    -- Uragnite
    LIMASCABRA = 90,

    -- Orobon
    PYGMY_OROBON = 91,
    OGREBON      = 92,

    -- Toad
    AZURE_TOAD      = 93,
    VERMILLION_TOAD = 94,

    -- Bird
    ONYX_BIRD = 95,

    -- Cockatrice
    ZIZ = 96,

    -- Roc
    LEGENDARY_ROC = 97,
    GAGANA        = 98,

    -- Bat
    BATS            = 99,
    VERMILLION_BAT  = 100,
    VERMILLION_BATS = 101,

    -- Apkallu
    INGUZA = 102,

    -- Colibri
    TOUCALIBRI = 103,

    -- Amphiptere
    SANGUIPTERE = 104,

    -- Slime
    SHE_SLIME   = 252,
    METAL_SLIME = 253,

    -- Spriggan
    SPRIGGAN_C = 254,
    SPRIGGAN_G = 255,
}

xi.monstrosity.purchasableInstincts =
{
    -- Default (0x1F)
    HUME_I   = 0,
    ELVAAN_I = 1,
    TARU_I   = 2,
    MITHRA_I = 3,
    GALKA_I  = 4,

    HUME_II   = 5,
    ELVAAN_II = 6,
    TARU_II   = 7,
    MITHRA_II = 8,
    GALKA_II  = 9,

    WAR = 10,
    MNK = 11,
    WHM = 12,
    BLM = 13,
    RDM = 14,
    THF = 15,
    PLD = 16,
    DRK = 17,
    BST = 18,
    BRD = 19,
    RNG = 20,
    SAM = 21,
    NIN = 22,
    DRG = 23,
    SMN = 24,
    BLU = 25,
    COR = 26,
    PUP = 27,
    DNC = 28,
    SCH = 29,
    GEO = 30,
    RUN = 31,
}

-----------------------------------
-- Helpers
-----------------------------------

xi.monstrosity.unlockStartingMONs = function(player, choice)
    local data =
    {
        monstrosityId = choice,
        species       = choice,
    }

    player:setMonstrosity(data)
end

-----------------------------------
-- Debug
-----------------------------------

xi.monstrosity.unlockAll = function(player)
    local data =
    {
        -- 1 byte per entry, mapped out to species table
        -- (0 - 127)
        levels =
        {
        },

        -- Bitfield (0 - 63)
        instincts =
        {
        },

        -- Bitfield (0 - 31)
        variants =
        {
        },
    }

    -- Set all levels to 99
    for _, val in pairs(xi.monstrosity.species) do
        data.levels[val] = 99
    end

    -- Instincts by MON level
    -- NOTE: Since this is a bitfield, it's zero-indexed!
    for _, val in pairs(xi.monstrosity.species) do
        local speciesKey   = val
        local speciesLevel = data.levels[val]
        local byteOffset   = math.floor(speciesKey / 4)
        local unlockAmount = math.floor(speciesLevel / 30)
        local shiftAmount  = (speciesKey * 2) % 8

        -- Special case for writing Slime & Spriggan data at the end of the 64-byte array
        if byteOffset == 31 then
            byteOffset = 63
        end

        if byteOffset < 64 then
            data.instincts[byteOffset] = bit.bor(data.instincts[byteOffset] or 0, bit.lshift(unlockAmount, shiftAmount))
        else
            print("byteOffset out of range")
        end
    end

    -- Instincts (Purchasable)
    for _, val in pairs(xi.monstrosity.purchasableInstincts) do
        local byteOffset   = 20 + math.floor(val / 8)
        local shiftAmount  = val % 8

        -- print(val, byteOffset, shiftAmount)

        if byteOffset >= 20 and byteOffset < 24 then
            data.instincts[byteOffset] = bit.bor(data.instincts[byteOffset] or 0, bit.lshift(0x01, shiftAmount))
        else
            print("byteOffset out of range")
        end
    end

    -- Variants
    -- Force unlock all
    for _, val in pairs(xi.monstrosity.variants) do
        local speciesKey   = val
        local byteOffset   = math.floor(speciesKey / 8)
        local shiftAmount  = speciesKey % 8

        -- print(speciesKey, byteOffset, shiftAmount)

        if byteOffset < 32 then
            data.variants[byteOffset] = bit.bor(data.variants[byteOffset] or 0, bit.lshift(0x01, shiftAmount))
        else
            print("byteOffset out of range")
        end
    end

    player:setMonstrosity(data);
end

-----------------------------------
-- Odyssean Passage
-----------------------------------

xi.monstrosity.odysseanPassageOnTrade = function(player, npc, trade)
end

xi.monstrosity.odysseanPassageOnTrigger = function(player, npc)
    -- TODO: Handle xi.settings.main.ENABLE_MONSTROSITY

    -- TODO: If passage in the overworld, do logic X
    local isMonstrosityUnlocked = player:hasKeyItem(xi.keyItem.RING_OF_SUPERNAL_DISJUNCTION)
    if isMonstrosityUnlocked then
        player:startEvent(883)
    end

    -- TODO: If passage in Feretory, do logic Y
    -- In Feretory: Event 5 (0, 0, 0, 0, 0, 0, 0, 0)
end

xi.monstrosity.odysseanPassageOnEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
    player:updateEvent(0, 0, 0, 0, 1, 0, 0, 0)
end

xi.monstrosity.odysseanPassageOnEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    -- Option 1: Leave & Teleport to last city zone
    -- Option 529: Teleport to Al'Taieu
end

-----------------------------------
-- Feretory
-----------------------------------

xi.monstrosity.feretoryOnZoneIn = function(player, prevZone)
    -- TODO: Handle xi.settings.main.ENABLE_MONSTROSITY

    -- TODO: Rabbit, Mandy, and Lizard are all unlocked to begin with, but you
    --     : start as whatever matching item you traded

    local cs = -1

    player:setPos(-358.000, -3.400, -440.00, 63)

    return cs
end

xi.monstrosity.feretoryOnEventUpdate = function(player, csid, option, npc)
end

xi.monstrosity.feretoryOnEventFinish = function(player, csid, option, npc)
end

-----------------------------------
-- Aengus (Feretory NPC)
-----------------------------------

xi.monstrosity.aengusOnTrade = function(player, npc, trade)
end

xi.monstrosity.aengusOnTrigger = function(player, npc)
    -- Event 13 (As Lizard: 0, 0, 2, 0, 2, 90, 0, 0)
    player:startEvent(13, 0, 0, 2, 0, 2, 90, 0, 0)
end

xi.monstrosity.aengusOnEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
end

xi.monstrosity.aengusOnEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    if csid == 13 and option == 1 then
        -- Selected: Enter Belligerency
    end
end

-----------------------------------
-- Teyrnon (Feretory NPC)
-----------------------------------

xi.monstrosity.teyrnonOnTrade = function(player, npc, trade)
end

xi.monstrosity.teyrnonOnTrigger = function(player, npc)
    player:startEvent(7, 0, 0, 0, 0, 0, 0, 0, 0)
end

xi.monstrosity.teyrnonOnEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
    if csid == 7 and option == 0 then -- Monsters Menu
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    elseif csid == 7 and option == 1 then -- Instinct menu
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end
end

xi.monstrosity.teyrnonOnEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    -- Support Menu:
    -- option    3: Dedication 1
    -- option  259: Dedication 2
    -- option  515: Regen
    -- option  771: Refresh
    -- option 1027: Protect
    -- option 1283: Shell
    -- option 1539: Haste
end

-----------------------------------
-- Maccus (Feretory NPC)
-----------------------------------

xi.monstrosity.maccusOnTrade = function(player, npc, trade)
end

xi.monstrosity.maccusOnTrigger = function(player, npc)
    player:startEvent(9, 285, 2, 2, 0, 0, 0, 0, 0)
end

xi.monstrosity.maccusOnEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
end

xi.monstrosity.maccusOnEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
end

-----------------------------------
-- Suibhne (Feretory NPC)
-----------------------------------

xi.monstrosity.suibhneOnTrade = function(player, npc, trade)
end

xi.monstrosity.suibhneOnTrigger = function(player, npc)
    player:startEvent(11, 1, 1, 0, 0, 0, 0, 0, 0)
end

xi.monstrosity.suibhneOnEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
end

xi.monstrosity.suibhneOnEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    -- Answers:
    -- 1) 4. Teyrnon
    -- 2) 3. Suibhne
    -- 3) 1. Aengus
    if csid == 11 and option == 2 then
        -- Quiz failed
    elseif csid == 11 and option == 6029313 then
        -- Quiz succeeded
        -- TODO: Unlock Bee (MON)
    end
end
