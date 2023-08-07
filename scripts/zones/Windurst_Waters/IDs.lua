-----------------------------------
-- Area: Windurst_Waters
-----------------------------------
zones = zones or {}

zones[xi.zone.WINDURST_WATERS] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6550,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6553,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6554,  -- You do not have enough gil.
        NOTHING_OUT_OF_ORDINARY       = 6563,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 6588,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6589,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6590,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6610,  -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                 = 6649,  -- Home point set!
        YOU_ACCEPT_THE_MISSION        = 6742,  -- You have accepted the mission.
        MOG_LOCKER_OFFSET             = 6823,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        MAP_MARKER_TUTORIAL           = 7071,  -- The map will open when you select Map from the main menu. Choose Markers and scroll to the right to check the location.
        FISHING_MESSAGE_OFFSET        = 7076,  -- You can't fish here.
        COOKING_SUPPORT               = 7180,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT      = 7194,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT            = 7202,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE           = 7209,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                   = 7214,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP            = 7215,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN            = 7231,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        KOPOPO_SHOP_DIALOG            = 7870,  -- Cooking is as much an art as music and painting are. Can your taste buds appreciate the full value of our works of art?
        CHOMOJINJAHL_SHOP_DIALOG      = 7875,  -- The qualities needed to be a good cook are strong arms, a sense of taste, and devotion.
        ENSASA_SHOP_DIALOG            = 8942,  -- Welcome to my little catalyst shop, where you'll find a range of general and unusual goods!
        UPIHKHACHLA_SHOP_DIALOG       = 8943,  -- For adventurerrrs on the go, Ensasa's Catalyst Shop is the place for all you need in generrral goods!
        SHOHRUNTUHRUN_SHOP_DIALOG     = 8945,  -- Oh, hidey-widey! This is the Federal Magic Reservey-wervey. What can I do for you today-oway?
        HIKOMUMAKIMU_SHOP_DIALOG      = 8946,  -- Welcome to the Federal Magic Reserve, the only place in the Federation where high-level magic is allowed to be sold.
        OREZEBREZ_SHOP_DIALOG         = 8947,  -- Welcome to Baren-Moren's, makers of the finest headwear. Our slogan is: The smarter the hat, the smarter the head.
        TAAJIJI_SHOP_DIALOG           = 8949,  -- May I take your order, please...
        MAQUMOLPIH_OPEN_DIALOG        = 8950,  -- Psst... Check out these things my suppliers in Aragoneu dug up.
        MAQUMOLPIH_CLOSED_DIALOG      = 8951,  -- Sorrrry, but I'm waiting on my next shipment from Aragoneu, so I'm all out of things to sell you at the moment.
        BAEHUFAEHU_OPEN_DIALOG        = 8952,  -- Can I interest you in some of Sarutabaruta's wares? Come on, have a look, and see how I fares!
        BAEHUFAEHU_CLOSED_DIALOG      = 8953,  -- Sorry-dorry, but I'm taking a breaky-wakey! (Or, as you'll be knowing,  since control of Sarutabaruta was lost, I'm out of stock, so go on, get going!)
        AHYEEKIH_OPEN_DIALOG          = 8954,  -- Psst... Wanna buy somethin' cheap from Kolshushu?
        AHYEEKIH_CLOSED_DIALOG        = 8955,  -- Hee-hee-hee... Can you hang on a while? I can start selling you good stuff from Kolshushu once I'm ready.
        FOMINA_OPEN_DIALOG            = 8956,  -- Hello, adventurer! Can I interest you in something a little different--something from Elshimo?
        FOMINA_CLOSED_DIALOG          = 8957,  -- Well, um, let me see... This should be a good spot to open shop. There are some wealthy-looking Tarutaru houses nearby. It's quiet and yet there're plenty of passers-by...
        OTETE_OPEN_DIALOG             = 8958,  -- He-he-he... Hey! How's about... Items from Li'Telor that you can't do without? Reckon you could do, with one of these or two?
        OTETE_CLOSED_DIALOG           = 8959,  -- Oh... Phew... My heart is so blue... Bluer than these flowers... Leave me be for a couple hours...
        JOURILLE_OPEN_DIALOG          = 8960,  -- Greetings.  Can I interest you in some of these goods from Ronfaure...?
        JOURILLE_CLOSED_DIALOG        = 8961,  -- Greetings! I am Jourille, your friendly neighborhood traveling merchant. I would most like to sell you something from Ronfaure right now, but I regret that I am waiting on my next shipment. Please call by later!
        YOU_SHOW_OFF_THE              = 9137,  -- You show off the <item>.
        CONQUEST                      = 9247,  -- You've earned conquest points!
        TRICK_OR_TREAT                = 10196, -- Trick or treat...
        THANK_YOU_TREAT               = 10197, -- Thank you... And now for your treat...
        HERE_TAKE_THIS                = 10198, -- Here, take this...
        IF_YOU_WEAR_THIS              = 10199, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                     = 10200, -- Thank you...
        EGG_HUNT_OFFSET               = 10207, -- Egg-cellent! Here's your prize, kupo! Now if only somebody would bring me a super combo... Oh, egg-scuse me! Forget I said that, kupo!
        PRESTAPIQ_CLOSED_DIALOG       = 10690, -- Goodebyongo! Wingdorsht tooo fhar awayz fhrum mai hormtowne! Dropt arll goodhys whylle ahn trripp!
        PRESTAPIQ_OPEN_DIALOG         = 10691, -- Helgohelgo! Me's bhrink goodhys arll ja wayz fhrum hormtowne ovf Morvalporlis!
        NESSRUGETOMALL_SHOP_DIALOG    = 11495, -- Welcome to the Rarab Tail Hostelry.
        DIABOLOS_UNLOCKED             = 11924, -- You are now able to summon Diabolos!
    },

    mob =
    {
    },

    npc =
    {
        HALLOWEEN_SKINS =
        {
            [17752097] = 61, -- Ensasa
            [17752098] = 60, -- Upih Khachla
            [17752101] = 59, -- Ness Rugetomal
            [17752102] = 63, -- Maqu Molpih
            [17752103] = 62, -- Ahyeekih
        },

        LELEROON_GREEN_DOOR = 17752333,
    },
}

return zones[xi.zone.WINDURST_WATERS]
