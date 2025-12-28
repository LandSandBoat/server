-----------------------------------
-- Area: Port_Jeuno
-----------------------------------
zones = zones or {}

zones[xi.zone.PORT_JEUNO] =
{
    text =
    {
        ASSIST_CHANNEL                = 6380, -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        MYSTIC_RETRIEVER              = 6388, -- You cannot obtain the <item>. Speak with the mystic retriever after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS           = 6430, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6431, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6432, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6452, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 6496, -- Tallying conquest results...
        HOMEPOINT_SET                 = 6657, -- Home point set!
        MOG_LOCKER_OFFSET             = 6775, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        WEATHER_DIALOG                = 6873, -- Your fate rides on the changing winds of Vana'diel. I can give you insight on the local weather.
        FISHING_MESSAGE_OFFSET        = 6921, -- You can't fish here.
        GUIDE_STONE                   = 7037, -- Up: Lower Jeuno (facing Bastok) Down: Qufim Island
        DUTY_FREE_SHOP_DIALOG         = 7038, -- Hello. All goods are duty-free.
        CHALLOUX_SHOP_DIALOG          = 7039, -- Good day!
        CUMETOUFLAIX_DIALOG           = 7077, -- This underground tunnel leads to the island of Qufim. Everyone is advised to stay out. But of course you adventurers never listen.
        COUNTER_NPC_2                 = 7083, -- With the airships connecting Jeuno with the three nations, the flow of goods has become much more consistent. Nowadays, everything comes through Jeuno!
        COUNTER_NPC                   = 7085, -- I think the airships are a subtle form of pressure on the other three nations. That way, Jeuno can maintain the current balance of power.
        DEPARTURE_NPC                 = 7094, -- Have a safe flight!
        ARRIVAL_NPC                   = 7095, -- Enjoy your stay in Jeuno!
        CONFISCATED                   = 7102, -- Your <keyitem> have been confiscated. You are temporarily suspended from boarding airships in Jeuno.
        CLEARED_CUSTOMS               = 7106, -- You have cleared customs.
        DAPOL_DIALOG                  = 7108, -- Welcome to Port Jeuno, the busiest airship hub anywhere! You can't miss the awe-inspiring view of airships in flight!
        SECURITY_DIALOG               = 7111, -- Port Jeuno must remain secure. After all, if anything happened to the archduke, it would change the world!
        MOGHOUSE_EXIT                 = 7192, -- You have learned your way through the back alleys of Jeuno! Now you can exit to any area from your residence.
        CHOCOBO_DIALOG                = 7214, -- ...
        OLD_BOX                       = 7312, -- You find a grimy old box.
        GAVIN_DIALOG                  = 7382, -- You will need <keyitem> to travel to the Outlands by air. You may apply for one at the designated counter.
        ITEM_DELIVERY_DIALOG          = 7402, -- Delivering goods to residences everywhere!
        CONQUEST                      = 7412, -- You've earned conquest points!
        SAGHEERA_MAX_ABCS             = 8053, -- I apologize, but I cannot take any more <item> from you.
        SAGHEERA_LACK_ABCS            = 8054, -- You have collected the proper materials, but unfortunately you lack the required amount of <item> for payment.
        SAGHEERA_NO_LIMBUS_ACCESS     = 8062, -- I came from the Near East to peddle my wares. I heard that there are simply hordes of gullib--err, that is, I have heard of the great adventurers that roam this land, and wish to be of service to them. If you happen to know of any seasoned adventurers, I ask that you bring them to me. Be sure to tell them of my fabulous goods!
        GET_LOST                      = 8177, -- You want somethin' from me? Well, too bad. I don't want nothin' from you. Get lost.
        DRYEYES_1                     = 8186, -- Then why you waste my time? Get lost.
        DRYEYES_2                     = 8187, -- Done deal. Deal is done. You a real sucker--<cough>--I mean, good customer. Come back soon. And don't forget the goods.
        DRYEYES_3                     = 8188, -- Hey, you already got <item>. What you tryin' to pull here? Save some for my other customers, eh?
        DRYEYES_4                     = 8203, -- Huh? You don't got enough beastmen's seals! You tryin' to waste my time? Take a hike!
        DRYEYES_5                     = 8204, -- Huh? You don't got enough gil! You tryin' to waste my time? Take a hike!
        WOULD_YE_MIND                 = 8408, -- Sorry, [mate/lass], but would ye mind leavin' me in peace?
        OBTAINED_NUM_KEYITEMS         = 8478, -- Obtained key item: <number> <keyitem>!
        CHEST_IS_EMPTY                = 8676, -- The chest is empty.
        KINDLIX_SHOP_DIALOG           = 8695, -- Our fam'ly peddle sky flowers. You want have nice scenery? Send fireworks sky high! It's great feeling. Bwee hee hee.
        PYROPOX_SHOP_DIALOG           = 8699, -- Bwee hee. I get fireworks from all 'round globe. Kindlix never sell more than me.
        STRANGE_DEVICE                = 9413, -- There is a strange device here.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.PORT_JEUNO]
