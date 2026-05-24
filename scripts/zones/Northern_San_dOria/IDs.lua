-----------------------------------
-- Area: Northern_San_dOria
-----------------------------------
zones = zones or {}

zones[xi.zone.NORTHERN_SAN_DORIA] =
{
    text =
    {
        YOU_ACCEPT_THE_MISSION        = 5,     -- You accept the mission.
        ORIGINAL_MISSION_OFFSET       = 16,    -- Bring me one of those axes, and your mission will be a success. No running away now; we've a proud country to defend!
        HOMEPOINT_SET                 = 188,   -- Home point set!
        NOTHING_HAPPENS               = 327,   -- Nothing happens...
        ASSIST_CHANNEL                = 6588,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6593,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6601,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6602,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6604,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6605,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6606,  -- You do not have enough gil.
        REPORT_TO_CAIT_SITH           = 6631,  -- You have obtained all of Lilisette's memory fragments. Make haste and report to Cait Sith.
        CARRIED_OVER_POINTS           = 6640,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6641,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6642,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6662,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 6664,  -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO       = 6665,  -- You are now able to call multiple alter egos.
        MOG_LOCKER_OFFSET             = 6856,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        IMAGE_SUPPORT                 = 6994,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT      = 7008,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT            = 7016,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE           = 7023,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                   = 7028,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP            = 7029,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN            = 7045,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        CONQUEST_BASE                 = 7299,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7458,  -- You can't fish here.
        REGIME_CANCELED               = 8010,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 8028,  -- Hunt accepted!
        USE_SCYLDS                    = 8029,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 8040,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 8042,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 8046,  -- Hunt canceled.
        WHAT_DO_YOU_WANT              = 11174, -- What do you want?
        WHO_DOES_HE_THINK             = 11178, -- Who does he think he is, running off when we've piles of work to do! I'll give him a good lashing when he gets back!
        GAMBLING_IS_THE_RUIN          = 11179, -- Gambling is the ruin of many, I tell you...
        HE_WAS_JUST_HERE              = 11185, -- Eh? That gambler, Varchet? Aye, he was just here.
        FFR_GUILBERDRIER              = 11187, -- A magic shop, you say? A bit of magic would come in handy... I know! I'll have my daughter study it for me!
        YOU_DONATE_GIL                = 11196, -- You donate 10 gil.
        AILBECHE_FATHER_WHERE         = 11213, -- Oh, Father! Where are you?
        ABIOLEGET_DIALOG              = 11263, -- All of Altana's children are welcome here.
        PELLIMIE_DIALOG               = 11264, -- Is this your first time here? Join us in prayer!
        FITTESEGAT_DIALOG             = 11265, -- Paradise is a place without fear, without death!
        MAURINE_DIALOG                = 11266, -- Papsque Shamonde sometimes addresses the city from the balcony, you know. I long for his blessing, if but once!
        PRERIVON_DIALOG               = 11267, -- With each sermon, I take another step closer to Paradise.
        MALFINE_DIALOG                = 11268, -- Truly fortunate are we that words of sacrament are read every day!
        COULLENE_DIALOG               = 11269, -- Goddess above, deliver us to Paradise!
        WILL_PROVIDE_PITTANCE         = 11285, -- I will provide you with <item> for a pittance of <number> gil.
        OLBERGIEUT_DIALOG             = 11311, -- Friar Faurbellant is on retreat at the Crag of Holla. Please give <item> to him.
        ABEAULE_DIALOG_HOME           = 11367, -- Amaura makes her home on Watchdog Alley. If you can't find her, ask someone along the way. I'll be waiting here!
        ABEAULE_DIALOG_THANKS         = 11369, -- You've been a great help, again. I don't know how to thank you!
        GUILERME_DIALOG               = 11383, -- Behold Chateau d'Oraguille, the greatest fortress in the realm!
        YOU_STAND_BEFORE              = 11384, -- You stand before Chateau d'Oraguille. If you've no business here, begone!
        PHAVIANE_DIALOG               = 11387, -- This is Victory Arch. Beyond lies Southern San d'Oria.
        SOCHIENE_DIALOG               = 11388, -- You stand before Victory Arch. Southern San d'Oria is on the other side.
        PEPIGORT_DIALOG               = 11389, -- This gate leads to Port San d'Oria.
        RODAILLECE_DIALOG             = 11390, -- This is Ranperre Gate. Fiends lurk in the lands beyond, so take caution!
        GALAHAD_DIALOG                = 11403, -- Welcome to the Consulate of Jeuno. I am Galahad, Consul to San d'Oria.
        ISHWAR_DIALOG                 = 11404, -- May I assist you?
        ARIENH_DIALOG                 = 11405, -- If you have business with Consul Galahad, you'll find him inside.
        EMILIA_DIALOG                 = 11406, -- Welcome to the Consulate of Jeuno.
        HERE_WITH_BUSINESS            = 11410, -- You're here with business from the administration, correct? I believe you should talk to Consul Helaku.
        HELAKU_DIALOG                 = 11435, -- Leave this building, and you'll see a great fortress to the right. That's Chateau d'Oraguille. And be polite; San d'Orians can be quite touchy.
        KASARORO_DIALOG               = 11474, -- Step right outside, and you'll see a big castle on the left. That's Chateau d'Oraguille. They're a little touchy in there, so mind your manners!
        PICKPOCKET_AUREGE             = 11503, -- A pickpocket, you say? Come to think of it, I did see a scoundrel skulking about...
        PICKPOCKET_GUILBERDRIER       = 11505, -- A pickpocket? No, can't say I've seen anyone like that. I'll keep an eye out, though.
        PICKPOCKET_PEPIGORT           = 11509, -- A pickpocket? Hey, I wonder if you mean that lady running helter-skelter over there just now...
        PICKPOCKET_GILIPESE           = 11510, -- A pickpocket? I did just see an undignified sort of woman just now. She was running toward Ranperre Gate.
        MAURINNE_DIALOG               = 11511, -- This part of town is so lively, I like watching everybody just go about their business.
        PICKPOCKET_MAURINNE           = 11512, -- A pickpocket?
        PICKPOCKET_RODAILLECE         = 11514, -- A pickpocket? Maybe it was that foul-mouthed woman just now. She called me a spoony bard! Unthinkable!
        AIVEDOIR_DIALOG               = 11545, -- That's funny. I could have sworn she asked me to meet her here...
        CAPIRIA_DIALOG                = 11546, -- He's late! I do hope he hasn't forgotten.
        BERTENONT_DIALOG              = 11547, -- Stars are more beautiful up close. Don't you agree?
        ITS_LOCKED                    = 11556, -- It's locked.
        GILIPESE_DIALOG               = 11568, -- Nothing to report!
        DOGGOMEHR_SHOP_DIALOG         = 11581, -- Welcome to the Blacksmiths' Guild shop.
        LUCRETIA_SHOP_DIALOG          = 11582, -- Blacksmiths' Guild shop, at your service!
        CAUZERISTE_SHOP_DIALOG        = 11649, -- Welcome! San d'Oria Carpenters' Guild shop, at your service.
        THE_EMISSARY_PLACEHOLDER      = 11656, -- I'm glad you brought a letter of introduction, but you haven't finished your duty to Consul Melek yet. You'll need to come back once that's out of the way.
        ANTONIAN_OPEN_DIALOG          = 11664, -- Interested in goods from Aragoneu?
        BONCORT_SHOP_DIALOG           = 11665, -- Welcome to the Phoenix Perch!
        PIRVIDIAUCE_SHOP_DIALOG       = 11666, -- Care to see what I have?
        PALGUEVION_OPEN_DIALOG        = 11667, -- I've got a shipment straight from Valdeaunia!
        VICHUEL_OPEN_DIALOG           = 11668, -- Fauregandi produce for sale!
        ARLENNE_SHOP_DIALOG           = 11669, -- Welcome to the Royal Armory!
        TAVOURINE_SHOP_DIALOG         = 11670, -- Looking for a weapon? We've got many in stock!
        JUSTI_SHOP_DIALOG             = 11672, -- Hello!
        ANTONIAN_CLOSED_DIALOG        = 11674, -- The Kingdom's influence is waning in Aragoneu. I cannot import goods from that region, though I long to.
        PALGUEVION_CLOSED_DIALOG      = 11675, -- Would that Valdeaunia came again under San d'Orian dominion, I could then import its goods!
        VICHUEL_CLOSED_DIALOG         = 11676, -- I'd make a killing selling Fauregandi produce here, but that region's not under San d'Orian control!
        ATTARENA_CLOSED_DIALOG        = 11677, -- Once all of Li'Telor is back under San d'Orian influence, I'll fill my stock with unique goods from there!
        EUGBALLION_CLOSED_DIALOG      = 11678, -- I'd be making a fortune selling goods from Qufim Island...if it were only under San d'Orian control!
        EUGBALLION_OPEN_DIALOG        = 11679, -- Have a look at these goods imported direct from Qufim Island!
        CHAUPIRE_SHOP_DIALOG          = 11680, -- San d'Orian woodcraft is the finest in the land!
        CONQUEST                      = 11746, -- You've earned conquest points!
        FFR_BONCORT                   = 12093, -- Hmm... With magic, I could get hold of materials a mite easier. I'll have to check this mart out.
        FFR_CAPIRIA                   = 12094, -- A flyer? For me? Some reading material would be a welcome change of pace, indeed!
        FFR_VILLION                   = 12095, -- Opening a shop of magic, without consulting me first? I must pay this Regine a visit!
        FFR_COULLENE                  = 12096, -- Magic could be of use on my journey to Paradise. Thank you so much!
        FLYER_ACCEPTED                = 12097, -- Your flyer is accepted!
        FLYER_ALREADY                 = 12098, -- This person already has a flyer.
        MOGHOUSE_EXIT                 = 12397, -- You have learned your way through the back alleys of San d'Oria! Now you can exit to any area from your residence.
        AILBECHE_WHEN_FISHING         = 12417, -- Oh, when will my father take me fishing...
        OH_I_WANT_MY_ITEM             = 12656, -- Oh, I want my <item>.
        GAUDYLOX_SHOP_DIALOG          = 12657, -- <Phssshooooowoooo> You never see Goblinshhh from underworld? Me no bad. Me sell chipshhh. You buy. Use with shhhtone heart. You get lucky!
        MILLECHUCA_CLOSED_DIALOG      = 12658, -- I've been trying to import goods from Vollbow, but it's so hard to get items from areas that aren't under San d'Orian control.
        ATTARENA_OPEN_DIALOG          = 12743, -- Good day! Take a look at my selection from Li'Telor!
        MILLECHUCA_OPEN_DIALOG        = 12744, -- Specialty goods from Vollbow! Specialty goods from Vollbow!
        SHIVA_UNLOCKED                = 12845, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        ARACHAGNON_SHOP_DIALOG        = 12952, -- Would you be interested in purchasing some adventurer-issue armor? Be careful when selecting, as we accept no refunds.
        TRICK_OR_TREAT                = 13095, -- Trick or treat...
        THANK_YOU_TREAT               = 13096, -- Thank you... And now for your treat...
        HERE_TAKE_THIS                = 13097, -- Here, take this...
        IF_YOU_WEAR_THIS              = 13098, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                     = 13099, -- Thank you...
        EGG_HUNT_OFFSET               = 13134, -- Egg-cellent! Here's your prize, kupo! Now if only somebody would bring me a super combo... Oh, egg-scuse me! Forget I said that, kupo!
        FFR_LOOKS_CURIOUSLY_BASE      = 13423, -- Coullene looks over curiously for a moment.
        FRAGMENT_FAR_TOO_SMALL        = 18143, -- You obtain <keyitem>. However, it is far too small to house an adequate amount of energy. Alone, it serves no purpose.
        FRAGMENTS_MELD                = 18144, -- The tiny fragments of Lilisette's memory meld together to form <keyitem>!
        RETRIEVE_DIALOG_ID            = 18179, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL         = 18525, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        MAP_MARKER_TUTORIAL           = 18647, -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        LINK_CONCIERGE_GOODBYE        = 19287, -- It was my pleasure to meet with you this fine day. May you encounter many friendly faces throughout your travels.
        LINK_CONCIERGE_ONE_PER_DAY    = 19291, -- In the interest of fairness, I am unable to distribute multiple linkpearls to someone on the same day. Please come back tomorrow.
        LINK_CONCIERGE_REGISTERED     = 19348, -- Your registration is officially complete.
        LINK_CONCIERGE_REGISTERED_2   = 19349, -- May your journeys lead you to many as-yet-unmet friends, and may the bonds you forge last a lifetime.
        LINK_CONCIERGE_LS_TAKEN       = 19350, -- Another member of that linkshell currently has an active registration. Please wait until that registration expires and try again.
    },
    mob =
    {
    },
    npc =
    {
        HALLOWEEN_SKINS =
        {
            [17723487] = 53, -- Vichuel
            [17723492] = 52, -- Antonian
            [17723497] = 51, -- Attarena
        },
        EXPLORER_MOOGLE = GetFirstID('Explorer_Moogle'),
    },
}

return zones[xi.zone.NORTHERN_SAN_DORIA]
