-----------------------------------
-- Area: RuLude_Gardens
-----------------------------------
zones = zones or {}

zones[xi.zone.RULUDE_GARDENS] =
{
    text =
    {
        CONQUEST_BASE                    = 0,     -- Tallying conquest results...
        ASSIST_CHANNEL                   = 6520,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED          = 6527,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        MYSTIC_RETRIEVER                 = 6530,  -- You cannot obtain the <item>. Speak with the mystic retriever after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE       = 6531,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                    = 6535,  -- Obtained: <item>.
        GIL_OBTAINED                     = 6536,  -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6538,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                     = 6539,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                   = 6544,  -- You obtain <number> <item>!
        RETURN_ITEM                      = 6547,  -- The <item> is returned to you.
        RETURN_ITEMS                     = 6548,  -- The <number> <item> are returned to you.
        NOTHING_OUT_OF_ORDINARY          = 6549,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS              = 6574,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 6575,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 6576,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOUR_MAXIMUM_LEVEL               = 6591,  -- Your maximum level has been raised to [50/55/60/65/70/75/80/85/90/95/99]!
        MEMBERS_LEVELS_ARE_RESTRICTED    = 6596,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST                = 6598,  -- You learned Trust: <name>!
        MOG_LOCKER_OFFSET                = 6721,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED                  = 6880,  -- Current training regime canceled.
        HUNT_ACCEPTED                    = 6898,  -- Hunt accepted!
        USE_SCYLDS                       = 6899,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                    = 6910,  -- You record your hunt.
        OBTAIN_SCYLDS                    = 6912,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                    = 6916,  -- Hunt canceled.
        RESTRICTED                       = 10123, -- It reads, Restricted Area.
        THE_CONSULATE_IS_AWAY            = 10125, -- The consulate is away.
        SOVEREIGN_WITHOUT_AN_APPOINTMENT = 10196, -- Nobody sees the sovereign without an appointment!
        ITEM_DELIVERY_DIALOG             = 10287, -- Now offering quick and easy delivery of packages to homes everywhere!
        HOMEPOINT_SET                    = 10300, -- Home point set!
        MAAT_DIALOG                      = 10393, -- Heh. You've got no business talking to me. Why, you're just a pup.
        MAAT_LB2_PLACEHOLDER             = 10403, -- What, you don't understand? Just get out there and fight. Then you'll see!
        YOUR_LEVEL_LIMIT_IS_NOW_55       = 10404, -- Your level limit is now 55.
        MAAT_LB3_PLACEHOLDER             = 10415, -- The ultimate barrier is still far away. Don't worry about it. What matters is effort!
        YOUR_LEVEL_LIMIT_IS_NOW_60       = 10416, -- Your level limit is now 60.
        YOUR_LEVEL_LIMIT_IS_NOW_65       = 10425, -- Your level limit is now 65.
        YOUR_LEVEL_LIMIT_IS_NOW_70       = 10467, -- Your level limit is now 70.
        MAAT_CAP_PLACEHOLDER             = 10468, -- Hm? I don't have time to play with half-grown puppies. Why don't you head back to your Mog House and come see me when you're more prepared.
        YOUR_LEVEL_LIMIT_IS_NOW_75       = 10526, -- Your level limit is now 75.
        CONQUEST                         = 10587, -- You've earned conquest points!
        DABIHJAJALIOH_SHOP_DIALOG        = 10924, -- Hello therrre. I worrrk for the M&P Market. I'm still new, so I don't know much about selling stuff...
        MACCHI_GAZLITAH_SHOP_DIALOG4     = 10927, -- My new shipment has finally come in. Talk to me, and I can show you what we have!
        MACCHI_GAZLITAH_SHOP_DIALOG1     = 10930, -- Hello therrre. I work for the Buffalo Bonanza Ranch. I'm still new, so I don't know much about selling stuff...
        MACCHI_GAZLITAH_SHOP_DIALOG2     = 10931, -- Hello therrre, [handsome/cutie]! The Buffalo Bonanza Ranch has a lot of useful items, just for you!
        MACCHI_GAZLITAH_SHOP_DIALOG3     = 10932, -- Hello therrre, [sir/ma'am]! Business is booming! The Buffalo Bonanza Ranch even made me managerrr of this local shop!
        YOU_CANNOT_ENTER_DYNAMIS         = 11252, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL   = 11254, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE         = 11267, -- There is an unusual arrangement of leaves on the ground.
        YOUR_LEVEL_LIMIT_IS_NOW_80       = 12218, -- Your level limit is now 80!
        YOUR_LEVEL_LIMIT_IS_NOW_85       = 12266, -- Your level limit is now 85!
        YOUR_LEVEL_LIMIT_IS_NOW_90       = 12365, -- Your level limit is now 90!
        YOUR_LEVEL_LIMIT_IS_NOW_95       = 12466, -- Your level limit is now 95!
        WINDURST_EMBASSY                 = 12467, -- I have a letter for you here from none other than Atori-Tutori. It reads, ahem...
        YOUR_LEVEL_LIMIT_IS_NOW_99       = 12546, -- Your level limit is now 99!
        YOU_HAND_THE_THREE_SLIVERS       = 13778, -- You hand the three crystal slivers to Esha'ntarl.
        ITEM_NOT_WEAPON_MAGIAN           = 14533, -- As I advised you previously, my sole specialty is weapons. I have not the moogle magic at my disposal to augment items of this variety, kupo...
        RETURN_MAGIAN_ITEM               = 14553, -- The Magian Moogle returns your <item>.
        STURDY_WOODEN_CRATE              = 14565, -- A sturdy, sizable wooden crate sits before you.
        DELIVERY_CRATE_TEXT              = 14566, -- A sturdy, sizable wooden crate lies before you. To complete an item acquisition trial, trade your retrieved items together with the corresponding inscribed piece of equipment.
        SIGNIFICANTLY_SHOPWORN           = 14572, -- Long years of use have left this once-majestic chest looking significantly shopworn.
        ITEM_NOT_ARMOR_MAGIAN            = 14658, -- Uh, sorry, I'm only in charge of armor. Nande, for that item, you'll have to talk to the other dude.
        OBTAINED_NUM_KEYITEMS            = 14885, -- Obtained key item: <number> <keyitem>!
        NOT_ACQUAINTED                   = 14887, -- I'm sorry, but I don't believe we're acquainted. Please leave me be.
        LEARNED_SECRET_TECHNIQUE         = 15113, -- You learned the secret technique of the bushin!
        COMMON_SENSE_SURVIVAL            = 15769, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        TEAR_IN_FABRIC_OF_SPACE          = 15952, -- There appears to be a tear in the fabric of space...
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.RULUDE_GARDENS]
