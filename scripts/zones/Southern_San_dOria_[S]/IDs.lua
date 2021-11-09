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
        GATE_IS_LOCKED          = 7099,  -- The gate is locked.
        DONT_HURT_GELTPIX       = 7102,  -- Don't hurt poor Geltpix! Geltpix's just a merchant from Boodlix's Emporium in Jeuno. Kingdom vendors don't like gil, but Boodlix knows true value of new money.
        MOG_LOCKER_OFFSET       = 7369,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED         = 7626,  -- Current training regime canceled.
        HUNT_ACCEPTED           = 7644,  -- Hunt accepted!
        USE_SCYLDS              = 7645,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED           = 7656,  -- You record your hunt.
        OBTAIN_SCYLDS           = 7658,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED           = 7662,  -- Hunt canceled.
        WYATT_DIALOG            = 11088, -- Ahhh, sorry, sorry. The name's Wyatt, an' I be an armor merchant from Jeuno. Ended up 'ere in San d'Oria some way or another, though.
        HOMEPOINT_SET           = 11118, -- Home point set!
        ITEM_DELIVERY_DIALOG    = 11219, -- If'n ye have goods tae deliver, then Nembet be yer man!
        ACHTELLE_FROM_ADOULIN   = 11269, -- I go by the name Achtelle. I hail from Adoulin Isle. Word has reached there that the dragoons and their wyverns have long since disappeared from these eastern lands. Tell me, is it true?
        NOTHING_OUT_OF_ORDINARY = 11749, -- You find nothing out of the ordinary.
        TOO_BUSY                = 11753, -- I am far too busy to speak with you now. Perhaps I'll have a little time later.
        RINGING_OF_STEEL        = 11803, -- Hah hah hah! The ringing of steel upon steel! The dripping stench of the battlefield! What could be better than war? The nobles can have their balls, I'll do my dance on the front lines!
        BASEBORN_PEASANT        = 11804, -- How dare a baseborn peasant raise ≺Multiple Choice (Player Gender)≻[his/her] voice to a noble knight!? Begone, before I strike you down myself!
        KINGDOMS_DEFEAT         = 11805, -- The Kingdom's defeat at Jugner still stings. To avenge the souls of those lost on that fateful day, we must join hands and take up arms as one.
        NOT_ONCE_IN_400_YEARS   = 11806, -- Not once in the four hundred years since the dawn of the Royal Knights has the Kingdom found itself in such peril. Let us take up our pikes and stand our ground to ensure another four centuries of prosperity!
        HOLY_DOCTRINES_PROHIBIT = 11808, -- While our holy doctrines specifically prohibit the taking of another life, you need not hesitate on the battlefield. The Church has branded the beastmen enemies of Altana. The purification must begin! It is the will of the Goddess!!!
        YEARS_OF_TRAINING       = 11809, -- After years of training in the Far East, I return only to find my nation burning at the hands of the infernal beastman hordes. The heathens shall pay dearly... My work has only just begun
        FINE_WARRIOR            = 11810, -- You have the look of a fine warrior. It is a pity you are not one of my Crimson Wolves.
        EYES_OF_THE_GODDESS     = 11811, -- The eyes of the Goddess are ever upon us. We must remain steadfast against the evils from without, as well as those from within.
        DISTANCE_YOURSELF       = 11257, -- I advise you distance yourself from Lady Ulla. I know not your intentions, but am inclined to believe they are crooked
        ONE_OF_THESE_CITIES     = 11260, -- So this is one of these “cities” I've heard so much of, is it? Hmph. Seems to be nothing more than a mass of people crowded into a noisy, confined space.
        ACHTELLE_FROM_ADOULIN   = 11269, -- I go by the name Achtelle. I hail from Adoulin Isle. Word has reached there that the dragoons and their wyverns have long since disappeared from these eastern lands. Tell me, is it true?
        ALLIED_SIGIL            = 12920, -- You have received the Allied Sigil!
        DOOR_IS_FIRMLY_LOCKED   = 13546, -- The door is firmly locked...
        RETRIEVE_DIALOG_ID      = 15583, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL   = 15657, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.SOUTHERN_SAN_DORIA_S]
