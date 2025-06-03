-----------------------------------
-- Area: RuLude_Gardens
-----------------------------------
zones = zones or {}

zones[xi.zone.RULUDE_GARDENS] =
{
    text =
    {
        CONQUEST_BASE                    = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED          = 6525,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        MYSTIC_RETRIEVER                 = 6528,  -- You cannot obtain the <item>. Speak with the mystic retriever after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE       = 6529,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                    = 6531,  -- Obtained: <item>.
        GIL_OBTAINED                     = 6532,  -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6534,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                     = 6535,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                   = 6540,  -- You obtain <number> <item>!
        RETURN_ITEM                      = 6543,  -- The <item> is returned to you.
        NOTHING_OUT_OF_ORDINARY          = 6545,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS              = 6570,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 6571,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 6572,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOUR_MAXIMUM_LEVEL               = 6587,  -- Your maximum level has been raised to [50/55/60/65/70/75/80/85/90/95/99]!
        MEMBERS_LEVELS_ARE_RESTRICTED    = 6592,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST                = 6594,  -- You learned Trust: <name>!
        MOG_LOCKER_OFFSET                = 6716,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED                  = 6875,  -- Current training regime canceled.
        HUNT_ACCEPTED                    = 6893,  -- Hunt accepted!
        USE_SCYLDS                       = 6894,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                    = 6905,  -- You record your hunt.
        OBTAIN_SCYLDS                    = 6907,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                    = 6911,  -- Hunt canceled.
        RESTRICTED                       = 10118, -- It reads, Restricted Area.
        THE_CONSULATE_IS_AWAY            = 10120, -- The consulate is away.
        SOVEREIGN_WITHOUT_AN_APPOINTMENT = 10191, -- Nobody sees the sovereign without an appointment!
        ITEM_DELIVERY_DIALOG             = 10282, -- Now offering quick and easy delivery of packages to homes everywhere!
        HOMEPOINT_SET                    = 10295, -- Home point set!
        MAAT_DIALOG                      = 10388, -- Heh. You've got no business talking to me. Why, you're just a pup.
        MAAT_LB2_PLACEHOLDER             = 10398, -- What, you don't understand? Just get out there and fight. Then you'll see!
        YOUR_LEVEL_LIMIT_IS_NOW_55       = 10399, -- Your level limit is now 55.
        MAAT_LB3_PLACEHOLDER             = 10410, -- The ultimate barrier is still far away. Don't worry about it. What matters is effort!
        YOUR_LEVEL_LIMIT_IS_NOW_60       = 10411, -- Your level limit is now 60.
        YOUR_LEVEL_LIMIT_IS_NOW_65       = 10420, -- Your level limit is now 65.
        YOUR_LEVEL_LIMIT_IS_NOW_70       = 10462, -- Your level limit is now 70.
        MAAT_CAP_PLACEHOLDER             = 10463, -- Hm? I don't have time to play with half-grown puppies. Why don't you head back to your Mog House and come see me when you're more prepared.
        YOUR_LEVEL_LIMIT_IS_NOW_75       = 10521, -- Your level limit is now 75.
        CONQUEST                         = 10582, -- You've earned conquest points!
        DABIHJAJALIOH_SHOP_DIALOG        = 10919, -- Hello therrre. I worrrk for the M&P Market. I'm still new, so I don't know much about selling stuff...
        MACCHI_GAZLITAH_SHOP_DIALOG4     = 10922, -- My new shipment has finally come in. Talk to me, and I can show you what we have!
        MACCHI_GAZLITAH_SHOP_DIALOG1     = 10925, -- Hello therrre. I work for the Buffalo Bonanza Ranch. I'm still new, so I don't know much about selling stuff...
        MACCHI_GAZLITAH_SHOP_DIALOG2     = 10926, -- Hello therrre, [handsome/cutie]! The Buffalo Bonanza Ranch has a lot of useful items, just for you!
        MACCHI_GAZLITAH_SHOP_DIALOG3     = 10927, -- Hello therrre, [sir/ma'am]! Business is booming! The Buffalo Bonanza Ranch even made me managerrr of this local shop!
        YOU_CANNOT_ENTER_DYNAMIS         = 11247, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL   = 11249, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE         = 11262, -- There is an unusual arrangement of leaves on the ground.
        YOUR_LEVEL_LIMIT_IS_NOW_80       = 12213, -- Your level limit is now 80!
        YOUR_LEVEL_LIMIT_IS_NOW_85       = 12261, -- Your level limit is now 85!
        YOUR_LEVEL_LIMIT_IS_NOW_90       = 12360, -- Your level limit is now 90!
        YOUR_LEVEL_LIMIT_IS_NOW_95       = 12461, -- Your level limit is now 95!
        WINDURST_EMBASSY                 = 12462, -- I have a letter for you here from none other than Atori-Tutori. It reads, ahem...
        YOUR_LEVEL_LIMIT_IS_NOW_99       = 12541, -- Your level limit is now 99!
        YOU_HAND_THE_THREE_SLIVERS       = 13773, -- You hand the three crystal slivers to Esha'ntarl.
        ITEM_NOT_WEAPON_MAGIAN           = 14528, -- As I advised you previously, my sole specialty is weapons. I have not the moogle magic at my disposal to augment items of this variety, kupo...
        RETURN_MAGIAN_ITEM               = 14548, -- The Magian Moogle returns your <item>.
        DELIVERY_CRATE_TEXT              = 14561, -- A sturdy, sizable wooden crate lies before you. To complete an item acquisition trial, trade your retrieved items together with the corresponding inscribed piece of equipment.
        ITEM_NOT_ARMOR_MAGIAN            = 14653, -- Uh, sorry, I'm only in charge of armor. Nande, for that item, you'll have to talk to the other dude.
        OBTAINED_NUM_KEYITEMS            = 14880, -- Obtained key item: <number> <keyitem>!
        NOT_ACQUAINTED                   = 14882, -- I'm sorry, but I don't believe we're acquainted. Please leave me be.
        LEARNED_SECRET_TECHNIQUE         = 15108, -- You learned the secret technique of the bushin!
        COMMON_SENSE_SURVIVAL            = 15734, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        TEAR_IN_FABRIC_OF_SPACE          = 15917, -- There appears to be a tear in the fabric of space...
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.RULUDE_GARDENS]
