-----------------------------------
-- Area: Dynamis-Xarcabard
-----------------------------------
zones = zones or {}

zones[xi.zone.DYNAMIS_XARCABARD] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7066, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN            = 7225, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND           = 7226, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1         = 7227, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2         = 7228, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED          = 7230, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE              = 7242, -- You feel an ominous presence, as if something might happen if you possessed <item>.
        ANIMATED_KNUCKLES_DIALOG      = 7309, -- I am known as the Fists of Mystics. Come, show me your fighting spirit.
        ANIMATED_DAGGER_DIALOG        = 7341, -- I am called the Ornate Blade. Now, show me your strength.
        ANIMATED_LONGSWORD_DIALOG     = 7373, -- People have named me the Holy Blade. I will try thy resolution.
        ANIMATED_CLAYMORE_DIALOG      = 7405, -- I am the Intricate Blade. Show me the depths of your fury!
        ANIMATED_TABAR_DIALOG         = 7437, -- Me, axe. Runaeic, Axe. You, die?
        ANIMATED_GREATAXE_DIALOG      = 7469, -- I have been given the title of Seraphic Axe. Will you attempt to survive my love?
        ANIMATED_SPEAR_DIALOG         = 7501, -- I am the Stellar Spear. It is time to test your courage.
        ANIMATED_SCYTHE_DIALOG        = 7533, -- I am known as the Tenebrous Scythe. Overwhelm me with your greed for power.
        ANIMATED_KUNAI_DIALOG         = 7565, -- I am called the Demoniac Blade. Allow me to witness your technique.
        ANIMATED_TACHI_DIALOG         = 7597, -- I am the Divine Blade. I demand a test of your will.
        ANIMATED_HAMMER_DIALOG        = 7629, -- People have named me the Heavenly Hammer. I will test your might to its very limits.
        ANIMATED_STAFF_DIALOG         = 7661, -- I am called the Celestial Staff. I will glimpse into your mind's eye...
        ANIMATED_LONGBOW_DIALOG       = 7693, -- I am known as the Snarled Bow. I will measure the limits of your determination.
        ANIMATED_GUN_DIALOG           = 7725, -- I am known as the Ethereal Rifle. Do you realize my incredible value?
        ANIMATED_HORN_DIALOG          = 7757, -- I am called the Mysterial Horn. Show me your true intentions.
        ANIMATED_SHIELD_DIALOG        = 7789, -- I am Aegis, the impervious shield of everlasting.
        PRISON_OF_SOULS_HAS_SET_FREE  = 7821, -- e prison of souls has set free its captive spirits!
    },
    mob =
    {
        TIME_EXTENSION =
        {
            { minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = 17330531 },
            { minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 17330532 },
            { minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 17330533 },
            { minutes = 10, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 17330534 },
            { minutes = 20, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = 17330535 },
        },

        REFILL_STATUE =
        {
            {
                { mob = 17330230, eye = xi.dynamis.eye.RED   }, -- Adamantking_Effigy
                { mob = 17330231, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 17330240, eye = xi.dynamis.eye.RED  }, -- Adamantking_Effigy
                { mob = 17330241, eye = xi.dynamis.eye.BLUE },
            },

            {
                { mob = 17330248, eye = xi.dynamis.eye.RED   }, -- Serjeant_Tombstone
                { mob = 17330249, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 17330256, eye = xi.dynamis.eye.RED  }, -- Serjeant_Tombstone
                { mob = 17330257, eye = xi.dynamis.eye.BLUE },
            },

            {
                { mob = 17330273, eye = xi.dynamis.eye.RED   }, -- Avatar_Icon
                { mob = 17330274, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 17330285, eye = xi.dynamis.eye.RED  }, -- Avatar_Icon
                { mob = 17330286, eye = xi.dynamis.eye.BLUE },
            },

            {
                { mob = 17330471, eye = xi.dynamis.eye.RED   }, -- Goblin_Replica
                { mob = 17330472, eye = xi.dynamis.eye.GREEN },
            },

            {
                { mob = 17330483, eye = xi.dynamis.eye.RED  }, -- Goblin_Replica
                { mob = 17330484, eye = xi.dynamis.eye.BLUE },
            },
        },

        DYNAMIS_LORD         = 17330177,
        YING                 = 17330183,
        YANG                 = 17330184,
        COUNT_ZAEBOS_PH      = { [17330376] = 17330377 }, -- Kindred_Warrior
        DUKE_GOMORY_PH       = { [17330303] = 17330304 }, -- Kindred_Monk
        PRINCE_SEERE_PH      = { [17330331] = 17330332 }, -- Kindred_White_Mage
        MARQUIS_ORIAS_PH     = { [17330333] = 17330343 }, -- Kindred_Black_Mage
        DUKE_BERITH_PH       = { [17330352] = 17330353 }, -- Kindred_Red_Mage
        COUNT_RAUM_PH        = { [17330314] = 17330315 }, -- Kindred_Thief
        MARQUIS_SABNAK_PH    = { [17330359] = 17330360 }, -- Kindred_Paladin
        DUKE_SCOX_PH         = { [17330427] = 17330417 }, -- Kindred_Dark_Knight
        MARQUIS_ANDRAS_PH    = { [17330388] = 17330390 }, -- Kindred_Beastmaster
        MARQUIS_DECARABIA_PH = { [17330222] = 17330223 }, -- Kindred_Bard
        MARQUIS_CIMERIES_PH  = { [17330414] = 17330415 }, -- Kindred_Ranger
        COUNT_VINE_PH        = { [17330439] = 17330440 }, -- Kindred_Samurai
        MARQUIS_GAMYGYN_PH   = { [17330450] = 17330451 }, -- Kindred_Ninja
        KING_ZAGAN_PH        = { [17330418] = 17330430 }, -- Kindred_Dragoon
        MARQUIS_NEBIROS_PH   = { [17330479] = 17330481 }, -- Kindred_Summoner
    },
    npc =
    {
        QM =
        {
            [17330780] =
            {
                param = { 3358, 3429, 3430, 3431, 3432, 3433 },
                trade =
                {
                    { item = 3358,                             mob = 17330177 }, -- Dynamis Lord
                    { item = { 3429, 3430, 3431, 3432, 3433 }, mob = 17330191 }, -- Arch Dynamis Lord
                }
            },

            [17330781] = { trade = { { item = 3400, mob = 17330185 } } }, -- Duke Haures
            [17330782] = { trade = { { item = 3401, mob = 17330186 } } }, -- Marquis Caim
            [17330783] = { trade = { { item = 3402, mob = 17330188 } } }, -- Baron Avnas
            [17330784] = { trade = { { item = 3403, mob = 17330189 } } }, -- Count Haagenti
            [17330785] = { trade = { { item = 3364, mob = 17330199 } } }, -- Animated Knuckles
            [17330786] = { trade = { { item = 3365, mob = 17330200 } } }, -- Animated Dagger
            [17330787] = { trade = { { item = 3366, mob = 17330201 } } }, -- Animated Longsword
            [17330788] = { trade = { { item = 3367, mob = 17330202 } } }, -- Animated Claymore
            [17330789] = { trade = { { item = 3368, mob = 17330203 } } }, -- Animated Tabar
            [17330790] = { trade = { { item = 3369, mob = 17330204 } } }, -- Animated Great Axe
            [17330791] = { trade = { { item = 3371, mob = 17330205 } } }, -- Animated Spear
            [17330792] = { trade = { { item = 3370, mob = 17330206 } } }, -- Animated Scythe
            [17330793] = { trade = { { item = 3372, mob = 17330207 } } }, -- Animated Kunai
            [17330794] = { trade = { { item = 3373, mob = 17330208 } } }, -- Animated Tachi
            [17330795] = { trade = { { item = 3374, mob = 17330209 } } }, -- Animated Hammer
            [17330796] = { trade = { { item = 3375, mob = 17330210 } } }, -- Animated Staff
            [17330797] = { trade = { { item = 3376, mob = 17330211 } } }, -- Animated Longbow
            [17330798] = { trade = { { item = 3377, mob = 17330212 } } }, -- Animated Gun
            [17330799] = { trade = { { item = 3378, mob = 17330213 } } }, -- Animated Horn
            [17330800] = { trade = { { item = 3379, mob = 17330214 } } }, -- Animated Shield
        },
    },
}

return zones[xi.zone.DYNAMIS_XARCABARD]
