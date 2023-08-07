-----------------------------------
-- Area: Western Adoulin (256)
-----------------------------------
zones = zones or {}

zones[xi.zone.WESTERN_ADOULIN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6395,  -- You do not have enough gil.
        YOU_OBTAIN_ITEM               = 6396,  -- You obtain  <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        BAYLD_OBTAINED                = 7007,  -- You have obtained <number> bayld!
        YOU_CAN_NOW_BECOME            = 7011,  -- You can now become a [geomancer/rune fencer]!
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        MOG_LOCKER_OFFSET             = 7585,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        RETRIEVE_DIALOG_ID            = 7758,  -- You retrieve <item> from the porter moogle's care.
        WAYPOINT_ATTUNED              = 7805,  -- Your <keyitem> has been attuned to a geomagnetic fount[/ in Platea Triumphus (Couriers' Coalition)/ in front of the Pioneers' Coalition/ in front of the Mummers' Coalition/ in front of the Inventors' Coalition/ in front of the auction house/ in front of your Rent-a-Room/ by Big Bridge/ by the airship docks/ on the Adoulin Waterfront]!
        EXPENDED_KINETIC_UNITS        = 7822,  -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7823,  -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7824,  -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7825,  -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7826,  -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7827,  -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7828,  -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        HOMEPOINT_SET                 = 8317,  -- Home point set!
        BY_ALL_APPEARANCES            = 9082,  -- By all appearances, this building functions as a warehouse for the Couriers' Coalition.
        TASKED_WITH_PROCURING         = 9083,  -- You are tasked with procuring <number> <item>.
        HUJETTE_SHOP_TEXT             = 9806,  -- How about indulging in some regional delicacies while taking a load off those tired feet of yours?
        PRETERIG_SHOP_TEXT            = 9807,  -- Want a way to beat the heat? Try some of the tasty beverages we have on hand.
        LEDERICUS_SHOP_TEXT           = 9841,  -- We've got a doozy of a magic scroll selection, tailored especially to your pioneering needs!
        ISHVAD_SHOP_TEXT              = 9842,  -- ...A pioneer, are ya? If that's the case, maybe we've finally found a client for our geomantic plates.
        EUKALLINE_SHOP_TEXT           = 9843,  -- Why, hello there! If you're looking for geomantic plates, look no further! I don't like to brag, but I'd say our selection is a bit more...sophisticated than what they offer next door.
        FLAPANO_SHOP_TEXT             = 9844,  -- Welcome, welcome! Going out into the eye of the jungle's storm? Then the last thing you want is your stomach rumbling during an important battle!
        THEOPHYLACTE_SHOP_TEXT        = 9849,  -- Would you care for some of my wares? If you do not, I cannot fault you, but please keep in mind that my revolutionary research into a new Ulbukan toxin antidote will have to be put on hold unless I can accrue the necessary funds.
        KANIL_SHOP_TEXT               = 9850,  -- Good day, [good sir/fair maiden]! You're certainly not in the Middle Lands anymore, but would you care for some products from your homeland in addition to some more traditional fare?
        DEFLIAA_SHOP_TEXT             = 9868,  -- Hi there, pioneer! We wouldn't want you going out to the scary jungle on an empty stomach. Stock up on some of our delicious bread for the journey!
        ANSEGUSELE_SHOP_TEXT          = 9869,  -- Would you care for some fresh vegetables direct from the Rala Waterways? They're some of our most popular items!
        TEVIGOGO_SHOP_TEXT            = 9870,  -- Hidey ho! Make sure not to forgetaru anything before heading out into the great unknown!
        MINNIFI_DIALOGUE              = 10253, -- Come, ladies and gentlemen, and enjoy our delightful array of frrresh vegetables!
        SPARK_EXCHANGE                = 11368, -- Hm? Oh, spark exchange... Of course.
        DO_NOT_POSSESS_ENOUGH         = 11381, -- You do not possess enough <item> to complete the transaction.
        NOT_ENOUGH_SPARKS             = 11382, -- You do not possess enough sparks of eminence to complete the transaction.
        MAX_SPARKS_LIMIT_REACHED      = 11383, -- You have reached the maximum number of sparks that you can exchange this week (<number>). Your ability to purchase skill books and equipment will be restricted until next week.
        YOU_NOW_HAVE_AMT_CURRENCY     = 11393, -- You now have <number> [sparks of eminence/conquest points/points of imperial standing/Allied Notes/bayld/Fields of Valor points/assault points (Leujaoam)/assault points (Mamool Ja Training Grounds)/assault points (Lebros Cavern)/assault points (Periqia)/assault points (Ilrusi Atoll)/cruor/kinetic units/obsidian fragments/mweya plasm corpuscles/ballista points/Unity accolades/pinches of Escha silt/resistance credits].
        YOU_HAVE_JOINED_UNITY         = 13006, -- ou have joined [Pieuje's/Ayame's/Invincible Shield's/Apururu's/Maat's/Aldo's/Jakoh Wahcondalo's/Naja Salaheem's/Flaviria's/Yoran-Oran's/Sylvie's] Unity!
        HAVE_ALREADY_CHANGED_UNITY    = 13082, -- ou have already changed Unities. Please wait until the next tabulation period.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.WESTERN_ADOULIN]
