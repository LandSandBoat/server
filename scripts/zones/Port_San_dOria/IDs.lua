-----------------------------------
-- Area: Port_San_dOria
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PORT_SAN_DORIA] =
{
    text =
    {
        HOMEPOINT_SET                  = 24,   -- Home point set!
        ITEM_CANNOT_BE_OBTAINED        = 6427, -- You cannot obtain the <item>. Come back after sorting your inventory.
        MYSTIC_RETRIEVER               = 6430, -- You cannot obtain the <item>. Speak with the mystic retriever after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6431, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6433, -- Obtained: <item>.
        GIL_OBTAINED                   = 6434, -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6436, -- Obtained key item: <keyitem>.
        YOU_MUST_WAIT_ANOTHER_N_DAYS   = 6469, -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS            = 6472, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6473, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 6474, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MOG_LOCKER_OFFSET              = 6605, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        CONQUEST_BASE                  = 7075, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET         = 7234, -- You can't fish here.
        PICKPOCKET_AVANDALE            = 7388, -- What? A pickpocket? Well, I did see a strange woman run to Northern San d'Oria. But I didn't see her steal anything.
        ANTRENEAU_READY_TO_EAT         = 7389, -- All right, then! I am ready to eat!
        FLYER_ALREADY                  = 7567, -- This person already has a flyer.
        FLYER_ACCEPTED                 = 7568, -- Your flyer is accepted!
        PICKPOCKET_COMITTIE            = 7606, -- A pickpocket? No one like that around here.
        PICKPOCKET_MEINEMELLE          = 7610, -- Have I seen anyone suspicious? No, not around here. Sorry!
        PICKPOCKET_LAUCIMERCEN         = 7617, -- A pickpocket? No, not round here.
        PICKPOCKET_RIELLE              = 7621, -- Hmm? Someone suspicious? Now that you mention it, I did see a woman dart up the western stair, that way.
        PICKPOCKET_NOQUERELLE          = 7624, -- A pickpocket? Now there's a scoundrel unworthy of San d'Oria! It wasn't an Elvaan, was it?
        PICKPOCKET_MEUXTAJEAN          = 7627, -- Aye, pickpockets will get you if you don't watch yourself.
        PICKPOCKET_MARQUIE             = 7630, -- A pickpocket? Things sure have gotten rough around here. You watch yourself.
        PICKPOCKET_CRILDE              = 7632, -- She went down this corridor! Get that rapscallion, quick!
        PICKPOCKET_EAUGOUINT           = 7634, -- Hey, that pickpocket just ran that way! Get after her, quick!
        PICKPOCKET_CORIBALGEANT        = 7640, -- I'd like to just to take a moogle and-- Ah, pardon me, I was lost in thought. No, I haven't seen anyone suspicious.
        PICKPOCKET_PARCARIN            = 7803, -- Long live King Destin! Huh? Pickpockets? Can't you see I'm in the middle of something here?
        PICKPOCKET_SOLGIERTE           = 7806, -- Confound them! Give me a sword and... Eh? A pickpocket? Do I look like I hang out with that sort?
        FFR_PORTAURE                   = 7833, -- What's this? A magic shop? Hmm...I could use a new line of work, and magic just might be the ticket!
        PICKPOCKET_SHERIDAN            = 7837, -- What? A pickpocket? Hey! I may be a loafer, but I'm no thief!
        FFR_ANSWALD                    = 7853, -- A magic shop? Oh, it's right near here. I'll go check it out sometime.
        PICKPOCKET_ANSWALD             = 7854, -- A pickpocket!? Whew, my wallet's safe. It takes money to be an adventurer!
        PICKPOCKET_ARTINIEN            = 7863, -- My grandpa always said that only a thief would take other people's things! If I find that pickpocket... Wham! Wham!
        PICKPOCKET_BRIFALIEN           = 7864, -- My grandpa always said that the only stuff thieves take are other people's things! If I find that pickpocket, he's chocobo-feed!
        FFR_PRIETTA                    = 7877, -- This is the first I've heard of a magic shop here in San d'Oria. Such arts have never been popular in the Kingdom.
        PICKPOCKET_MAUNADOLACE         = 7881, -- A pickpocket? I would have detained anyone suspicious coming this way.
        FFR_AUVARE                     = 7884, -- What have I got here? Look, I can't read, but I takes what I gets, and you ain't getting it back!
        ALBINIE_SHOP_DIALOG            = 7897, -- Welcome to my simple shop.
        FFR_MIENE                      = 7937, -- Oh, a magic shop... Here in San d'Oria? I'd take a look if I got more allowance.
        COULLAVE_SHOP_DIALOG           = 7943, -- Can I help you?
        CROUMANGUE_SHOP_DIALOG         = 7944, -- Can't fight on an empty stomach. How about some nourishment?
        FIVA_OPEN_DIALOG               = 7945, -- I've got imports from Kolshushu!
        MILVA_OPEN_DIALOG              = 7946, -- How about some produce from Sarutabaruta?
        FIVA_CLOSED_DIALOG             = 7947, -- I'm trying to sell goods from Kolshushu. But I can't because we don't have enough influence there.
        MILVA_CLOSED_DIALOG            = 7948, -- I want to import produce from Sarutabaruta... But I can't do anything until we control that region!
        NIMIA_CLOSED_DIALOG            = 7949, -- I can't sell goods from the lowlands of Elshimo because it's under foreign control.
        PATOLLE_CLOSED_DIALOG          = 7950, -- I'm trying to find goods from Kuzotz. But how can I when it's under foreign control?
        VENDAVOQ_OPEN_DIALOG           = 7951, -- Vandoolin! Vendavoq vring voods vack vrom Vovalpolos! Vuy! Vuy!
        VENDAVOQ_CLOSED_DIALOG         = 7952, -- Vandoolin... Vendavoq's vream vo vell voods vrom vometown vf Vovalpolos...
        DEGUERENDARS_OPEN_DIALOG       = 7953, -- Welcome! Have a look at these rare goods from Tavnazia!
        DEGUERENDARS_CLOSED_DIALOG     = 7954, -- With that other nation in control of the region, there is no way for me to import goods from Tavnazia...
        DEGUERENDARS_COP_NOT_COMPLETED = 7955, -- <Sigh> Why must I wait for the Kingdom to issue a permit allowing me to set up shop? How am I to feed my children in the meantime!?
        ITEM_DELIVERY_DIALOG           = 7956, -- Now delivering parcels to rooms everywhere!
        GALLIJAUX_CARP_STATUS          = 8127, -- How's it going with you? I've got <number> [carp/carps] now--don't let me down!
        GALLIJAUX_HELP_OTHER_BROTHER   = 8130, -- What's this? You're helping me brother, are you? Be gone with you, then! Out of my sight!
        JOULET_CARP_STATUS             = 8139, -- How goes it? I've got a hold of <number> [carp/carps] now. Keep bringing them--I wouldn't want to lose to my brother!
        JOULET_HELP_OTHER_BROTHER      = 8142, -- Ah, so you've been helping my brother, have you!? Traitor! Turncoat! Be gone with you!
        BONMAURIEUT_CLOSED_DIALOG      = 8299, -- I would like to sell goods from the Elshimo Uplands, but I cannot, as it's under foreign control.
        NIMIA_OPEN_DIALOG              = 8300, -- Hello, friend! Can I interest you in specialty goods from the Elshimo Lowlands?
        PATOLLE_OPEN_DIALOG            = 8301, -- Hey, [mister/miss]! How about some specialty goods from Kuzotz?
        BONMAURIEUT_OPEN_DIALOG        = 8302, -- My shipment is in! Would you like to see what has just arrived from the Elshimo Uplands?
        FFR_LOOKS_CURIOUSLY_BASE       = 8439, -- Answald looks over curiously for a moment.
        OBTAINED_NUM_KEYITEMS          = 11533, -- Obtained key item: <number> <keyitem>!
        NOT_ACQUAINTED                 = 11535, -- I'm sorry, but I don't believe we're acquainted. Please leave me be.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.PORT_SAN_DORIA]
