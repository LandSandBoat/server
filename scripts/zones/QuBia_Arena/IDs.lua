-----------------------------------
-- Area: QuBia_Arena
-----------------------------------
zones = zones or {}

zones[xi.zone.QUBIA_ARENA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        LOST_KEYITEM                  = 6395, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7068, -- Tallying conquest results...
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7232, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7247, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7250, -- A mysterious force is sealing the platform.
        TESTIMONY_IS_TORN             = 7290, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7291, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7538, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7539, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7541, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7542, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7543, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7577, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7584, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 7604, -- Entering the battlefield for [The Rank 5 Mission/Come Into My Parlor/E-vase-ive Action/Infernal Swarm/The Heir to the Light/Shattering Stars (PLD)/Shattering Stars (DRK)/Shattering Stars (BRD)/Demolition Squad/Die by the Sword/Let Sleeping Dogs Die/Brothers D'Aurphe/Undying Promise/Factory Rejects/Idol Thoughts/An Awful Autopsy/Celery/Mirror Images/A Furious Finale/Clash of the Comrades/Those Who Lurk in Shadows/Beyond Infinity/Factory Rejects/Demolition Squad/Brothers D'Aurphe/Mumor's Encore]!
        FLAT_PREPARE                  = 7643, -- I am Trion, of San d'Oria!
        FLAT_LAND                     = 7644, -- Feel the fire of my forefathers!
        RLB_PREPARE                   = 7645, -- The darkness before me that shrouds the light of good...
        RLB_LAND                      = 7646, -- ...Return to the hell you crawled out from!
        SAVAGE_PREPARE                = 7647, -- The anger, the pain, and the will to survive... Let the spirit of San d'Oria converge within this blade.
        SAVAGE_LAND                   = 7648, -- And with this blade I will return the glory to my kingdom's people!
        YOU_DECIDED_TO_SHOW_UP        = 7649, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY   = 7650, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY         = 7651, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS   = 7652, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER  = 7653, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP         = 7654, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING   = 7655, -- Ungh... That'll hurt in the morning...
        HAUNT_YOUR_SOUL               = 7677, -- I will haunt you until your soul rots to nothingness!
        FALL_TO_ALTANA                = 7678, -- And once again, I fall to the sons of Altana...
        ETERNAL_DAMNATION             = 7679, -- Death is only another step in the eternal damnation of your soul!
        SPILLING_BLOOD                = 7680, -- The spilling of my ethereal blood serves only to kindle the malignant flame of hate in your diseased soul.
        SOUL_GEM_REACTS               = 8010, -- The <keyitem> reacts to the <keyitem>, sending a jolt of energy through your veins!
        PROMISE_ME_YOU_WONT_GO_DOWN   = 8025, -- Promise you won't go down too easy, okay?
        IM_JUST_GETTING_WARMED_UP     = 8026, -- Haha! I'm just getting warmed up!
        YOU_PACKED_MORE_OF_A_PUNCH    = 8027, -- Hah! You pack more of a punch than I thoughtaru. But I won't go down as easy as old Maat!
        WHATS_THIS_STRANGE_FEELING    = 8028, -- What's this strange feeling...? It's not supposed to end...like...
        HUH_IS_THAT_ALL               = 8029, -- Huh? Is that all? I haven't even broken a sweataru...
        YIKEY_WIKEYS                  = 8030, -- Yikey-wikeys! Get that thing away from meee!
        WHATS_THE_MATTARU             = 8031, -- <Pant, wheeze>... What's the mattaru, <name>? Too much of a pansy-wansy to fight fair?
    },

    mob =
    {
        ARCHLICH_TABERQUOAN      = GetFirstID('Archlich_Taberquoan'),
        ATORI_TUTORI             = GetFirstID('Atori-Tutori_qm'),
        CHAHNAMEEDS_STOMACH      = GetFirstID('Chahnameeds_Stomach'),
        DOLL_FACTORY             = GetFirstID('Doll_Factory'),
        FIRE_POT                 = GetFirstID('Fire_Pot'),
        GHUL_I_BEABAN            = GetFirstID('Ghul-I-Beaban'),
        GLADIATORIAL_WEAPON      = GetFirstID('Gladiatorial_Weapon'),
        MAAT                     = GetFirstID('Maat'),
        NEPHIYL_RAMPARTBREACHER  = GetFirstID('Nephiyl_Rampartbreacher'),
        SEED_ORC                 = GetFirstID('Seed_Orc'),
        VAICOLIAUX_B_DAURPHE     = GetFirstID('Vaicoliaux_B_DAurphe'),
        WARLORD_ROJGNOJ          = GetFirstID('Warlord_Rojgnoj'),
    },

    npc =
    {
    },
}

return zones[xi.zone.QUBIA_ARENA]
