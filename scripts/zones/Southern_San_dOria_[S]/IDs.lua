-----------------------------------
-- Area: Southern_San_dOria_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.SOUTHERN_SAN_DORIA_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        CANNOT_OBTAIN_MYSTIC          = 6387,  -- You cannot obtain the <item>. Speak with the mystic retriever after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        BONDS_STRENGTHENED            = 7046,  -- The bonds tying you to Altana have strengthened, enabling you to experience all the memories of [Rise of the Zilart/Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin]!
        GATE_IS_LOCKED                = 7107,  -- The gate is locked.
        DONT_HURT_GELTPIX             = 7110,  -- Don't hurt poor Geltpix! Geltpix's just a merchant from Boodlix's Emporium in Jeuno. Kingdom vendors don't like gil, but Boodlix knows true value of new money.
        MOG_LOCKER_OFFSET             = 7377,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED               = 7634,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 7652,  -- Hunt accepted!
        USE_SCYLDS                    = 7653,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 7664,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 7666,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 7670,  -- Hunt canceled.
        WYATT_DIALOG                  = 11096, -- Ahhh, sorry, sorry. The name's Wyatt, an' I be an armor merchant from Jeuno. Ended up 'ere in San d'Oria some way or another, though.
        HOMEPOINT_SET                 = 11126, -- Home point set!
        ITEM_DELIVERY_DIALOG          = 11227, -- If'n ye have goods tae deliver, then Nembet be yer man!
        DISTANCE_YOURSELF             = 11265, -- I advise you distance yourself from Lady Ulla. I know not your intentions, but am inclined to believe they are crooked.
        ONE_OF_THESE_CITIES           = 11268, -- So this is one of these cities I've heard so much of, is it? Hmph. Seems to be nothing more than a mass of people crowded into a noisy, confined space.
        ACHTELLE_FROM_ADOULIN         = 11277, -- I go by the name Achtelle. I hail from Adoulin Isle. Word has reached there that the dragoons and their wyverns have long since disappeared from these eastern lands. Tell me, is it true?
        NOTHING_OUT_OF_ORDINARY       = 11757, -- You find nothing out of the ordinary.
        TOO_BUSY                      = 11761, -- I am far too busy to speak with you now. Perhaps I'll have a little time later.
        RINGING_OF_STEEL              = 11811, -- Hah hah hah! The ringing of steel upon steel! The dripping stench of the battlefield! What could be better than war? The nobles can have their balls, I'll do my dance on the front lines!
        BASEBORN_PEASANT              = 11812, -- How dare a baseborn peasant raise [his/her] voice to a noble knight!? Begone, before I strike you down myself!
        KINGDOMS_DEFEAT               = 11813, -- The Kingdom's defeat at Jugner still stings. To avenge the souls of those lost on that fateful day, we must join hands and take up arms as one.
        NOT_ONCE_IN_400_YEARS         = 11814, -- Not once in the four hundred years since the dawn of the Royal Knights has the Kingdom found itself in such peril. Let us take up our pikes and stand our ground to ensure another four centuries of prosperity!
        HOLY_DOCTRINES_PROHIBIT       = 11816, -- While our holy doctrines specifically prohibit the taking of another life, you need not hesitate on the battlefield. The Church has branded the beastmen enemies of Altana. The purification must begin! It is the will of the Goddess!!!
        YEARS_OF_TRAINING             = 11817, -- After years of training in the Far East, I return only to find my nation burning at the hands of the infernal beastman hordes. The heathens shall pay dearly... My work has only just begun.
        FINE_WARRIOR                  = 11818, -- You have the look of a fine warrior. It is a pity you are not one of my Crimson Wolves.
        EYES_OF_THE_GODDESS           = 11819, -- The eyes of the Goddess are ever upon us. We must remain steadfast against the evils from without, as well as those from within.
        CAMPAIGN_RESULTS_TALLIED      = 11925, -- Campaign results tallied.
        NOW_ALLIED_WITH               = 12153, -- You are now a member of the [/Knights of the Iron Ram/Republican Legion's Fourth Division/Cobra Unit]!
        ALLIED_SIGIL                  = 12928, -- You have received the Allied Sigil!
        DOOR_IS_FIRMLY_LOCKED         = 13554, -- The door is firmly locked...
        LUROUILLAT_TURN_IN            = 13661, -- Just as we suspected. This contains a great deal of information that will prove vital to our cause. Hm, what's this? Not sure what to make of this... Doesn't seem to be terribly important. Here, why don't you hang onto it? See if you can't get some use out of it down the road.
        CONCERNED_FOR_WOUNDED         = 13683, -- Concerned for the wounded Sir Ragelise, Lilisette and Portia have been paying him regular visits as of late. Alexei Mayakov suggests that the Chateau d'Oraguille is where the two of them are likely to be.
        MUST_GATHER_SIGNATURES        = 14013, -- You must gather signatures from at least <number> knights of the Kingdom.
        CURRENT_PETITIONS             = 14014, -- Current <keyitem>: <number>.
        HAVE_GATHERED_SIGNATURE       = 14285, -- You have gathered <number> [signature/signatures] for the <keyitem>!
        GATHERED_DAWNDROPS_LIGHT      = 14541, -- The gathered dawndrops unleash a brilliant light, melding together to form <keyitem>!
        RETRACED_ALL_JUNCTIONS        = 14542, -- You have retraced all junctions of eventualities. Hasten back to where Cait Sith and Lilisette await.
        RETRIEVE_DIALOG_ID            = 15595, -- You retrieve <item> from the porter moogle's care.
        NOT_ENOUGH_NOTES              = 15620, -- You tryin' to cheat me? That's not nearly enough notes!
        COMMON_SENSE_SURVIVAL         = 15669, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Saphiriance_TK'), -- San, Bas, Win, Flag +4, CA
        SHIXO               = 17105699,
    },
}

return zones[xi.zone.SOUTHERN_SAN_DORIA_S]
