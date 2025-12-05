-----------------------------------
-- Area: Waughroon_Shrine
-----------------------------------
zones = zones or {}

zones[xi.zone.WAUGHROON_SHRINE] =
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
        NO_BATTLEFIELD_ENTRY          = 7246, -- A cursed seal has been placed upon this platform.
        PARTY_MEMBERS_ARE_ENGAGED     = 7247, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        TESTIMONY_IS_TORN             = 7290, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7291, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7538, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7539, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7541, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7542, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7543, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7577, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7584, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 7605, -- Entering the battlefield for [The Rank 2 Final Mission/The Worm's Turn/Grimshell Shocktroopers/On My Way/A Thief in Norg!?/3, 2, 1.../Shattering Stars (RDM)/Shattering Stars (THF)/Shattering Stars (BST)/Birds of a Feather/Crustacean Conundrum/Grove Guardians/The Hills are Alive/Royal Jelly/The Final Bout/Up in Arms/Copycat/Operation Desert Swarm/Prehistoric Pigeons/The Palborough Project/Shell Shocked/Beyond Infinity/The Worm's Tail/Grimshell Shocktroopers/A Feast Most Dire/A.M.A.N. Trove (Mars)/A.M.A.N. Trove (Venus)/Invitation from Naji/Invitation from Naji and Co.]!
        COUNTDOWN_OFFSET              = 7689, -- 60......
        YOU_DECIDED_TO_SHOW_UP        = 7698, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY   = 7699, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY         = 7700, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS   = 7701, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER  = 7702, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP         = 7703, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING   = 7704, -- Ungh... That'll hurt in the morning...
        ONE_TENTACLE_WOUNDED          = 7722, -- One of the sea creature's tentacles have been wounded.
        ALL_TENTACLES_WOUNDED         = 7723, -- All of the sea creature's tentacles have been wounded.
        SCORPION_IS_STUNNED           = 7724, -- The platoon scorpion does not have enough energy to attack!
        SCORPION_IS_BOUND             = 7725, -- The platoon scorpion's legs are lodged in the rocks!
        SOUL_GEM_REACTS               = 7726, -- The <keyitem> reacts to the <keyitem>, sending a jolt of energy through your veins!
        PROMISE_ME_YOU_WONT_GO_DOWN   = 7741, -- Promise you won't go down too easy, okay?
        IM_JUST_GETTING_WARMED_UP     = 7742, -- Haha! I'm just getting warmed up!
        YOU_PACKED_MORE_OF_A_PUNCH    = 7743, -- Hah! You pack more of a punch than I thoughtaru. But I won't go down as easy as old Maat!
        WHATS_THIS_STRANGE_FEELING    = 7744, -- What's this strange feeling...? It's not supposed to end...like...
        HUH_IS_THAT_ALL               = 7745, -- Huh? Is that all? I haven't even broken a sweataru...
        YIKEY_WIKEYS                  = 7746, -- Yikey-wikeys! Get that thing away from meee!
        WHATS_THE_MATTARU             = 7747, -- <Pant, wheeze>... What's the mattaru, <name>? Too much of a pansy-wansy to fight fair?
    },

    mob =
    {
        ATORI_TUTORI      = GetFirstID('Atori-Tutori_qm'),
        FLAYER_FRANZ      = GetFirstID('Flayer_Franz'),
        GAKI              = GetFirstID('Gaki'),
        KUJHU_GRANITESKIN = GetFirstID('KuJhu_Graniteskin'),
        MAAT              = GetFirstID('Maat'),
        METSANNEITSYT     = GetFirstID('Metsanneitsyt'),
        OSSCHAART         = GetFirstID('Osschaart'),
        PLATOON_SCORPION  = GetFirstID('Platoon_Scorpion'),
        QUEEN_JELLY       = GetFirstID('Queen_Jelly'),
        TIME_BOMB         = GetFirstID('Time_Bomb'),
        YOBHU_HIDEOUSMASK = GetFirstID('YoBhu_Hideousmask'),
    },

    npc =
    {
    },
}

return zones[xi.zone.WAUGHROON_SHRINE]
