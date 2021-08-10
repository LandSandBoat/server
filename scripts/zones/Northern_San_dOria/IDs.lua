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
        YOU_ACCEPT_THE_MISSION   = 5,     -- You accept the mission.
        ORIGINAL_MISSION_OFFSET  = 16,    -- Bring me one of those axes, and your mission will be a success. No running away now; we've a proud country to defend!
        HOMEPOINT_SET            = 188,   -- Home point set!
        ITEM_CANNOT_BE_OBTAINED  = 6591,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6597,  -- Obtained: <item>.
        GIL_OBTAINED             = 6598,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6600,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6601,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL      = 6602,  -- You do not have enough gil.
        CARRIED_OVER_POINTS      = 6636,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 6637,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 6638,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOU_LEARNED_TRUST        = 6660,  -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO  = 6661,  -- You are now able to call multiple alter egos.
        MOG_LOCKER_OFFSET        = 6838,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        IMAGE_SUPPORT            = 6962,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT = 6976,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT       = 6984,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE      = 6991,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED              = 6996,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP       = 6997,  -- You do not have enough guild points.
        CONQUEST_BASE            = 7267,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7426,  -- You can't fish here.
        REGIME_CANCELED          = 7977,  -- Current training regime canceled.
        HUNT_ACCEPTED            = 7995,  -- Hunt accepted!
        USE_SCYLDS               = 7996,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED            = 8007,  -- You record your hunt.
        OBTAIN_SCYLDS            = 8009,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED            = 8013,  -- Hunt canceled.
        WHAT_DO_YOU_WANT         = 11141, -- What do you want?
        FFR_GUILBERDRIER         = 11154, -- A magic shop, you say? A bit of magic would come in handy... I know! I'll have my daughter study it for me!
        AILBECHE_FATHER_WHERE    = 11180, -- Oh, Father! Where are you?
        ABIOLEGET_DIALOG         = 11230, -- All of Altana's children are welcome here.
        PELLIMIE_DIALOG          = 11231, -- Is this your first time here? Join us in prayer!
        FITTESEGAT_DIALOG        = 11232, -- Paradise is a place without fear, without death!
        MAURINE_DIALOG           = 11233, -- Papsque Shamonde sometimes addresses the city from the balcony, you know. I long for his blessing, if but once!
        PRERIVON_DIALOG          = 11234, -- With each sermon, I take another step closer to Paradise.
        MALFINE_DIALOG           = 11235, -- Truly fortunate are we that words of sacrament are read every day!
        COULLENE_DIALOG          = 11236, -- Goddess above, deliver us to Paradise!
        OLBERGIEUT_DIALOG        = 11278, -- Friar Faurbellant is on retreat at the Crag of Holla. Please give <item> to him.
        ABEAULE_DIALOG_HOME      = 11334, -- Amaura makes her home on Watchdog Alley. If you can't find her, ask someone along the way. I'll be waiting here!
        ABEAULE_DIALOG_THANKS    = 11336, -- You've been a great help, again. I don't know how to thank you!
        GUILERME_DIALOG          = 11350, -- Behold Chateau d'Oraguille, the greatest fortress in the realm!
        PHAVIANE_DIALOG          = 11354, -- This is Victory Arch. Beyond lies Southern San d'Oria.
        SOCHIENE_DIALOG          = 11355, -- You stand before Victory Arch. Southern San d'Oria is on the other side.
        PEPIGORT_DIALOG          = 11356, -- This gate leads to Port San d'Oria.
        RODAILLECE_DIALOG        = 11357, -- This is Ranperre Gate. Fiends lurk in the lands beyond, so take caution!
        GALAHAD_DIALOG           = 11370, -- Welcome to the Consulate of Jeuno. I am Galahad, Consul to San d'Oria.
        ISHWAR_DIALOG            = 11371, -- May I assist you?
        ARIENH_DIALOG            = 11372, -- If you have business with Consul Galahad, you'll find him inside.
        EMILIA_DIALOG            = 11373, -- Welcome to the Consulate of Jeuno.
        HERE_WITH_BUSINESS       = 11377, -- You're here with business from the administration, correct? I believe you should talk to Consul Helaku.
        HELAKU_DIALOG            = 11402, -- Leave this building, and you'll see a great fortress to the right. That's Chateau d'Oraguille. And be polite; San d'Orians can be quite touchy.
        KASARORO_DIALOG          = 11441, -- Step right outside, and you'll see a big castle on the left. That's Chateau d'Oraguille. They're a little touchy in there, so mind your manners!
        PICKPOCKET_AUREGE        = 11470, -- A pickpocket, you say? Come to think of it, I did see a scoundrel skulking about...
        PICKPOCKET_GUILBERDRIER  = 11472, -- A pickpocket? No, can't say I've seen anyone like that. I'll keep an eye out, though.
        PICKPOCKET_PEPIGORT      = 11476, -- A pickpocket? Hey, I wonder if you mean that lady running helter-skelter over there just now...
        PICKPOCKET_GILIPESE      = 11477, -- A pickpocket? I did just see an undignified sort of woman just now. She was running toward Ranperre Gate.
        MAURINNE_DIALOG          = 11478, -- This part of town is so lively, I like watching everybody just go about their business.
        PICKPOCKET_MAURINNE      = 11479, -- A pickpocket?
        PICKPOCKET_RODAILLECE    = 11481, -- A pickpocket? Maybe it was that foul-mouthed woman just now. She called me a spoony bard! Unthinkable!
        AIVEDOIR_DIALOG          = 11512, -- That's funny. I could have sworn she asked me to meet her here...
        CAPIRIA_DIALOG           = 11513, -- He's late! I do hope he hasn't forgotten.
        BERTENONT_DIALOG         = 11514, -- Stars are more beautiful up close. Don't you agree?
        GILIPESE_DIALOG          = 11535, -- Nothing to report!
        DOGGOMEHR_SHOP_DIALOG    = 11548, -- Welcome to the Blacksmiths' Guild shop.
        LUCRETIA_SHOP_DIALOG     = 11549, -- Blacksmiths' Guild shop, at your service!
        CAUZERISTE_SHOP_DIALOG   = 11616, -- Welcome! San d'Oria Carpenters' Guild shop, at your service.
        ANTONIAN_OPEN_DIALOG     = 11631, -- Interested in goods from Aragoneu?
        BONCORT_SHOP_DIALOG      = 11632, -- Welcome to the Phoenix Perch!
        PIRVIDIAUCE_SHOP_DIALOG  = 11633, -- Care to see what I have?
        PALGUEVION_OPEN_DIALOG   = 11634, -- I've got a shipment straight from Valdeaunia!
        VICHUEL_OPEN_DIALOG      = 11635, -- Fauregandi produce for sale!
        ARLENNE_SHOP_DIALOG      = 11636, -- Welcome to the Royal Armory!
        TAVOURINE_SHOP_DIALOG    = 11637, -- Looking for a weapon? We've got many in stock!
        JUSTI_SHOP_DIALOG        = 11639, -- Hello!
        ANTONIAN_CLOSED_DIALOG   = 11641, -- The Kingdom's influence is waning in Aragoneu. I cannot import goods from that region, though I long to.
        PALGUEVION_CLOSED_DIALOG = 11642, -- Would that Valdeaunia came again under San d'Orian dominion, I could then import its goods!
        VICHUEL_CLOSED_DIALOG    = 11643, -- I'd make a killing selling Fauregandi produce here, but that region's not under San d'Orian control!
        ATTARENA_CLOSED_DIALOG   = 11644, -- Once all of Li'Telor is back under San d'Orian influence, I'll fill my stock with unique goods from there!
        EUGBALLION_CLOSED_DIALOG = 11645, -- I'd be making a fortune selling goods from Qufim Island...if it were only under San d'Orian control!
        EUGBALLION_OPEN_DIALOG   = 11646, -- Have a look at these goods imported direct from Qufim Island!
        CHAUPIRE_SHOP_DIALOG     = 11647, -- San d'Orian woodcraft is the finest in the land!
        CONQUEST                 = 11713, -- You've earned conquest points!
        FFR_BONCORT              = 12060, -- Hmm... With magic, I could get hold of materials a mite easier. I'll have to check this mart out.
        FFR_CAPIRIA              = 12061, -- A flyer? For me? Some reading material would be a welcome change of pace, indeed!
        FFR_VILLION              = 12062, -- Opening a shop of magic, without consulting me first? I must pay this Regine a visit!
        FFR_COULLENE             = 12063, -- Magic could be of use on my journey to Paradise. Thank you so much!
        FLYER_ACCEPTED           = 12064, -- Your flyer is accepted!
        FLYER_ALREADY            = 12065, -- This person already has a flyer.
        MOGHOUSE_EXIT            = 12364, -- You have learned your way through the back alleys of San d'Oria! Now you can exit to any area from your residence.
        AILBECHE_WHEN_FISHING    = 12384, -- Oh, when will my father take me fishing...
        OH_I_WANT_MY_ITEM        = 12623, -- Oh, I want my <item>.
        GAUDYLOX_SHOP_DIALOG     = 12624, -- <Phssshooooowoooo> You never see Goblinshhh from underworld? Me no bad. Me sell chipshhh. You buy. Use with shhhtone heart. You get lucky!
        MILLECHUCA_CLOSED_DIALOG = 12625, -- I've been trying to import goods from Vollbow, but it's so hard to get items from areas that aren't under San d'Orian control.
        ATTARENA_OPEN_DIALOG     = 12710, -- Good day! Take a look at my selection from Li'Telor!
        MILLECHUCA_OPEN_DIALOG   = 12711, -- Specialty goods from Vollbow! Specialty goods from Vollbow!
        SHIVA_UNLOCKED           = 12809, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        ARACHAGNON_SHOP_DIALOG   = 12913, -- Would you be interested in purchasing some adventurer-issue armor? Be careful when selecting, as we accept no refunds.
        TRICK_OR_TREAT           = 13056, -- Trick or treat...
        THANK_YOU_TREAT          = 13057, -- Thank you... And now for your treat...
        HERE_TAKE_THIS           = 13058, -- Here, take this...
        IF_YOU_WEAR_THIS         = 13059, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                = 13060, -- Thank you...
        FFR_LOOKS_CURIOUSLY_BASE = 13384, -- Coullene looks over curiously for a moment.
        RETRIEVE_DIALOG_ID       = 18128, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL    = 18472, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        EXPLORER_MOOGLE = 17723648,
    },
}

return zones[xi.zone.NORTHERN_SAN_DORIA]
