-----------------------------------
-- Abyssea Lights Global
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.abyssea = xi.abyssea or {}

-- if the amount is 100 or 50 it is a special number and is randomised as per retail
local lightInfo =
{
    [xi.zone.ABYSSEA_KONSCHTAT] =
    {
        ["Ab_xzomit"]              = { azure = 8,   pearl = 5,   ruby = 16,  amber = 8  }, -- Xzomits
        ["Cryptonberry_Occultist"] = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Tonberries
        ["Dapifer_Imp"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Imps
        ["Deep_Eye"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Ahrimans
        ["Dybbuk"]                 = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Corpselights
        ["Ephemeral_Clionid"]      = { azure = 100, pearl = 5,   ruby = 16,  amber = 16 }, -- Clionidaes
        ["Ephemeral_Limule"]       = { azure = 16,  pearl = 5,   ruby = 100, amber = 0  }, -- Limules
        ["Gneiss_Leech"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Leech's
        ["Gunge_Slug"]             = { azure = 8,   pearl = 5,   ruby = 16,  amber = 8  }, -- Slugs
        ["Hoary_Ragwort"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Goobbues
        ["Highland_Rafflesia"]     = { azure = 8,   pearl = 5,   ruby = 16,  amber = 8  }, -- Rafflesia
        ["Highland_Treant"]        = { azure = 8,   pearl = 5,   ruby = 8,   amber = 16 }, -- Treants
        ["Ley_Clionid"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Treants
        ["Licorice"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 16 }, -- Flans
        ["Mesa_Wivre"]             = { azure = 16,  pearl = 5,   ruby = 8,   amber = 8  }, -- Wivre
        ["Morboling"]              = { azure = 16,  pearl = 5,   ruby = 8,   amber = 8  }, -- Morbols
        ["Qaitu"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 8  }, -- Ghosts
        ["Razorback"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Efts
        ["Shadow_Funguar"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Funguars
        ["Shadow_Lizard"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Lizards
        ["Sods_Limule"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Limules
        ["Tonberry_Bedeviler"]     = { azure = 16,  pearl = 5,   ruby = 8,   amber = 16 }, -- Tonberries
        ["Trotting_Sapling"]       = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Saplings
        ["Viridis_Wyvern"]         = { azure = 8,   pearl = 5,   ruby = 16,  amber = 16 }, -- Wyverns
        ["Ypotryll"]               = { azure = 8,   pearl = 5,   ruby = 16,  amber = 16 }, -- Bugards

        -- NM's
        ["Alkonost"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Arimaspi"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Ashtaerh_the_Gallvexed"] = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  }, -- yes its spelled wrong
        ["Bakka"]                  = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Balaur"]                 = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Bloodeye_Vileberry"]     = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Bloodguzzler"]           = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Bombadeel"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Clingy_Clare"]           = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Eccentric_Eve"]          = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Fistule"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Fear_Gorta"]             = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Gangly_Gean"]            = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Guimauve"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Hexenpilz"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Keratyrannos"]           = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Khalamari"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Kukulkan"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Lentor"]                 = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Pavan"]                  = { azure = 8,   pearl = 5,   ruby = 16,  amber = 100 }, -- Avatars
        ["Raskovnik"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Sarcophilus"]            = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Siranpa-Kamuy"]          = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Tonberry_Lieje"]         = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Turul"]                  = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },

        -- VWNM
        ["Meanderer"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Depths_Digester"]        = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Hadal_Satiator"]         = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
    },

    [xi.zone.ABYSSEA_LA_THEINE] =
    {
        ["Angler_Tiger"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Tigers
        ["Bathyal_Gigas"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Gigas
        ["Black_Merino"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Sheep
        ["Brae_Opo_Opo"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Opo-opo
        ["Cankercap"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Funguars
        ["Crapaudy"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Poroggos
        ["Crepuscule_Puk"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Puks
        ["Demersal_Gigas"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Gigas
        ["Ephemeral_Clionid"]      = { azure = 100, pearl = 5,   ruby = 16,  amber = 16 }, -- Clionidae
        ["Ephemeral_Limule"]       = { azure = 16,  pearl = 5,   ruby = 100, amber = 8  }, -- Limule  The amount of ruby light received is random and correlated with EXP received.
        ["Farfadet"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Pixies
        ["Geier"]                  = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Birds
        ["Gigadaphnia"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Limule
        ["Great_Wasp"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Bees
        ["Hadal_Gigas"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Gigas
        ["Hammering_Ram"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Rams
        ["Irate_Sheep"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Sheep  Low percent drop rate on Pearlescent light.
        ["Luison"]                 = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Gnoles   Low percent drop rate on Pearlescent light.
        ["Plateau_Glider"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Flies
        ["Plateau_Hare"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Rabbits
        ["Poroggo_Seducteur"]      = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Poroggos
        ["Psychopomp"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Corpselights
        ["Rock_Grinder"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Worms
        ["Sentinel_Crab"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Crabs
        ["Veld_Clionid"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Clionidae

        -- NM's
        ["Akash"]                  = { azure = 50,  pearl = 5,   ruby = 16,  amber = 100 }, -- Avatars
        ["Adamastor"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Baba_Yaga"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Briareus"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Carabosse"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Chasmic_Hornet"]         = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Dozing_Dorian"]          = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Grandgousier"]           = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Hadhayosh"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Irrlicht"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Karkinos"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Keesha_Poppo"]           = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["La_Theine_Liege"]        = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Lugarhoo"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Mangy-tailed_Marvin"]    = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Megamaw_Mikey"]          = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Megantereon"]            = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Nahn"]                   = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Ovni"]                   = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Nguruvilu"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Pantagruel"]             = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Piasa"]                  = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Poroggo_Dom_Juan"]       = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Toppling_Tuber"]         = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Trudging_Thomas"]        = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },

        -- VWNM
        ["Meditator"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Brooder"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Ruminator"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
    },

    [xi.zone.ABYSSEA_TAHRONGI] =
    {
        ["Beholder"]               = { azure = 8,   pearl = 5,   ruby = 0,   amber = 0  }, -- Hecteyes
        ["Canyon_Eft"]             = { azure = 8,   pearl = 5,   ruby = 0,   amber = 0  }, -- Eft
        ["Canyon_Scorpion"]        = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Scorpion
        ["Blood_Bat"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Giant Bats
        ["Bog_Body"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Qutrub
        ["Caoineag"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Corpselights
        ["Cluckatrice"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Cockatrice     100% Azure
        ["Hieracosphinx"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Manticores
        ["Jaguarundi"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Coeurls
        ["Lamenter"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Weepers
        ["Naul"]                   = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Wyrms
        ["Nematocera"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Gnats
        ["Pachypodium"]            = { azure = 8,   pearl = 5,   ruby = 0,   amber = 0  }, -- Mandragora    100% Azure
        ["Thalassinon"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Adamantoises
        ["Vermes_Carnium"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Sandworm
        ["Wiederganger"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Corse
        ["Gully_Clionid"]          = { azure = 8,   pearl = 5,   ruby = 0,   amber = 0  }, -- Clionidae     100% Azure
        ["Gulch_Limule"]           = { azure = 8,   pearl = 5,   ruby = 0,   amber = 0  }, -- Limule
        ["Ephemeral_Clionid"]      = { azure = 100, pearl = 5,   ruby = 16,  amber = 16 }, -- Clionidae
        ["Ephemeral_Limule"]       = { azure = 16,  pearl = 5,   ruby = 100, amber = 16 }, -- Limule
        ["Sturdy_Pyxis"]           = { azure = 8,   pearl = 5,   ruby = 0,   amber = 0  }, -- Mimic

        -- NM's
        ["Bhumi"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 100 }, -- Avatars
        ["Abas"]                   = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Adze"]                   = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Alectryon"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Cannered_Noz"]           = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Chloris"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Chukwa"]                 = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Cuelebre"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Gancanagh"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Glavoid"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Hedetet"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Halimede"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Iratham"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Lachrymater"]            = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Lacovie"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Manananggal"]            = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Mictlantecuhtli"]        = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Minhocao"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Muscaliet"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Myrmecoleon"]            = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Ophanim"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Quetzalli"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Rubicund_Adenium"]       = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Tefenet"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Treble_Noctules"]        = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },
        ["Vetehinen"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16  },

        -- VWNM
        ["Hungerer"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Yearner"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Usurper"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
    },

    [xi.zone.ABYSSEA_MISAREAUX] =
    {
        ["Abyssobugard"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 16 }, -- Bugards
        ["Atrociraptor"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Raptors
        ["Ancient_Orobon"]         = { azure = 0,   pearl = 5,   ruby = 16,  amber = 8  }, -- Orobon
        ["Squib"]                  = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Poroggos
        ["Coastal_Colibri"]        = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Colibri
        ["Frigatebird"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Birds
        ["Slasher"]                = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Crabs
        ["Overking_Apkallu"]       = { azure = 0,   pearl = 5,   ruby = 0,   amber = 16 }, -- Apkallu
        ["Buzzfly"]                = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Flies
        ["Gasher"]                 = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Crabs
        ["Maritime_Peiste"]        = { azure = 16,  pearl = 5,   ruby = 8,   amber = 8  }, -- Peistes
        ["Escarp_Murex"]           = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Murex
        ["Ephemeral_Murex"]        = { azure = 100, pearl = 5,   ruby = 16,  amber = 16 }, -- Murex
        ["Protoamoeban"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Amoebans
        ["Ephemeral_Amoeban"]      = { azure = 16,  pearl = 5,   ruby = 50,  amber = 16 }, -- Amoebans
        ["Orapodium"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Mandragora
        ["Gore_Bats"]              = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Bat Trios
        ["Observer"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Spheroids
        ["Dynamo_Cluster"]         = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Clusters
        ["Boartrap"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Flytraps
        ["Limestone_Hare"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Rabbits
        ["Shore_Spider"]           = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Spiders
        ["Dusk_Lizard"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Lizards

        -- NM's
        ["Abyssic_Cluster"]        = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Amhuluk"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Asanbosam"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Athamas"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Avalerion"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Cep-Kamuy"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Cirein-croin"]           = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Flame_Skimmer"]          = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Funereal_Apkallu"]       = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Gukumatz"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Heqet"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Ironclad_Observer"]      = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Ironclad_Pulverizer"]    = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Ironclad_Severer"]       = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Jala"]                   = { azure = 16,  pearl = 5,   ruby = 16,  amber = 128 }, -- Avatars
        ["Karkatakam"]             = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Manohra"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Minax_Bugard"]           = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Nehebkau"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Nonno"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Npfundlwa"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Sirrush"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Sobek"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },
        ["Tuskertrap"]             = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16  },

        -- VWNM
        ["Mi'ghrah"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Mx'ghrah"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Tristitia"]              = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
    },

    [xi.zone.ABYSSEA_VUNKERL] =
    {
        ["Aestutaur"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Tauri
        ["Blademaw_Pugil"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Fish
        ["Clammy_Imp"]             = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Imps
        ["Coccinelle"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Ladybugs
        ["Devegetator"]            = { azure = 0,   pearl = 5,   ruby = 8,   amber = 0  }, -- Crawlers
        ["Gruesome_Gargouille"]    = { azure = 0,   pearl = 5,   ruby = 8,   amber = 0  }, -- Gargouilles
        ["Helter-skelter"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Djinn
        ["Jasconius"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Sea Monks
        ["Peapuk"]                 = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Puks
        ["Pneumaflayer"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Soulflayers
        ["Russet_Rarab"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Rabbits
        ["Shewriwhile"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Corpselights
        ["Slough_Bats"]            = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Bat Trios
        ["Speltercap"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Funguars
        ["Spitting_Spider"]        = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Spiders
        ["Wily_Opo-opo"]           = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Opo-opo
        ["Slaughterous_Smilodon"]  = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Tiger
        ["Morose_Marid"]           = { azure = 0,   pearl = 5,   ruby = 8,   amber = 0  }, -- Marids
        ["River_Murex"]            = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Murex
        ["Ephemeral_Murex"]        = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Murex
        ["Stream_Amoeban"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Amoebans
        ["Ephemeral_Amoeban"]      = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Amoebans

        -- NM's
        ["Armillaria"]             = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ayravata"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Bukhis"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Chhir_Batti"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Div-e Sepid"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Durinn"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Dvalinn"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Fulmotondro"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Avatars
        ["Gnawtooth_Gary"]         = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Hanuman"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Hrosshvalur"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Iktomi"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Iku-Turso"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ironclad_Executioner"]   = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Kadraeth_the_Hatespawn"] = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Karkadann"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Khalkotaur"]             = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Lord_Varney"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Pascerpot"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Quasimodo"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Rakshas"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Seps"]                   = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Sedna"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Sippoy"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Xan"]                    = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },

        -- VWNM
        ["Vu'zdei"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Hm'Zdei"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Ketea"]                  = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
    },

    [xi.zone.ABYSSEA_ATTOHWA] =
    {
        ["Amuckatrice"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Cockatrice  100% Azure
        ["Gullycampa"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Wamouracampa
        ["Hannequet"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Mandragora
        ["Chasm_Coeurl"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Coeurls
        ["Ignis_Eruca"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Crawlers
        ["Entozoon"]               = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Worms
        ["Murrain_Chigoe"]         = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Chigoes
        ["Inugami"]                = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Hounds
        ["Rift_Treant"]            = { azure = 0,   pearl = 5,   ruby = 0,   amber = 16 }, -- Treants
        ["Defile_Scorpion"]        = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Scorpions
        ["Terminus_Eft"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Efts
        ["Schnitter"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Skeletons
        ["Rift_Dragon"]            = { azure = 8,   pearl = 5,   ruby = 16,  amber = 0  }, -- Dragons
        ["Decayed_Flesh"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Doomed
        ["Treacle_Slug"]           = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Slugs
        ["Rock_Murex"]             = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Murex
        ["Ephemeral_Murex"]        = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Murex
        ["Crevice_Amoeban"]        = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Amoebans
        ["Ephemeral_Amoeban"]      = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Amoebans
        ["Myriadeyes"]             = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Hecteyes
        ["Spuk"]                   = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Ghosts

        -- NM's
        ["Aggressor_Antlion"]      = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Amun"]                   = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Berstuk"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Blazing_Eruca"]          = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Drekavac"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Gaizkin"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Gieremund"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Granite_Borer"]          = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ironclad_Cleaver"]       = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Itzpapalotl"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Kampe"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Kharon"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Maahes"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Mielikki"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Nightshade"]             = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Pallid_Percy"]           = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Smok"]                   = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Svarbhanu"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Tejas"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Titlacauan"]             = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Tunga"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ulhuadshi"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Warbler"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Wherwetrice"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Whiro"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Yaanei"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },

        -- VWNM
        ["At'euvhi"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Es'euvhi"]               = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Lusca"]                  = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
    },

    [xi.zone.ABYSSEA_GRAUBERG] =
    {
        ["Baelfyr"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Elementals
        ["Byrgen"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Elementals
        ["Deimobugard"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Bugards
        ["Faunus Wyvern"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Wyverns
        ["Gefyrst"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Elementals
        ["Glade_Wivre"]            = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Wivre
        ["Glen_Crab"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Crabs
        ["Goblin_Meatgrinder"]     = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Goblins
        ["Goblin_Plunderer"]       = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Goblins
        ["Hillock_Murex"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Murex
        ["Knoll_Clionid"]          = { azure = 100, pearl = 5,   ruby = 8,   amber = 16 }, -- Clionidae
        ["Monitor"]                = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Spheroids
        ["Peak_Pugil"]             = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Pugils
        ["Pond_Amoeban"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Amoebans
        ["Putrid_Peapuk"]          = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Puks
        ["Seelie"]                 = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Pixies
        ["Sensenmann"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Skeletons
        ["Sinister_Seidel"]        = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Magic Pots
        ["Stream_Limule"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Limule
        ["Stygian_Djinn"]          = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Djinn
        ["Ungeweder"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 }, -- Elementals
        ["Unseelie"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Pixies

        -- NM's
        ["Alfard"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Amphitrite"]             = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Assailer_Chariot"]       = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Azdaja"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Bomblix_Flamefinger"]    = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Burstrox_Powderpate"]    = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Deelgeed"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Fleshflayer_Killakriq"]  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Fuath"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ika-Roa"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ironclad_Sunderer"]      = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Jaculus"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Lorelei"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Melo Melo"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Minaruja"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ningishzida"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Raja"]                   = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Rencounter_Chariot"]     = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Teekesselchen"]          = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Teugghia"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Xibalba"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
    },

    [xi.zone.ABYSSEA_ULEGUERAND] =
    {
        ["Adasaurus"]              = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Raptors
        ["Benumbed_Vodoriga"]      = { azure = 0,   pearl = 5,   ruby = 8,   amber = 8  }, -- Gargouilles
        ["Bluffalo"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Buffalo
        ["Ectozoon"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Worms
        ["Ermit_Imp"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Imps
        ["Floe_Amoeban"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Amoebans
        ["Hoarmite"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Diremites
        ["Iceberg_Murex"]          = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Murex
        ["Mechanical_Menace"]      = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Acrolith
        ["Olyphant"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Marids
        ["Sierra_Tiger"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Tigers
        ["Snowflake"]              = { azure = 8,   pearl = 5,   ruby = 0,   amber = 8  }, -- Snolls
        ["Spectator"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 0  }, -- Spheroids
        ["Sub-Zero_Gear"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Gears
        ["Svelldrake"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Wyverns
        ["Verglas_Golem"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Golems

        -- NM's
        ["Anemic_Aloysius"]        = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Audumbla"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Apademak"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Awahondo"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Blanga"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Chillwing_Hwitti"]       = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Dhorme_Khimaira"]        = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Empousa"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Impervious_Chariot"]     = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Indrik"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ironclad_Triturator"]    = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Isgebind"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Koghatu"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Kur"]                    = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Pantokrator"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Refitted_Chariot"]       = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Resheph"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Sisyphus"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Upas-Kamuy"]             = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Veri_Selen"]             = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Yaguarogui"]             = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },

        -- VWNM
        ["Ice_Elemental"]          = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Water_Elemental"]        = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Chione"]                 = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Ogopogo"]                = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
    },

    [xi.zone.ABYSSEA_ALTEPA] =
    {
        ["Akrab"]                  = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Scorpions
        ["Arid_Limule"]            = { azure = 16,  pearl = 5,   ruby = 100, amber = 8  }, -- Limule
        ["Barrens_Treant"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Treants
        ["Bonfire"]                = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Bombs
        ["Camelopardalis"]         = { azure = 5,   pearl = 5,   ruby = 8,   amber = 8  }, -- Dhalmel  Azure is 100%.
        ["Desert_Clionid"]         = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Clionidae
        ["Desert_Puk"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Puks
        ["Dune_Cockatrice"]        = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Cockatrice
        ["Dune_Manticore"]         = { azure = 5,   pearl = 5,   ruby = 8,   amber = 8  }, -- Manticores
        ["Ergdrake"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Wyverns
        ["Fear_Dearg"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Mandragora
        ["Gastornis"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Rocs
        ["Manigordo"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Tigers
        ["Nannakola"]              = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Ladybugs
        ["Oasis_Amoeban"]          = { azure = 5,   pearl = 5,   ruby = 8,   amber = 8  }, -- Amoebans
        ["Sand_Murex"]             = { azure = 8,   pearl = 0,   ruby = 8,   amber = 8  }, -- Murex
        ["Sand_Sweeper"]           = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Dolls
        ["Surveyor"]               = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Spheroids
        ["Badlands_Crab"]          = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Crabs
        ["Sand_Pugil"]             = { azure = 8,   pearl = 5,   ruby = 8,   amber = 8  }, -- Pugils

        -- NM's
        ["Amarok"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ansherekh"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Battlerigged_Chariot"]   = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Bennu"]                  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Bugul_Noz"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Chickcharney"]           = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Cuijatender"]            = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Dragua"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Emperador_de_Altepa"]    = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Hazhdiha"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Hedjedjet"]              = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ironclad_Smiter"]        = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Long-Barreled_Chariot"]  = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Orthrus"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Ouzelum"]                = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Rani"]                   = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Sharabha"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Shaula"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Tablilla"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Vadleany"]               = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },
        ["Waugyl"]                 = { azure = 16,  pearl = 5,   ruby = 16,  amber = 16 },

        -- VWNM
        ["Earth_Elemental"]        = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Fire_Elemental"]         = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Koios"]                  = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
        ["Brulo"]                  = { azure = 16,  pearl = 16,  ruby = 16,  amber = 16 },
    },
}

local lightTypes =
{
    [xi.abyssea.deathType.PHYSICAL]    = { light = xi.abyssea.lightType.PEARL, lightType = "pearl" }, -- pearl
    [xi.abyssea.deathType.MAGICAL]     = { light = xi.abyssea.lightType.AZURE, lightType = "azure" }, -- Azure
    [xi.abyssea.deathType.WS_PHYSICAL] = { light = xi.abyssea.lightType.RUBY,  lightType = "ruby"  }, -- Ruby
    [xi.abyssea.deathType.WS_MAGICAL]  = { light = xi.abyssea.lightType.AMBER, lightType = "amber" }, -- Amber
}

xi.abyssea.RemoveDeathListeners = function(mob)
    mob:removeListener("ABYSSEA_PHYSICAL_DEATH_CHECK")
    mob:removeListener("ABYSSEA_MAGIC_DEATH_CHECK")
    mob:removeListener("ABYSSEA_DEATH_LIGHTS_CHECK")
end

xi.abyssea.AddDeathListeners = function(mob)
    mob:addListener("MAGIC_TAKE", "ABYSSEA_MAGIC_DEATH_CHECK", function(target, caster, spell)
        if
            target:getHP() <= 0 and
            target:getDeathType() == xi.abyssea.deathType.NONE
        then
            target:setDeathType(xi.abyssea.deathType.MAGICAL)
        end
    end)

    mob:addListener("WEAPONSKILL_TAKE", "ABYSSEA_WS_DEATH_CHECK", function(target, user, wsid)
        -- TODO: Make this human-readable, and break out from the listener
        local magicalWS =
        {
            19, 20, 30, 33, 34, 36, 37, 47, 50, 51, 58, 74, 76, 97, 98, 107, 113, 114, 130,
            131, 132, 133, 139, 146, 147, 148, 149, 160, 161, 172, 177, 178, 179, 180,
            186, 187, 188, 189, 192, 208, 217, 218, 220,
        }

        local wsType = xi.abyssea.deathType.WS_PHYSICAL

        if
            target:getHP() <= 0 and
            target:getDeathType() == xi.abyssea.deathType.NONE
        then
            for i = 1, #magicalWS do
                if wsid == magicalWS[i] then
                    wsType = xi.abyssea.deathType.WS_MAGICAL
                    break
                end
            end

            target:setDeathType(wsType)
        end
    end)

    mob:addListener("DEATH", "ABYSSEA_DEATH_LIGHTS_CHECK", function(mobArg, player)
        local deathType = mobArg:getDeathType()
        if deathType == xi.abyssea.deathType.NONE then
            deathType = xi.abyssea.deathType.PHYSICAL
        end

        xi.abyssea.DropLights(player, mobArg:getName(), deathType, mobArg)

        xi.abyssea.RemoveDeathListeners(mobArg)
    end)
end

xi.abyssea.DropLights = function(killer, mobName, killType, mob)
    if killer then
        if not killer:isPC() and killer:getAllegiance() == 1 then
            local master = killer:getMaster()
            if master then
                killer = master
            end
        end
    else
        return
    end

    local zoneID = killer:getZoneID()
    if lightInfo[zoneID][mobName] == nil then
        return
    end

    local dropLight = 0
    local amount    = 0
    local dropRate  = xi.settings.main.ABYSSEA_LIGHTS_DROP_RATE

    if lightInfo[zoneID][mobName][lightTypes[killType].lightType] ~= nil then
        amount = lightInfo[zoneID][mobName][lightTypes[killType].lightType]
    end

    if amount == 0 then
        return
    elseif amount == 100 then
        if math.random(1, 100) <= 20 then
            amount = 16 * math.random(1, 4)
        else
            amount = 16 * math.random(1, 2)
        end
    elseif amount == 50 then
        amount = 16 * math.random(1, 2)
    end

    dropLight = lightTypes[killType].light

    if dropLight == xi.abyssea.lightType.PEARL then
        if
            mobName == "Ab_xzomit" or
            mobName == "Gneiss_Leech" or
            mobName == "Highland_Treant" or
            mobName == "Irate_Sheep" or
            mobName == "Luison"
        then
            if xi.settings.main.ABYSSEA_LIGHTS_DROP_RATE > 0 then
                dropRate = 2
            end
        else
            if xi.settings.main.ABYSSEA_LIGHTS_DROP_RATE > 10 then
                dropRate = math.floor(xi.settings.main.ABYSSEA_LIGHTS_DROP_RATE / 2)
            end
        end
    end

    if dropLight == xi.abyssea.lightType.AZURE then
        if
            mobName == "Cluckatrice" or
            mobName == "Pachypodium" or
            mobName == "Gully_Clionid" or
            mobName == "Amuckatrice" or
            mobName == "Camelopardalis"
        then
            if xi.settings.main.ABYSSEA_LIGHTS_DROP_RATE > 0 then
                dropRate = 100
            end
        end
    end

    local canDrop = math.random(1, 100)

    if canDrop <= dropRate then
        for _, member in pairs(killer:getAlliance()) do
            if member:getZoneID() == killer:getZoneID() and member:isPC() then
                xi.abyssea.addPlayerLights(member, dropLight, amount)
            end
        end
    end
end
