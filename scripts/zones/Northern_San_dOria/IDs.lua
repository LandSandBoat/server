-----------------------------------
-- Area: Northern_San_dOria
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.NORTHERN_SAN_DORIA] =
{
    text =
    {
        YOU_ACCEPT_THE_MISSION        = 5,     -- You accept the mission.
        ORIGINAL_MISSION_OFFSET       = 16,    -- Bring me one of those axes, and your mission will be a success. No running away now; we've a proud country to defend!
        HOMEPOINT_SET                 = 188,   -- Home point set!
        ITEM_CANNOT_BE_OBTAINED       = 6592,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        DEFAULT_CANNOT_BE_OBTAINED    = 6594,  -- You cannot obtain the item. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6598,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6599,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6601,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6602,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6603,  -- You do not have enough gil.
        REPORT_TO_CAIT_SITH           = 6628,  -- You have obtained all of Lilisette's memory fragments. Make haste and report to Cait Sith.
        CARRIED_OVER_POINTS           = 6637,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6638,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6639,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6659,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 6661,  -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO       = 6662,  -- You are now able to call multiple alter egos.
        MOG_LOCKER_OFFSET             = 6845,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        IMAGE_SUPPORT                 = 6969,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT      = 6983,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT            = 6991,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE           = 6998,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                   = 7003,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP            = 7004,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN            = 7020,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        CONQUEST_BASE                 = 7274,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7433,  -- You can't fish here.
        REGIME_CANCELED               = 7984,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 8002,  -- Hunt accepted!
        USE_SCYLDS                    = 8003,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 8014,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 8016,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 8020,  -- Hunt canceled.
        WHAT_DO_YOU_WANT              = 11148, -- What do you want?
        FFR_GUILBERDRIER              = 11161, -- A magic shop, you say? A bit of magic would come in handy... I know! I'll have my daughter study it for me!
        AILBECHE_FATHER_WHERE         = 11187, -- Oh, Father! Where are you?
        ABIOLEGET_DIALOG              = 11237, -- All of Altana's children are welcome here.
        PELLIMIE_DIALOG               = 11238, -- Is this your first time here? Join us in prayer!
        FITTESEGAT_DIALOG             = 11239, -- Paradise is a place without fear, without death!
        MAURINE_DIALOG                = 11240, -- Papsque Shamonde sometimes addresses the city from the balcony, you know. I long for his blessing, if but once!
        PRERIVON_DIALOG               = 11241, -- With each sermon, I take another step closer to Paradise.
        MALFINE_DIALOG                = 11242, -- Truly fortunate are we that words of sacrament are read every day!
        COULLENE_DIALOG               = 11243, -- Goddess above, deliver us to Paradise!
        ABIOLEGET_PEAS                = 11259, -- I will provide you with <item> for a pittance of <num> gil.
        OLBERGIEUT_DIALOG             = 11285, -- Friar Faurbellant is on retreat at the Crag of Holla. Please give <item> to him.
        ABEAULE_DIALOG_HOME           = 11341, -- Amaura makes her home on Watchdog Alley. If you can't find her, ask someone along the way. I'll be waiting here!
        ABEAULE_DIALOG_THANKS         = 11343, -- You've been a great help, again. I don't know how to thank you!
        GUILERME_DIALOG               = 11357, -- Behold Chateau d'Oraguille, the greatest fortress in the realm!
        BACHERUME_DIALOG              = 11358, -- You stand before Chateau d'Oraguille. If you have no business here, begone!
        PHAVIANE_DIALOG               = 11361, -- This is Victory Arch. Beyond lies Southern San d'Oria.
        SOCHIENE_DIALOG               = 11362, -- You stand before Victory Arch. Southern San d'Oria is on the other side.
        PEPIGORT_DIALOG               = 11363, -- This gate leads to Port San d'Oria.
        RODAILLECE_DIALOG             = 11364, -- This is Ranperre Gate. Fiends lurk in the lands beyond, so take caution!
        GALAHAD_DIALOG                = 11377, -- Welcome to the Consulate of Jeuno. I am Galahad, Consul to San d'Oria.
        ISHWAR_DIALOG                 = 11378, -- May I assist you?
        ARIENH_DIALOG                 = 11379, -- If you have business with Consul Galahad, you'll find him inside.
        EMILIA_DIALOG                 = 11380, -- Welcome to the Consulate of Jeuno.
        HERE_WITH_BUSINESS            = 11384, -- You're here with business from the administration, correct? I believe you should talk to Consul Helaku.
        HELAKU_DIALOG                 = 11409, -- Leave this building, and you'll see a great fortress to the right. That's Chateau d'Oraguille. And be polite; San d'Orians can be quite touchy.
        KASARORO_DIALOG               = 11448, -- Step right outside, and you'll see a big castle on the left. That's Chateau d'Oraguille. They're a little touchy in there, so mind your manners!
        PICKPOCKET_AUREGE             = 11477, -- A pickpocket, you say? Come to think of it, I did see a scoundrel skulking about...
        PICKPOCKET_GUILBERDRIER       = 11479, -- A pickpocket? No, can't say I've seen anyone like that. I'll keep an eye out, though.
        PICKPOCKET_PEPIGORT           = 11483, -- A pickpocket? Hey, I wonder if you mean that lady running helter-skelter over there just now...
        PICKPOCKET_GILIPESE           = 11484, -- A pickpocket? I did just see an undignified sort of woman just now. She was running toward Ranperre Gate.
        MAURINNE_DIALOG               = 11485, -- This part of town is so lively, I like watching everybody just go about their business.
        PICKPOCKET_MAURINNE           = 11486, -- A pickpocket?
        PICKPOCKET_RODAILLECE         = 11488, -- A pickpocket? Maybe it was that foul-mouthed woman just now. She called me a spoony bard! Unthinkable!
        AIVEDOIR_DIALOG               = 11519, -- That's funny. I could have sworn she asked me to meet her here...
        CAPIRIA_DIALOG                = 11520, -- He's late! I do hope he hasn't forgotten.
        BERTENONT_DIALOG              = 11521, -- Stars are more beautiful up close. Don't you agree?
        GILIPESE_DIALOG               = 11542, -- Nothing to report!
        DOGGOMEHR_SHOP_DIALOG         = 11555, -- Welcome to the Blacksmiths' Guild shop.
        LUCRETIA_SHOP_DIALOG          = 11556, -- Blacksmiths' Guild shop, at your service!
        CAUZERISTE_SHOP_DIALOG        = 11623, -- Welcome! San d'Oria Carpenters' Guild shop, at your service.
        THE_EMISSARY_PLACEHOLDER      = 11630, -- I'm glad you brought a letter of introduction, but you haven't finished your duty to Consul Melek yet. You'll need to come back once that's out of the way.
        ANTONIAN_OPEN_DIALOG          = 11638, -- Interested in goods from Aragoneu?
        BONCORT_SHOP_DIALOG           = 11639, -- Welcome to the Phoenix Perch!
        PIRVIDIAUCE_SHOP_DIALOG       = 11640, -- Care to see what I have?
        PALGUEVION_OPEN_DIALOG        = 11641, -- I've got a shipment straight from Valdeaunia!
        VICHUEL_OPEN_DIALOG           = 11642, -- Fauregandi produce for sale!
        ARLENNE_SHOP_DIALOG           = 11643, -- Welcome to the Royal Armory!
        TAVOURINE_SHOP_DIALOG         = 11644, -- Looking for a weapon? We've got many in stock!
        JUSTI_SHOP_DIALOG             = 11646, -- Hello!
        ANTONIAN_CLOSED_DIALOG        = 11648, -- The Kingdom's influence is waning in Aragoneu. I cannot import goods from that region, though I long to.
        PALGUEVION_CLOSED_DIALOG      = 11649, -- Would that Valdeaunia came again under San d'Orian dominion, I could then import its goods!
        VICHUEL_CLOSED_DIALOG         = 11650, -- I'd make a killing selling Fauregandi produce here, but that region's not under San d'Orian control!
        ATTARENA_CLOSED_DIALOG        = 11651, -- Once all of Li'Telor is back under San d'Orian influence, I'll fill my stock with unique goods from there!
        EUGBALLION_CLOSED_DIALOG      = 11652, -- I'd be making a fortune selling goods from Qufim Island...if it were only under San d'Orian control!
        EUGBALLION_OPEN_DIALOG        = 11653, -- Have a look at these goods imported direct from Qufim Island!
        CHAUPIRE_SHOP_DIALOG          = 11654, -- San d'Orian woodcraft is the finest in the land!
        CONQUEST                      = 11720, -- You've earned conquest points!
        FFR_BONCORT                   = 12067, -- Hmm... With magic, I could get hold of materials a mite easier. I'll have to check this mart out.
        FFR_CAPIRIA                   = 12068, -- A flyer? For me? Some reading material would be a welcome change of pace, indeed!
        FFR_VILLION                   = 12069, -- Opening a shop of magic, without consulting me first? I must pay this Regine a visit!
        FFR_COULLENE                  = 12070, -- Magic could be of use on my journey to Paradise. Thank you so much!
        FLYER_ACCEPTED                = 12071, -- Your flyer is accepted!
        FLYER_ALREADY                 = 12072, -- This person already has a flyer.
        MOGHOUSE_EXIT                 = 12371, -- You have learned your way through the back alleys of San d'Oria! Now you can exit to any area from your residence.
        AILBECHE_WHEN_FISHING         = 12391, -- Oh, when will my father take me fishing...
        AILBECHE_TRADE_FISH           = 12456, -- What? You caught the big one? Amazing! I doubt I could have done the same.
        OH_I_WANT_MY_ITEM             = 12630, -- Oh, I want my <item>.
        GAUDYLOX_SHOP_DIALOG          = 12631, -- <Phssshooooowoooo> You never see Goblinshhh from underworld? Me no bad. Me sell chipshhh. You buy. Use with shhhtone heart. You get lucky!
        MILLECHUCA_CLOSED_DIALOG      = 12632, -- I've been trying to import goods from Vollbow, but it's so hard to get items from areas that aren't under San d'Orian control.
        ATTARENA_OPEN_DIALOG          = 12717, -- Good day! Take a look at my selection from Li'Telor!
        MILLECHUCA_OPEN_DIALOG        = 12718, -- Specialty goods from Vollbow! Specialty goods from Vollbow!
        SHIVA_UNLOCKED                = 12816, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        ARACHAGNON_SHOP_DIALOG        = 12920, -- Would you be interested in purchasing some adventurer-issue armor? Be careful when selecting, as we accept no refunds.
        TRICK_OR_TREAT                = 13063, -- Trick or treat...
        THANK_YOU_TREAT               = 13064, -- Thank you... And now for your treat...
        HERE_TAKE_THIS                = 13065, -- Here, take this...
        IF_YOU_WEAR_THIS              = 13066, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                     = 13067, -- Thank you...
        FFR_LOOKS_CURIOUSLY_BASE      = 13391, -- Coullene looks over curiously for a moment.
        FRAGMENT_FAR_TOO_SMALL        = 18099, -- You obtain <keyitem>. However, it is far too small to house an adequate amount of energy. Alone, it serves no purpose.
        FRAGMENTS_MELD                = 18100, -- The tiny fragments of Lilisette's memory meld together to form <keyitem>!
        RETRIEVE_DIALOG_ID            = 18135, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL         = 18481, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        MAP_MARKER_TUTORIAL           = 18603, -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        -- Starlight Celebration Dialog --
        GIFT_THANK_YOU           = 13400, -- Thank you! Thank you! Thank you!
        GIFT_THANK_YOU_2         = 13401, -- Whoa! Thanks (Player Gender)>[sir, lady]
        GIFT_THANK_YOU_3         = 13402, -- Thank you so very much, (Player Gender)>[sir, ma'am]
        ONLY_TWO_HANDS           = 13403, -- Another present? Sorry, but I only have two hands, (Player Gender)≻[Mr./Ms.] Adventurer!
        ANOTHER_PRESENT          = 13404, -- Wow! Another present! Ah... But I don't think I can carry all these home at once. Why don't you come back later?
        SCARY_PRESENT            = 13405, -- Hey, didn't you just give me a prrresent? You're starrrting to scare me, (Player Gender)>[sir, lady]...
        JUST_ACCEPTED_PRESENT    = 13406, -- I just accepted a gift from you, kind (Player Gender)>[sir, ma'am]. I could not possibly accept another.
        JOY_TO_CHILDREN          = 13407, -- You've brought joy to the children of Vana'diel!
        BARRELS_JOY_TO_CHILDREN  = 13408, -- You've brought barrelfuls of joy to the children of Vana'diel!
        STARLIGHT_CARD_1         = 13536, -- It's time once again for the Starlight Celebration!≺Prompt≻
        STARLIGHT_CARD_2         = 17787, -- Kupo ho ho! Merry Starlight! As with past celebrations, we've prepared a veritable mountain of presents for all adventurers, kupo.≺Prompt≻
        STARLIGHT_CARD_3         = 17795, -- We'd also appreciate your help in distributing cards, kupo. All you're required to do is deliver this card to the addressee. We're counting on you!≺Prompt≻
        STARLIGHT_CARD_4         = 17791, -- If you happen to forget who the card's recipient is, just show it to me, kupo.≺Prompt≻
        STARLIGHT_CARD_5         = 17790, -- You're truly a role model for all adventurers, kupo! Now then, we'd like you to take this card and give it to a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer.≺Prompt≻
        STARLIGHT_CARD_6         = 17783, -- Happy delivering, kupo!≺Prompt≻
        STARLIGHT_CARD_CHECK     = 17792, -- Let' see... This addressee of this card is a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer, kupo.≺Prompt≻
        STARLIGHT_CARD_RED       = 13542, -- Oh, I just remembered! I think that the cards are all addressed to people who are wearing red...≺Prompt≻
        STARLIGHT_CARD_WRONG     = 17793, -- Are you trying to pull a fast one, kupo!? This card isn't yours to give, nor is it addressed to you, so please take it back to where you found it.≺Prompt≻
        STARLIGHT_CARD_CONFIRM   = 17785, -- Here's a little something for your kindness.≺Prompt≻
        STARLIGHT_FAME_DIALOG    = 13559, -- ≺Multiple Choice (Parameter 1)≻[You haven't brought any happiness to the children!/You've done some good./You've done fairly well./You've made the children very happy!/You've brought lots of smiles!/You have the children bursting with glee!/The children love you!] ≺Multiple Choice (Parameter 1)≻[What a disappointment./You just need to give a little extra effort!/Keep it up!/You make a good smilebringer./Excellent work!/Stupendous job!/Even I think you're great!]≺Prompt≻
        STARLIGHT_VENDOR_MOOGLE  = 14211, -- Come one, come all, kupo!
        MERRYMAKER_TRADE         = 17654, -- Yum-yums for me? Gobbies remember...till your tummies go rumble-rumble again.
        MERRYMAKER_BLECH         = 17657, -- Blech. What this yucky thing? It makes me want upgut food. Take it away.
        MERRYMAKER_TOY           = 17646, -- Happy toy, happy toy, where be me happy toy?
        MERRYMAKER_TOY2          = 17647, -- Ev'ry girl, ev'ry boy, ev'rybody, happy toy! Me nose holes smell the joy, the joy from happy toy! Where cooould iiit beee?
        MERRYMAKER_WAHH          = 17649, -- Waaah! It you! You give yum-yums for me tum-tum. Good [boy, girl]!
        MERRYMAKER_GIVE          = 17650, -- Not for us, not for me? I give it back. Now you happy? Happy toy, happy toy, where be me happy toy?
        MERRYMAKER_NO            = 17651, -- No no no no no! Go away! Nose holes busy sniff for happy toy!
        MERRYMAKER_FRIEND        = 17653, -- You have friend you do? We gobbies have friend too.
        MERRYMAKER_NPC_RETURNED  = 17692, -- I see you've returned. Mmm...that's good news indeed. Thank you for the kindess you've shown me and my friend.
        MERRYMAKER_DEFAULT       = 17652, -- ...
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
        STARLIGHT_DECORATIONS =
        {
            [17723785] = 17723785,  -- Starlight Celebration Banner
            [17723786] = 17723786,  -- Starlight Celebration Banner
            [17723787] = 17723787,  -- Starlight Celebration Banner
            [17723788] = 17723788,  -- Starlight Celebration Tree
            [17723789] = 17723789,  -- Starlight Celebration Tree
            [17723790] = 17723790,  -- Starlight Celebration Tree
            [17723791] = 17723791,  -- Starlight Celebration Tree
            [17723792] = 17723792,  -- Starlight Celebration Tree
            [17723793] = 17723793,  -- Starlight Celebration Tree
            [17723794] = 17723794,  -- Starlight Celebration Tree
            [17723795] = 17723795,  -- Starlight Celebration Tree
            [17723796] = 17723796,  -- Starlight Celebration Tree
            [17723797] = 17723797,  -- Starlight Celebration Tree
            [17723798] = 17723798,  -- Starlight Celebration Tree
            [17723799] = 17723799,  -- Starlight Celebration Tree
            [17723800] = 17723800,  -- Starlight Celebration Tree
            [17723801] = 17723801,  -- Starlight Celebration Tree
            [17723802] = 17723802,  -- Starlight Celebration Tree
            [17723803] = 17723803,  -- Starlight Celebration Tree
            [17723804] = 17723804,  -- Starlight Celebration Tree
            [17723805] = 17723805,  -- Starlight Celebration Tree
            [17723784] = 17723784,  -- Charmealaut
            [17723807] = 17723807,  -- Token Moogle
            [17723808] = 17723808,  -- Event Moogle
            [17723809] = 17723809,  -- Vendor Moogle
            [17723810] = 17723810,  -- Vendor Moogle
            [17723812] = 17723812,  -- Event Moogle Stall
            [17723615] = 17723615,  -- Goblin Merrymaker
            [17723616] = 17723616,  -- Goblin Merrymaker
            [17723617] = 17723617,  -- Goblin Merrymaker
            [17723618] = 17723618,  -- Goblin Merrymaker
            [17723619] = 17723619,  -- Goblin Merrymaker
            [17723620] = 17723620,  -- Goblin Merrymaker
            [17723621] = 17723621,  -- Goblin Merrymaker
            [17723622] = 17723622,  -- Goblin Merrymaker
            [17723623] = 17723623,  -- Goblin Merrymaker
            [17723624] = 17723624,  -- Goblin Merrymaker
        },
        EXPLORER_MOOGLE = 17723648,
    },
}

return zones[xi.zone.NORTHERN_SAN_DORIA]
