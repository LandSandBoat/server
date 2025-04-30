-----------------------------------
-- Area: Hazhalm_Testing_Grounds
-----------------------------------
zones = zones or {}

zones[xi.zone.HAZHALM_TESTING_GROUNDS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        OBTAINS_TEMP_ITEM             = 7066, -- Obtained temporary item: <item>.
        GATE_FIRMLY_CLOSED            = 7227, -- The gate is firmly closed...
        PARTY_MEMBERS_HAVE_FALLEN     = 7612, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7619, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ALREADY_POSSESS_TEMP          = 7995, -- You already have that temporary item.
        STAGNANT_AURA_CLEARED         = 7996, -- The chamber's stagnant aura has somewhat cleared...
        CREATURES_CALMED              = 7997, -- The creatures lurking in the shadows have calmed...
        CREATURES_RESTLESS            = 7998, -- The creatures lurking in the shadows have become restless...
        DENDAINSONNE_ANGRY            = 8003, -- Dendainsonne looks angry...
        DENDAINSONNE_ENRAGED          = 8004, -- Dendainsonne is enraged!
        DENDAINSONNE_OUT_OF_CONTROL   = 8005, -- Dendainsonne is out of control!
        DENDAINSONNE_MOCKING_YOU      = 8006, -- Dendainsonne appears to be mocking you...
        OTHERWORLDLY_VOICE            = 8043, -- An otherworldly voice echoes faintly from the depths of your skull...
        PROVE_THY_WORTH               = 8044, -- ...who would...prove...thy...worth... Deliver...unto me...and speak...my name...
        FEATHERS_CONSUMED             = 8054, -- All of the valkyrie feathers in your possession are consumed!
        ENTRY_PROHIBITED              = 8055, -- Entry to the chambers is prohibited for # more Vana'dielian [day/days].
        MIN_LEVEL_ENTRY               = 8056, -- Adventurers who have yet to reach level <number> will not be permitted entry to the training grounds.
        RESERVATION_LOCKOUT           = 8057, -- Chamber reservation is prohibited for # more Vana'dielian [day/days].
        MIN_LEVEL_RESERVATION         = 8058, -- Adventurers who have yet to reach level <number> will not be permitted to make reservations within the training grounds.
        COULD_NOT_GATHER_DATA         = 8060, -- Could not gather the sufficient data.
        CHAMBER_OCCUPIED              = 8062, -- Currently, another expedition is occupying [/Rossweisse's Chamber/Grimgerde's Chamber/Siegrune's Chamber/Helmwige's Chamber/Schwertleite's Chamber/Waltraute's Chamber/Ortlinde's Chamber/Gerhilde's Chamber/Brunhilde's Chamber/Odin's Chamber/Odin's Chamber].
        GLOWING_LAMP_OBTAINED         = 8063, -- Time and destination have been recorded on your <item>.
        MISSING_FEATHERS              = 8064, -- You do not possess the items required for entry.
        REQUIREMENTS_UNMET            = 8065, -- You do not meet the requirements for entry.
        LAMP_POWER_FADED              = 8066, -- he power of the % has faded. You may no longer occupy this chamber.
        TOO_MANY_ADVENTURERS          = 8068, -- There are too many adventurers in the chamber.
        TIMEOUT_WARNING               = 8069, -- ---== Warning! ==---- Your reservation of this chamber will end in # [minute/minutes].
        TIMEOUT_WARNING_SECONDS       = 8070, -- ---== Warning! ==---- Your reservation of this chamber will end in # [second/seconds].
        EXPEDITION_INCAPACITATED_WARN = 8071, -- All expedition members have been incapacitated. Commencing emergency teleportation in # [minute/minutes].
        EXPEDITION_INCAPACITATED      = 8072, -- All expedition members have been incapacitated. Commencing emergency teleportation.
        CHAMBER_CLEARED               = 8075, -- [Rossweisse's Chamber/Grimgerde's Chamber/Siegrune's Chamber/Helmwige's Chamber/Schwertleite's Chamber/Waltraute's Chamber/Ortlinde's Chamber/Gerhilde's Chamber/Brunhilde's Chamber/Odin's Chamber/Odin's Chamber] has been cleared. Commencing teleportation in # [minute/minutes].
        MEMBERS_ENGAGED_IN_BATTLE     = 8076, -- Other members currently engaged in battle. Entry denied.
        AMPOULES_OBTAINED             = 8077, -- You obtain <number> ampoule[/s] of viscous therion ichor.
        GROUP_LEADER_NOT_YET_ENTERED  = 8078, -- The group leader has not yet entered the chamber. Entry denied.
        CLAIM_RELINQUISH              = 8080, -- Note that your claim over the area through your <item> will be relinquished if over <number> more minute[/s] pass from this point with no one inside.
    },
    mob =
    {
        -- Einherjar: Wing 1: Mobs
        BUGARD_X            = GetTableOfIDs('Bugard-X'),
        CHIGOE              = GetTableOfIDs('Chigoe'),
        CRAVEN_EINHERJAR    = GetTableOfIDs('Craven_Einherjar'),
        DARK_ELEMENTAL      = GetTableOfIDs('Dark_Elemental'),
        EINHERJAR_EATER     = GetTableOfIDs('Einherjar_Eater'),
        HAZHALM_BAT         = GetTableOfIDs('Hazhalm_Bat'),
        HAZHALM_BATS        = GetTableOfIDs('Hazhalm_Bats'),
        HYNDLA              = GetTableOfIDs('Hyndla'),
        INFECTED_WAMOURA    = GetTableOfIDs('Infected_Wamoura'),
        LOGI_GROW           = GetTableOfIDs('Logi_grow'), -- 6x growing Bombs
        LOGI                = GetTableOfIDs('Logi'),      -- 6x non-growing Bombs
        NICKUR              = GetTableOfIDs('Nickur'),
        ROTTING_HUSKARL_WAR = GetTableOfIDs('Rotting_Huskarl_war'),
        ROTTING_HUSKARL_BLM = GetTableOfIDs('Rotting_Huskarl_blm'),
        SJOKRAKJEN          = GetTableOfIDs('Sjokrakjen'),
        DJIGGA_HILDESVINI   = GetTableOfIDs('Djigga_Hildesvini'), -- Adds for Hildesvini

        -- Einherjar: Wing 1: Bosses
        HAKENMANN      = GetFirstID('Hakenmann'),
        HILDESVINI     = GetFirstID('Hildesvini'),
        HIMINRJOT      = GetFirstID('Himinrjot'),
        HRAESVELG      = GetFirstID('Hraesvelg'),
        MORBOL_EMPEROR = GetFirstID('Morbol_Emperor'),
        NIHHUS         = GetFirstID('Nihhus'),

        -- Einherjar: Wing 2: Mobs
        BATTLEMITE             = GetTableOfIDs('Battlemite'),
        CORRUPT_EINHERJAR      = GetTableOfIDs('Corrupt_Einherjar'),
        CRAVEN_EINHERJAR_BHOOT = GetTableOfIDs('Craven_Einherjar_bhoot'),
        EINHERJAR_BREI         = GetTableOfIDs('Einherjar_Brei'),
        FLAMES_OF_MUSPELHEIM   = GetTableOfIDs('Flames_of_Muspelheim'),
        GARDSVOR               = GetTableOfIDs('Gardsvor'),
        HAZHALM_LEECH          = GetTableOfIDs('Hazhalm_Leech'),
        ODINS_FOOL             = GetTableOfIDs('Odins_Fool'),
        ROTTING_HUSKARL_DRK    = GetTableOfIDs('Rotting_Huskarl_drk'), -- Intertwined with THF
        ROTTING_HUSKARL_THF    = GetTableOfIDs('Rotting_Huskarl_thf'), -- Intertwined with DRK
        UTGARTH_BAT            = GetTableOfIDs('Utgarth_Bat'),
        UTGARTH_BATS           = GetTableOfIDs('Utgarth_Bats'),
        UTGARTH_LEECH          = GetTableOfIDs('Utgarth_Leech'),
        WALDGEIST              = GetTableOfIDs('Waldgeist'),
        WINEBIBBER             = GetTableOfIDs('Winebibber'),

        -- Einherjar: Wing 2: Bosses
        ANDHRIMNIR      = GetFirstID('Andhrimnir'),
        ARIRI_SAMARIRI  = GetFirstID('Ariri_Samariri'),
        BALRAHN         = GetFirstID('Balrahn'),
        HRUNGNIR        = GetTableOfIDs('Hrungnir')[1],
        HRUNGNIR_CLONE  = GetTableOfIDs('Hrungnir')[2],
        MOKKURALFI      = GetFirstID('Mokkuralfi'),
        TANNGRISNIR     = GetFirstID('Tanngrisnir'),

        -- Einherjar: Wing 3: Mobs
        AUDHUMBLA                = GetTableOfIDs('Audhumbla'),
        BERSERKR_WAR             = GetTableOfIDs('Berserkr_war'), -- Intertwined with BLM/DRK
        BERSERKR_BLM             = GetTableOfIDs('Berserkr_blm'), -- Intertwined with WAR/DRK
        BERSERKR_DRK             = GetTableOfIDs('Berserkr_drk'), -- Intertwined with WAR/BLM
        DJIGGA                   = GetTableOfIDs('Djigga'),
        EXPERIMENTAL_POROGGO     = GetTableOfIDs('Experimental_Poroggo'),
        HAFGYGR                  = GetTableOfIDs('Hafgygr'),
        IDUN                     = GetTableOfIDs('Idun'),
        LIQUIFIED_EINHERJAR      = GetTableOfIDs('Liquified_Einherjar'),
        MARGYGR                  = GetTableOfIDs('Margygr'),
        MARID_X                  = GetTableOfIDs('Marid-X'),
        MANTICORE_X              = GetTableOfIDs('Manticore-X'),
        ODINS_JESTER             = GetTableOfIDs('Odins_Jester'),
        ORMR                     = GetTableOfIDs('Ormr'),
        SOULFLAYER               = GetTableOfIDs('Soulflayer'),
        VAMPYR_DOG               = GetTableOfIDs('Vampyr_Dog'),
        VANQUISHED_EINHERJAR_BLM = GetTableOfIDs('Vanquished_Einherjar_blm'), -- Intertwined with THF/DRK
        VANQUISHED_EINHERJAR_THF = GetTableOfIDs('Vanquished_Einherjar_thf'), -- Intertwined with BLM/DRK
        VANQUISHED_EINHERJAR_DRK = GetTableOfIDs('Vanquished_Einherjar_drk'), -- Intertwined with BLM/THF
        WIVRE_X                  = GetTableOfIDs('Wivre-X'),
        HERVARTH                 = GetFirstID('Hervarth'),            -- Motsognir add
        HJORVARTH                = GetFirstID('Hjorvarth'),           -- Motsognir add
        HRANI                    = GetFirstID('Hrani'),               -- Motsognir add
        ANGANTYR                 = GetFirstID('Angantyr'),            -- Motsognir add
        BUI                      = GetFirstID('Bui'),                 -- Motsognir add
        BRAMI                    = GetFirstID('Brami'),               -- Motsognir add
        BARRI                    = GetFirstID('Barri'),               -- Motsognir add
        REIFNIR                  = GetFirstID('Reifnir'),             -- Motsognir add
        TIND                     = GetFirstID('Tind'),                -- Motsognir add
        TYRFING                  = GetFirstID('Tyrfing'),             -- Motsognir add
        HADDING_THE_ELDER        = GetFirstID('Hadding_the_Elder'),   -- Motsognir add
        HADDING_THE_YOUNGER      = GetFirstID('Hadding_the_Younger'), -- Motsognir add
        VAMPYR_BATS              = GetTableOfIDs('Vampyr_Bats'),      -- Vampyr Jarl adds
        VAMPYR_WOLF              = GetTableOfIDs('Vampyr_Wolf'),      -- Vampyr Jarl adds

        -- Einherjar: Wing 3: Bosses
        DENDAINSONNE = GetFirstID('Dendainsonne'),
        FREKE        = GetFirstID('Freke'),
        GORGIMERA    = GetFirstID('Gorgimera'),
        MOTSOGNIR    = GetFirstID('Motsognir'),
        STOORWORM    = GetFirstID('Stoorworm'),
        VAMPYR_JARL  = GetFirstID('Vampyr_Jarl'),

        -- Einherjar: Odin's Chamber
        ODIN         = GetFirstID('Odin'),
        BRUNHILDE    = GetFirstID('Brunhilde'),
        SIEGRUNE     = GetFirstID('Siegrune'),
        ROSSWEISSE   = GetFirstID('Rossweisse'),
        GERHILDE     = GetFirstID('Gerhilde'),
        SCHWERTLEITE = GetFirstID('Schwertleite'),
        HELMWIGE     = GetFirstID('Helmwige'),
        ORTLINDE     = GetFirstID('Ortlinde'),
        GRIMGERDE    = GetFirstID('Grimgerde'),
        WALTRAUTE    = GetFirstID('Waltraute'),

        -- Einherjar: Special Mobs - 9 copies of each
        HUGINN     = GetTableOfIDs('Huginn'),
        MUNINN     = GetTableOfIDs('Muninn'),
        HEITHRUN   = GetTableOfIDs('Heithrun'),
        SAEHRIMNIR = GetTableOfIDs('Saehrimnir'),
    },
    npc =
    {
        -- Einherjar: Armoury Crates (Rewards chests x9, Temporary items chests x9)
        ARMOURY_CRATE = GetTableOfIDs('Armoury_Crate'),
    },
}

return zones[xi.zone.HAZHALM_TESTING_GROUNDS]
