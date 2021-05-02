-----------------------------------
-- Area: Port_Windurst
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PORT_WINDURST] =
{
    text =
    {
        REGIME_CANCELED                 = 14, -- Current training regime canceled.
        HUNT_ACCEPTED                   = 32, -- Hunt accepted!
        USE_SCYLDS                      = 33, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                   = 44, -- You record your hunt.
        OBTAIN_SCYLDS                   = 46, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                   = 50, -- Hunt canceled.
        MELEK_DIALOG_B                  = 3250, -- Take that sword to Giddeus. Good luck.
        GOLD_SKULL_DIALOG               = 3251, -- Welcome back. Your mission went without incident, I trust?
        MELEK_DIALOG_C                  = 3256, -- I hope to see you safe and well again someday. Take care, <name>.
        MELEK_DIALOG_A                  = 3278, -- Well, good luck with your mission. I look forward to hearing of your success.
        BABUBU_SHOP_DIALOG              = 3605, -- This be the Fishermen's Guild shop. What supplies will you be needin' today?
        ULIPEHKOWA_SHOP_DIALOG          = 4130, -- Step rrright up! Step rrright up! This is yourrr last chance to shop in Windurst! Get yourrr souvenirs or forrrgotten shopping done here!
        KUSUSU_SHOP_DIALOG              = 4133, -- Welcome to Kususu's Hoodoos! We have low-level to medium-level magic on sale to help you through the early, rough spells in your life.
        ARORO_SHOP_DIALOG               = 4134, -- Buy some hocus-pocus from us at Kususu's Hoodoos! I'll give you a smiley charm from me, Aroro, for free! C'mon... How about it then?
        HOHBIBAMUBIBA_SHOP_DIALOG       = 4135, -- Hohbiba-Mubiba! Just because, at first glance, we Tarutaru look weak, doesn't mean you should make light of our weapons.
        TANIKOMANIKO_SHOP_DIALOG        = 4137, -- Hohbiba-Mubiba! That's how our weapon shop greets its customers! Hohbiba-Mubiba!
        GURUNAMAGURUNA_SHOP_DIALOG      = 4139, -- There's a time to attack and a time to defend... And speaking defensively, why not get some armor or fine clothes here?
        KUMAMA_SHOP_DIALOG              = 4140, -- At Guruna-Maguruna's, we tailor to your needs!
        POSSORUHBINI_OPEN_DIALOG        = 4141, -- Rrroll up! Rrroll up! Plenty of goods from Norvallen! The morrre you buy, the happierrr you'll make me!
        POSSORUHBINI_CLOSED_DIALOG      = 4142, -- The sea brrreeze is so refrrreshing! At least this'll keep me happy until I rrreceive my next shipment of goods from Norvallen! I think I'm in heaven!
        SHEIAPOHRICHAMAHA_OPEN_DIALOG   = 4143, -- Come one, come all! Goods from Fauregandi for sale! But make surrre you brrring your gil with you!
        SHEIAPOHRICHAMAHA_CLOSED_DIALOG = 4144, -- I'm a traveling merrrchant. There arrre times when I have prrroducts from Fauregandi, but rrright now I'm clearrr out of stock!
        ZOREEN_OPEN_DIALOG              = 4145, -- Buy somethin' from Valdeaunia...?
        ZOREEN_CLOSED_DIALOG            = 4146, -- Valdeaunia...
        KHEL_PAHLHAMA_DIALOG            = 4147, -- She sells % by the sea shorrre! Hahaha...
        CONQUEST_BASE                   = 4424, -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED         = 10966, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE      = 10970, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                   = 10972, -- Obtained: <item>.
        GIL_OBTAINED                    = 10973, -- Obtained <number> gil.
        KEYITEM_OBTAINED                = 10975, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                    = 10976, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL             = 10977, -- You do not have enough gil.
        CARRIED_OVER_POINTS             = 11011, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY         = 11012, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                    = 11013, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HOMEPOINT_SET                   = 11063, -- Home point set!
        YOU_ACCEPT_THE_MISSION          = 11156, -- You have accepted the mission.
        KHEL_PAHLHAMA_SHOP_DIALOG       = 11202, -- These magic shells are full of mysteries...
        MOG_LOCKER_OFFSET               = 11480, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        FISHING_MESSAGE_OFFSET          = 11578, -- You can't fish here.
        FISHING_SUPPORT                 = 11682, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT        = 11696, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT              = 11704, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE             = 11711, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                     = 11716, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP              = 11717, -- You do not have enough guild points.
        RYAN_SHOP_DIALOG                = 11831, -- I have no time for white-livered scum that rely on magic alone. If you're with me then check out these wares from across the high seas.
        DROZGA_SHOP_DIALOG              = 11832, -- Ho there, young [man/lady]! Not only is Ryan a boorish lout, but his craftsmanship leaves much to be desired, as well. You're better off buyin' from me.
        CONQUEST                        = 11898, -- You've earned conquest points!
        KOHLO_LAKOLO_DIALOG_A           = 12441, -- On your Star Onion Brigade honor, you can't tell anybody that Joker is hiding in the ghosty house!
        LEBONDUR_OPEN_DIALOG            = 12552, -- I've risked my life traveling all the way from Vollbow to bring you these fine goods!
        LEBONDUR_CLOSED_DIALOG          = 12553, -- Where is my shipment from Vollbow? This is terrible for my image as a respected importer...
        SATTSUHAHKANPARI_OPEN_DIALOG    = 12554, -- You can look, but don't touch! And rememberrr, you break it, you bought it!
        SATTSUHAHKANPARI_CLOSED_DIALOG  = 12555, -- You've heard of the Elshimo Uplands, haven't you? Well, if you'll hold on a minute, I'll have a shipment of goods coming in any time now.
        BLACK_HALO_LEARNED              = 12651, -- You have learned the weapon skill Black Halo!
        KUCHAMALKOBHI_SHOP_DIALOG       = 12700, -- How about a nice suit of adventurer-issue armorrr? Be careful though. We offer no rrrefunds!
        ALIZABE_OPEN_DIALOG             = 12880, -- Don't tell anybody, but I've managed to get my hands on some items from Tavnazia! Take a look!
        ALIZABE_CLOSED_DIALOG           = 12881, -- Pssst! Have you heard of Tavnazia? Boy, do they have some sweet items on those islands...
        ALIZABE_COP_NOT_COMPLETED       = 12882, -- It won't be long before I set up shop right here in this very place. And once I start, there won't be no stoppin' me!
        RETRIEVE_DIALOG_ID              = 15891, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL           = 16303, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        EXPLORER_MOOGLE = 17760450,
    },
}

return zones[xi.zone.PORT_WINDURST]
