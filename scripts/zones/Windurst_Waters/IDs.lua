-----------------------------------
-- Area: Windurst_Waters
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.WINDURST_WATERS] =
{
    text =
    {
        CONQUEST_BASE              = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED    = 6541, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED              = 6547, -- Obtained: <item>.
        GIL_OBTAINED               = 6548, -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6550, -- Obtained key item: <keyitem>.
        KEYITEM_LOST               = 6551, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL        = 6552, -- You do not have enough gil.
        NOTHING_OUT_OF_ORDINARY    = 6561, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS        = 6586, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY    = 6587, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER               = 6588, -- In celebration of your most recent login no. <number>...
        HOMEPOINT_SET              = 6638, -- Home point set!
        YOU_ACCEPT_THE_MISSION     = 6731, -- You have accepted the mission.
        MOG_LOCKER_OFFSET          = 6812, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        FISHING_MESSAGE_OFFSET     = 7051, -- You can't fish here.
        COOKING_SUPPORT            = 7155, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT   = 7169, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT         = 7177, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE        = 7184, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                = 7189, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP         = 7190, -- You do not have enough guild points.
        KOPOPO_SHOP_DIALOG         = 7845, -- Cooking is as much an art as music and painting are. Can your taste buds appreciate the full value of our works of art?
        CHOMOJINJAHL_SHOP_DIALOG   = 7850, -- The qualities needed to be a good cook are strong arms, a sense of taste, and devotion.
        ENSASA_SHOP_DIALOG         = 8917, -- Welcome to my little catalyst shop, where you'll find a range of general and unusual goods!
        UPIHKHACHLA_SHOP_DIALOG    = 8918, -- For adventurerrrs on the go, Ensasa's Catalyst Shop is the place for all you need in generrral goods!
        SHOHRUNTUHRUN_SHOP_DIALOG  = 8920, -- Oh, hidey-widey! This is the Federal Magic Reservey-wervey. What can I do for you today-oway?
        HIKOMUMAKIMU_SHOP_DIALOG   = 8921, -- Welcome to the Federal Magic Reserve, the only place in the Federation where high-level magic is allowed to be sold.
        OREZEBREZ_SHOP_DIALOG      = 8922, -- Welcome to Baren-Moren's, makers of the finest headwear. Our slogan is: The smarter the hat, the smarter the head.
        TAAJIJI_SHOP_DIALOG        = 8924, -- May I take your order, please...
        MAQUMOLPIH_OPEN_DIALOG     = 8925, -- Psst... Check out these things my suppliers in Aragoneu dug up.
        MAQUMOLPIH_CLOSED_DIALOG   = 8926, -- Sorrrry, but I'm waiting on my next shipment from Aragoneu, so I'm all out of things to sell you at the moment.
        BAEHUFAEHU_OPEN_DIALOG     = 8927, -- Can I interest you in some of Sarutabaruta's wares? Come on, have a look, and see how I fares!
        BAEHUFAEHU_CLOSED_DIALOG   = 8928, -- Sorry-dorry, but I'm taking a breaky-wakey! (Or, as you'll be knowing,  since control of Sarutabaruta was lost, I'm out of stock, so go on, get going!)
        AHYEEKIH_OPEN_DIALOG       = 8929, -- Psst... Wanna buy somethin' cheap from Kolshushu?
        AHYEEKIH_CLOSED_DIALOG     = 8930, -- Hee-hee-hee... Can you hang on a while? I can start selling you good stuff from Kolshushu once I'm ready.
        FOMINA_OPEN_DIALOG         = 8931, -- Hello, adventurer! Can I interest you in something a little different--something from Elshimo?
        FOMINA_CLOSED_DIALOG       = 8932, -- Well, um, let me see... This should be a good spot to open shop. There are some wealthy-looking Tarutaru houses nearby. It's quiet and yet there're plenty of passers-by...
        OTETE_OPEN_DIALOG          = 8933, -- He-he-he... Hey! How's about... Items from Li'Telor that you can't do without? Reckon you could do, with one of these or two?
        OTETE_CLOSED_DIALOG        = 8934, -- Oh... Phew... My heart is so blue... Bluer than these flowers... Leave me be for a couple hours...
        JOURILLE_OPEN_DIALOG       = 8935, -- Greetings.  Can I interest you in some of these goods from Ronfaure...?
        JOURILLE_CLOSED_DIALOG     = 8936, -- Greetings! I am Jourille, your friendly neighborhood traveling merchant. I would most like to sell you something from Ronfaure right now, but I regret that I am waiting on my next shipment. Please call by later!
        YOU_SHOW_OFF_THE           = 9112, -- You show off the <item>.
        CONQUEST                   = 9222, -- You've earned conquest points!
        TRICK_OR_TREAT             = 10171, -- Trick or treat...
        THANK_YOU_TREAT            = 10172, -- Thank you... And now for your treat...
        HERE_TAKE_THIS             = 10173, -- Here, take this...
        IF_YOU_WEAR_THIS           = 10174, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                  = 10175, -- Thank you...
        PRESTAPIQ_CLOSED_DIALOG    = 10665, -- Goodebyongo! Wingdorsht tooo fhar awayz fhrum mai hormtowne! Dropt arll goodhys whylle ahn trripp!
        PRESTAPIQ_OPEN_DIALOG      = 10666, -- Helgohelgo! Me's bhrink goodhys arll ja wayz fhrum hormtowne ovf Morvalporlis!
        NESSRUGETOMALL_SHOP_DIALOG = 11470, -- Welcome to the Rarab Tail Hostelry.
        DIABOLOS_UNLOCKED          = 11899, -- You are now able to summon Diabolos!
    },
    mob =
    {
    },
    npc =
    {
        HALLOWEEN_SKINS = {
            [17752097] = 61, -- Ensasa
            [17752098] = 60, -- Upih Khachla
            [17752101] = 59, -- Ness Rugetomal
            [17752102] = 63, -- Maqu Molpih
            [17752103] = 62, -- Ahyeekih
        },
        LELEROON_GREEN_DOOR = 17752333,
    },
}

return zones[tpz.zone.WINDURST_WATERS]
