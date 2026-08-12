-----------------------------------
-- Area: Balgas_Dais
-----------------------------------
zones = zones or {}

zones[xi.zone.BALGAS_DAIS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        LOST_KEYITEM                  = 6399, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7073, -- Tallying conquest results...
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7237, -- Your time in the battlefield is up! Now exiting...
        NO_BATTLEFIELD_ENTRY          = 7251, -- A cursed seal has been placed upon this platform.
        PARTY_MEMBERS_ARE_ENGAGED     = 7252, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        TESTIMONY_IS_TORN             = 7295, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7296, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7543, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7544, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7546, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7547, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7548, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7582, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7589, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 7610, -- Entering the battlefield for [The Rank 2 Final Mission/Steamed Sprouts/Divine Punishers/Saintly Invitation/Treasure and Tribulations/Shattering Stars (MNK)/Shattering Stars (WHM)/Shattering Stars (SMN)/Creeping Doom/Charming Trio/Harem Scarem/Early Bird Catches the Wyrm/Royal Succession/Rapid Raptors/Wild Wild Whiskers/Seasons Greetings/Royale Ramble/Moa Constrictors/The V Formation/Avian Apostates/Beyond Infinity/★Steamed Sprouts/★Divine Punishers/A Feast Most Dire/A.M.A.N. Trove (Mars)/A.M.A.N. Trove (Venus)/Inv. from Kupipi/Inv. from Kupipi and Co.]!
        YOU_DECIDED_TO_SHOW_UP        = 7656, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY   = 7657, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY         = 7658, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS   = 7659, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER  = 7660, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP         = 7661, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING   = 7662, -- Ungh... That'll hurt in the morning...
        WILD_WILD_WHISKERS_OFFSET     = 7680, -- Macan Gadangan's whiskers begin to twitch slightly.
        SOUL_GEM_REACTS               = 7685, -- The <keyitem> reacts to the <keyitem>, sending a jolt of energy through your veins!
        PROMISE_ME_YOU_WONT_GO_DOWN   = 7700, -- Promise you won't go down too easy, okay?
        IM_JUST_GETTING_WARMED_UP     = 7701, -- Haha! I'm just getting warmed up!
        YOU_PACKED_MORE_OF_A_PUNCH    = 7702, -- Hah! You pack more of a punch than I thoughtaru. But I won't go down as easy as old Maat!
        WHATS_THIS_STRANGE_FEELING    = 7703, -- What's this strange feeling...? It's not supposed to end...like...
        HUH_IS_THAT_ALL               = 7704, -- Huh? Is that all? I haven't even broken a sweataru...
        YIKEY_WIKEYS                  = 7705, -- Yikey-wikeys! Get that thing away from meee!
        WHATS_THE_MATTARU             = 7706, -- <Pant, wheeze>... What's the mattaru, <name>? Too much of a pansy-wansy to fight fair?
    },
    mob =
    {
        ATORI_TUTORI            = GetFirstID('Atori-Tutori_qm'),
        BUU_XOLO_THE_BLOODFACED = GetFirstID('Buu_Xolo_the_Bloodfaced'),
        DROMICEIOMIMUS          = GetFirstID('Dromiceiomimus'),
        DVOROVOI                = GetFirstID('Dvorovoi'),
        GILAGOGE_TLUGVI         = GetFirstID('Gilagoge_Tlugvi'),
        KING_OF_BATONS          = GetFirstID('King_of_Batons'),
        KING_OF_COINS           = GetFirstID('King_of_Coins'),
        KING_OF_CUPS            = GetFirstID('King_of_Cups'),
        KING_OF_SWORDS          = GetFirstID('King_of_Swords'),
        MAAT                    = GetFirstID('Maat_mnk'),
        VOO_TOLU_THE_GHOSTFIST  = GetFirstID('Voo_Tolu_the_Ghostfist'),
    },
    npc =
    {
    },
}

return zones[xi.zone.BALGAS_DAIS]
