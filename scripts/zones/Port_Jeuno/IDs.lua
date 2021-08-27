-----------------------------------
-- Area: Port_Jeuno
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PORT_JEUNO] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        KEYITEM_LOST            = 6393, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS     = 6428, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 6429, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 6430, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 6481, -- Tallying conquest results...
        HOMEPOINT_SET           = 6642, -- Home point set!
        MOG_LOCKER_OFFSET       = 6760, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        WEATHER_DIALOG          = 6858, -- Your fate rides on the changing winds of Vana'diel. I can give you insight on the local weather.
        FISHING_MESSAGE_OFFSET  = 6906, -- You can't fish here.
        GUIDE_STONE             = 7022, -- Up: Lower Jeuno (facing Bastok) Down: Qufim Island
        DUTY_FREE_SHOP_DIALOG   = 7023, -- Hello. All goods are duty-free.
        CHALLOUX_SHOP_DIALOG    = 7024, -- Good day!
        CUMETOUFLAIX_DIALOG     = 7062, -- This underground tunnel leads to the island of Qufim. Everyone is advised to stay out. But of course you adventurers never listen.
        COUNTER_NPC_2           = 7068, -- With the airships connecting Jeuno with the three nations, the flow of goods has become much more consistent. Nowadays, everything comes through Jeuno!
        COUNTER_NPC             = 7070, -- I think the airships are a subtle form of pressure on the other three nations. That way, Jeuno can maintain the current balance of power.
        DEPARTURE_NPC           = 7079, -- Have a safe flight!
        ARRIVAL_NPC             = 7080, -- Enjoy your stay in Jeuno!
        DAPOL_DIALOG            = 7093, -- Welcome to Port Jeuno, the busiest airship hub anywhere! You can't miss the awe-inspiring view of airships in flight!
        SECURITY_DIALOG         = 7096, -- Port Jeuno must remain secure. After all, if anything happened to the archduke, it would change the world!
        MOGHOUSE_EXIT           = 7177, -- You have learned your way through the back alleys of Jeuno! Now you can exit to any area from your residence.
        CHOCOBO_DIALOG          = 7199, -- ...
        OLD_BOX                 = 7297, -- You find a grimy old box.
        GAVIN_DIALOG            = 7367, -- You will need <keyitem> to travel to the Outlands by air. You may apply for one at the designated counter.
        ITEM_DELIVERY_DIALOG    = 7387, -- Delivering goods to residences everywhere!
        CONQUEST                = 7397, -- You've earned conquest points!
        SAGHEERA_MAX_ABCS       = 8038, -- I apologize, but I cannot take any more <item> from you.
        SAGHEERA_LACK_ABCS      = 8039, -- You have collected the proper materials, but unfortunately you lack the required amount of <item> for payment.
        GET_LOST                = 8162, -- You want somethin' from me? Well, too bad. I don't want nothin' from you. Get lost.
        DRYEYES_1               = 8171, -- Then why you waste my time? Get lost.
        DRYEYES_2               = 8172, -- Done deal. Deal is done. You a real sucker--<cough>--I mean, good customer. Come back soon. And don't forget the goods.
        DRYEYES_3               = 8173, -- Hey, you already got <item>. What you tryin' to pull here? Save some for my other customers, eh?
        OBTAINED_NUM_KEYITEMS   = 8463, -- Obtained key item: <number> <keyitem>!
        CHEST_IS_EMPTY          = 8661, -- The chest is empty.
        KINDLIX_SHOP_DIALOG     = 8680, -- Our fam'ly peddle sky flowers. You want have nice scenery? Send fireworks sky high! It's great feeling. Bwee hee hee.
        PYROPOX_SHOP_DIALOG     = 8684, -- Bwee hee. I get fireworks from all 'round globe. Kindlix never sell more than me.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.PORT_JEUNO]
