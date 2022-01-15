-----------------------------------
-- Area: Southern_San_dOria_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.SOUTHERN_SAN_DORIA_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389,  -- Obtained: <item>.
        GIL_OBTAINED            = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GATE_IS_LOCKED          = 7102,  -- The gate is locked.
        DONT_HURT_GELTPIX       = 7105,  -- Don't hurt poor Geltpix! Geltpix's just a merchant from Boodlix's Emporium in Jeuno. Kingdom vendors don't like gil, but Boodlix knows true value of new money.
        MOG_LOCKER_OFFSET       = 7372,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED         = 7629,  -- Current training regime canceled.
        HUNT_ACCEPTED           = 7647,  -- Hunt accepted!
        USE_SCYLDS              = 7648,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED           = 7659,  -- You record your hunt.
        OBTAIN_SCYLDS           = 7661,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED           = 7665,  -- Hunt canceled.
        WYATT_DIALOG            = 11091, -- Ahhh, sorry, sorry. The name's Wyatt, an' I be an armor merchant from Jeuno. Ended up 'ere in San d'Oria some way or another, though.
        HOMEPOINT_SET           = 11121, -- Home point set!
        ITEM_DELIVERY_DIALOG    = 11222, -- If'n ye have goods tae deliver, then Nembet be yer man!
        DISTANCE_YOURSELF       = 11260, -- I advise you distance yourself from Lady Ulla. I know not your intentions, but am inclined to believe they are crooked.
        ONE_OF_THESE_CITIES     = 11260, -- So this is one of these cities I've heard so much of, is it? Hmph. Seems to be nothing more than a mass of people crowded into a noisy, confined space.
        ACHTELLE_FROM_ADOULIN   = 11272, -- I go by the name Achtelle. I hail from Adoulin Isle. Word has reached there that the dragoons and their wyverns have long since disappeared from these eastern lands. Tell me, is it true?
        NOTHING_OUT_OF_ORDINARY = 11752, -- You find nothing out of the ordinary.
        TOO_BUSY                = 11756, -- I am far too busy to speak with you now. Perhaps I'll have a little time later.
        RINGING_OF_STEEL        = 11806, -- Hah hah hah! The ringing of steel upon steel! The dripping stench of the battlefield! What could be better than war? The nobles can have their balls, I'll do my dance on the front lines!
        BASEBORN_PEASANT        = 11807, -- How dare a baseborn peasant raise [his/her] voice to a noble knight!? Begone, before I strike you down myself!
        KINGDOMS_DEFEAT         = 11808, -- The Kingdom's defeat at Jugner still stings. To avenge the souls of those lost on that fateful day, we must join hands and take up arms as one.
        NOT_ONCE_IN_400_YEARS   = 11809, -- Not once in the four hundred years since the dawn of the Royal Knights has the Kingdom found itself in such peril. Let us take up our pikes and stand our ground to ensure another four centuries of prosperity!
        HOLY_DOCTRINES_PROHIBIT = 11811, -- While our holy doctrines specifically prohibit the taking of another life, you need not hesitate on the battlefield. The Church has branded the beastmen enemies of Altana. The purification must begin! It is the will of the Goddess!!!
        YEARS_OF_TRAINING       = 11812, -- After years of training in the Far East, I return only to find my nation burning at the hands of the infernal beastman hordes. The heathens shall pay dearly... My work has only just begun.
        FINE_WARRIOR            = 11813, -- You have the look of a fine warrior. It is a pity you are not one of my Crimson Wolves.
        EYES_OF_THE_GODDESS     = 11814, -- The eyes of the Goddess are ever upon us. We must remain steadfast against the evils from without, as well as those from within.
        ALLIED_SIGIL            = 12923, -- You have received the Allied Sigil!
        DOOR_IS_FIRMLY_LOCKED   = 13549, -- The door is firmly locked...
        RETRIEVE_DIALOG_ID      = 15586, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL   = 15660, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.SOUTHERN_SAN_DORIA_S]
