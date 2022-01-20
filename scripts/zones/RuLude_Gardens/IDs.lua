-----------------------------------
-- Area: RuLude_Gardens
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.RULUDE_GARDENS] =
{
    text =
    {
        CONQUEST_BASE                    = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED          = 6523,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        MYSTIC_RETRIEVER                 = 6526,  -- You cannot obtain the <item>. Speak with the mystic retriever after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE       = 6527,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                    = 6529,  -- Obtained: <item>.
        GIL_OBTAINED                     = 6530,  -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6532,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                     = 6533,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                   = 6538,  -- You obtain <number> <item>!
        RETURN_ITEM                      = 6541,  -- The <item> is returned to you.
        NOTHING_OUT_OF_ORDINARY          = 6543,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS              = 6568,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 6569,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                     = 6570,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOUR_MAXIMUM_LEVEL               = 6585,  -- Your maximum level has been raised to [50/55/60/65/70/75/80/85/90/95/99]!
        YOU_LEARNED_TRUST                = 6592,  -- You learned Trust: <name>!
        MOG_LOCKER_OFFSET                = 6704,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED                  = 6863,  -- Current training regime canceled.
        HUNT_ACCEPTED                    = 6881,  -- Hunt accepted!
        USE_SCYLDS                       = 6882,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                    = 6893,  -- You record your hunt.
        OBTAIN_SCYLDS                    = 6895,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                    = 6899,  -- Hunt canceled.
        RESTRICTED                       = 10106, -- It reads, Restricted Area.
        SOVEREIGN_WITHOUT_AN_APPOINTMENT = 10179, -- Nobody sees the sovereign without an appointment!
        ITEM_DELIVERY_DIALOG             = 10270, -- Now offering quick and easy delivery of packages to homes everywhere!
        HOMEPOINT_SET                    = 10283, -- Home point set!
        MAAT_DIALOG                      = 10376, -- Heh. You've got no business talking to me. Why, you're just a pup.
        YOUR_LEVEL_LIMIT_IS_NOW_55       = 10387, -- Your level limit is now 55.
        YOUR_LEVEL_LIMIT_IS_NOW_60       = 10399, -- Your level limit is now 60.
        YOUR_LEVEL_LIMIT_IS_NOW_65       = 10408, -- Your level limit is now 65.
        YOUR_LEVEL_LIMIT_IS_NOW_70       = 10450, -- Your level limit is now 70.
        YOUR_LEVEL_LIMIT_IS_NOW_75       = 10509, -- Your level limit is now 75.
        CONQUEST                         = 10570, -- You've earned conquest points!
        DABIHJAJALIOH_SHOP_DIALOG        = 10907, -- Hello therrre. I worrrk for the M&P Market. I'm still new, so I don't know much about selling stuff...
        MACCHI_GAZLITAH_SHOP_DIALOG4     = 10910, -- My new shipment has finally come in. Talk to me, and I can show you what we have!
        MACCHI_GAZLITAH_SHOP_DIALOG1     = 10913, -- Hello therrre. I work for the Buffalo Bonanza Ranch. I'm still new, so I don't know much about selling stuff...
        MACCHI_GAZLITAH_SHOP_DIALOG2     = 10914, -- Hello therrre, [handsome/cutie]! The Buffalo Bonanza Ranch has a lot of useful items, just for you!
        MACCHI_GAZLITAH_SHOP_DIALOG3     = 10915, -- Hello therrre, [sir/ma'am]! Business is booming! The Buffalo Bonanza Ranch even made me managerrr of this local shop!
        YOU_CANNOT_ENTER_DYNAMIS         = 11235, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL   = 11237, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE         = 11250, -- There is an unusual arrangement of leaves on the ground.
        YOUR_LEVEL_LIMIT_IS_NOW_80       = 12201, -- Your level limit is now 80!
        YOUR_LEVEL_LIMIT_IS_NOW_85       = 12249, -- Your level limit is now 85!
        YOUR_LEVEL_LIMIT_IS_NOW_90       = 12348, -- Your level limit is now 90!
        YOUR_LEVEL_LIMIT_IS_NOW_95       = 12449, -- Your level limit is now 95!
        WINDURST_EMBASSY                 = 12450, -- I have a letter for you here from none other than Atori-Tutori. It reads, ahem...
        YOUR_LEVEL_LIMIT_IS_NOW_99       = 12529, -- Your level limit is now 99!
        YOU_HAND_THE_THREE_SLIVERS       = 13761, -- You hand the three crystal slivers to Esha'ntarl.
        ITEM_NOT_WEAPON_MAGIAN           = 14516, -- As I advised you previously, my sole specialty is weapons. I have not the moogle magic at my disposal to augment items of this variety, kupo...
        RETURN_MAGIAN_ITEM               = 14536, -- The Magian Moogle returns your <item>.
        DELIVERY_CRATE_TEXT              = 14549, -- A sturdy, sizable wooden crate lies before you. To complete an item acquisition trial, trade your retrieved items together with the corresponding inscribed piece of equipment.
        ITEM_NOT_ARMOR_MAGIAN            = 14641, -- Uh, sorry, I'm only in charge of armor. Nande, for that item, you'll have to talk to the other dude.
        OBTAINED_NUM_KEYITEMS            = 14868, -- Obtained key item: <number> <keyitem>!
        NOT_ACQUAINTED                   = 14870, -- I'm sorry, but I don't believe we're acquainted. Please leave me be.
        LEARNED_SECRET_TECHNIQUE         = 15094, -- You learned the secret technique of the bushin!
        COMMON_SENSE_SURVIVAL            = 15720, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        TEAR_IN_FABRIC_OF_SPACE          = 15903, -- There appears to be a tear in the fabric of space...
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.RULUDE_GARDENS]
