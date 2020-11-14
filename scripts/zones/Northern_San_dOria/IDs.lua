-----------------------------------
-- Area: Northern_San_dOria
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.NORTHERN_SAN_DORIA] =
{
    text =
    {
        YOU_ACCEPT_THE_MISSION   = 5, -- You accept the mission.
        ORIGINAL_MISSION_OFFSET  = 16, -- Bring me one of those axes, and your mission will be a success. No running away now; we've a proud country to defend!
        HOMEPOINT_SET            = 188, -- Home point set!
        ITEM_CANNOT_BE_OBTAINED  = 6590, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6596, -- Obtained: <item>.
        GIL_OBTAINED             = 6597, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6599, -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6600, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL      = 6601, -- You do not have enough gil.
        CARRIED_OVER_POINTS      = 6635, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY  = 6636, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER             = 6637, -- In celebration of your most recent login no. <number>...
        MOG_LOCKER_OFFSET        = 6834, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        IMAGE_SUPPORT            = 6958, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT = 6972, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT       = 6980, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE      = 6987, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED              = 6992, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP       = 6993, -- You do not have enough guild points.
        CONQUEST_BASE            = 7263, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7422, -- You can't fish here.
        REGIME_CANCELED          = 7973, -- Current training regime canceled.
        HUNT_ACCEPTED            = 7991, -- Hunt accepted!
        USE_SCYLDS               = 7992, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED            = 8003, -- You record your hunt.
        OBTAIN_SCYLDS            = 8005, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED            = 8009, -- Hunt canceled.
        FFR_GUILBERDRIER         = 11150, -- A magic shop, you say? A bit of magic would come in handy... I know! I'll have my daughter study it for me!
        ABIOLEGET_DIALOG         = 11226, -- All of Altana's children are welcome here.
        PELLIMIE_DIALOG          = 11227, -- Is this your first time here? Join us in prayer!
        FITTESEGAT_DIALOG        = 11228, -- Paradise is a place without fear, without death!
        MAURINE_DIALOG           = 11229, -- Papsque Shamonde sometimes addresses the city from the balcony, you know. I long for his blessing, if but once!
        PRERIVON_DIALOG          = 11230, -- With each sermon, I take another step closer to Paradise.
        MALFINE_DIALOG           = 11231, -- Truly fortunate are we that words of sacrament are read every day!
        COULLENE_DIALOG          = 11232, -- Goddess above, deliver us to Paradise!
        OLBERGIEUT_DIALOG        = 11274, -- Friar Faurbellant is on retreat at the Crag of Holla. Please give <item> to him.
        GUILERME_DIALOG          = 11346, -- Behold Chateau d'Oraguille, the greatest fortress in the realm!
        PHAVIANE_DIALOG          = 11350, -- This is Victory Arch. Beyond lies Southern San d'Oria.
        SOCHIENE_DIALOG          = 11351, -- You stand before Victory Arch. Southern San d'Oria is on the other side.
        PEPIGORT_DIALOG          = 11352, -- This gate leads to Port San d'Oria.
        RODAILLECE_DIALOG        = 11353, -- This is Ranperre Gate. Fiends lurk in the lands beyond, so take caution!
        GALAHAD_DIALOG           = 11366, -- Welcome to the Consulate of Jeuno. I am Galahad, Consul to San d'Oria.
        ISHWAR_DIALOG            = 11367, -- May I assist you?
        ARIENH_DIALOG            = 11368, -- If you have business with Consul Galahad, you'll find him inside.
        EMILIA_DIALOG            = 11369, -- Welcome to the Consulate of Jeuno.
        HELAKU_DIALOG            = 11398, -- Leave this building, and you'll see a great fortress to the right. That's Chateau d'Oraguille. And be polite; San d'Orians can be quite touchy.
        KASARORO_DIALOG          = 11437, -- Step right outside, and you'll see a big castle on the left. That's Chateau d'Oraguille. They're a little touchy in there, so mind your manners!
        PICKPOCKET_AUREGE        = 11466, -- A pickpocket, you say? Come to think of it, I did see a scoundrel skulking about...
        PICKPOCKET_GUILBERDRIER  = 11468, -- A pickpocket? No, can't say I've seen anyone like that. I'll keep an eye out, though.
        PICKPOCKET_PEPIGORT      = 11472, -- A pickpocket? Hey, I wonder if you mean that lady running helter-skelter over there just now...
        PICKPOCKET_GILIPESE      = 11473, -- A pickpocket? I did just see an undignified sort of woman just now. She was running toward Ranperre Gate.
        MAURINNE_DIALOG          = 11474, -- This part of town is so lively, I like watching everybody just go about their business.
        PICKPOCKET_MAURINNE      = 11475, -- A pickpocket?
        PICKPOCKET_RODAILLECE    = 11477, -- A pickpocket? Maybe it was that foul-mouthed woman just now. She called me a spoony bard! Unthinkable!
        AIVEDOIR_DIALOG          = 11508, -- That's funny. I could have sworn she asked me to meet her here...
        CAPIRIA_DIALOG           = 11509, -- He's late! I do hope he hasn't forgotten.
        BERTENONT_DIALOG         = 11510, -- Stars are more beautiful up close. Don't you agree?
        GILIPESE_DIALOG          = 11531, -- Nothing to report!
        DOGGOMEHR_SHOP_DIALOG    = 11544, -- Welcome to the Blacksmiths' Guild shop.
        CAUZERISTE_SHOP_DIALOG   = 11612, -- Welcome! San d'Oria Carpenters' Guild shop, at your service.
        LUCRETIA_SHOP_DIALOG     = 11545, -- Blacksmiths' Guild shop, at your service!
        ANTONIAN_OPEN_DIALOG     = 11627, -- Interested in goods from Aragoneu?
        BONCORT_SHOP_DIALOG      = 11628, -- Welcome to the Phoenix Perch!
        PIRVIDIAUCE_SHOP_DIALOG  = 11629, -- Care to see what I have?
        PALGUEVION_OPEN_DIALOG   = 11630, -- I've got a shipment straight from Valdeaunia!
        VICHUEL_OPEN_DIALOG      = 11631, -- Fauregandi produce for sale!
        ARLENNE_SHOP_DIALOG      = 11632, -- Welcome to the Royal Armory!
        TAVOURINE_SHOP_DIALOG    = 11633, -- Looking for a weapon? We've got many in stock!
        JUSTI_SHOP_DIALOG        = 11635, -- Hello!
        ANTONIAN_CLOSED_DIALOG   = 11637, -- The Kingdom's influence is waning in Aragoneu. I cannot import goods from that region, though I long to.
        PALGUEVION_CLOSED_DIALOG = 11638, -- Would that Valdeaunia came again under San d'Orian dominion, I could then import its goods!
        VICHUEL_CLOSED_DIALOG    = 11639, -- I'd make a killing selling Fauregandi produce here, but that region's not under San d'Orian control!
        ATTARENA_CLOSED_DIALOG   = 11640, -- Once all of Li'Telor is back under San d'Orian influence, I'll fill my stock with unique goods from there!
        EUGBALLION_CLOSED_DIALOG = 11641, -- I'd be making a fortune selling goods from Qufim Island...if it were only under San d'Orian control!
        EUGBALLION_OPEN_DIALOG   = 11642, -- Have a look at these goods imported direct from Qufim Island!
        CHAUPIRE_SHOP_DIALOG     = 11643, -- San d'Orian woodcraft is the finest in the land!
        CONQUEST                 = 11709, -- You've earned conquest points!
        FFR_BONCORT              = 12056, -- Hmm... With magic, I could get hold of materials a mite easier. I'll have to check this mart out.
        FFR_CAPIRIA              = 12057, -- A flyer? For me? Some reading material would be a welcome change of pace, indeed!
        FFR_VILLION              = 12058, -- Opening a shop of magic, without consulting me first? I must pay this Regine a visit!
        FFR_COULLENE             = 12059, -- Magic could be of use on my journey to Paradise. Thank you so much!
        FLYER_ACCEPTED           = 12060, -- Your flyer is accepted!
        FLYER_ALREADY            = 12061, -- This person already has a flyer.
        MOGHOUSE_EXIT            = 12360, -- You have learned your way through the back alleys of San d'Oria! Now you can exit to any area from your residence.
        GAUDYLOX_SHOP_DIALOG     = 12620, -- <Phssshooooowoooo> You never see Goblinshhh from underworld? Me no bad. Me sell chipshhh. You buy. Use with shhhtone heart. You get lucky!
        MILLECHUCA_CLOSED_DIALOG = 12621, -- I've been trying to import goods from Vollbow, but it's so hard to get items from areas that aren't under San d'Orian control.
        ATTARENA_OPEN_DIALOG     = 12706, -- Good day! Take a look at my selection from Li'Telor!
        MILLECHUCA_OPEN_DIALOG   = 12707, -- Specialty goods from Vollbow! Specialty goods from Vollbow!
        SHIVA_UNLOCKED           = 12805, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        ARACHAGNON_SHOP_DIALOG   = 12909, -- Would you be interested in purchasing some adventurer-issue armor? Be careful when selecting, as we accept no refunds.
        TRICK_OR_TREAT           = 13052, -- Trick or treat...
        THANK_YOU_TREAT          = 13053, -- Thank you... And now for your treat...
        HERE_TAKE_THIS           = 13054, -- Here, take this...
        IF_YOU_WEAR_THIS         = 13055, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                = 13056, -- Thank you...
        FFR_LOOKS_CURIOUSLY_BASE = 13380, -- Coullene looks over curiously for a moment.
        RETRIEVE_DIALOG_ID       = 18124, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL    = 18458, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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

return zones[tpz.zone.NORTHERN_SAN_DORIA]
