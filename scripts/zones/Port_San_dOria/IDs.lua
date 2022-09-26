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
        HOMEPOINT_SET                  = 24,    -- Home point set!
        ITEM_CANNOT_BE_OBTAINED        = 6428,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        MYSTIC_RETRIEVER               = 6431,  -- You cannot obtain the <item>. Speak with the mystic retriever after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6432,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6434,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6435,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6437,  -- Obtained key item: <keyitem>.
        REPORT_TO_CAIT_SITH            = 6464,  -- You have obtained all of Lilisette's memory fragments. Make haste and report to Cait Sith.
        YOU_MUST_WAIT_ANOTHER_N_DAYS   = 6470,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS            = 6473,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6474,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 6475,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 6495,  -- Your party is unable to participate because certain members' levels are restricted.
        MOG_LOCKER_OFFSET              = 6612,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        CONQUEST_BASE                  = 7082,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET         = 7241,  -- You can't fish here.
        PICKPOCKET_AVANDALE            = 7395,  -- What? A pickpocket? Well, I did see a strange woman run to Northern San d'Oria. But I didn't see her steal anything.
        ANTRENEAU_READY_TO_EAT         = 7396,  -- All right, then! I am ready to eat!
        FLYER_ALREADY                  = 7574,  -- This person already has a flyer.
        FLYER_ACCEPTED                 = 7575,  -- Your flyer is accepted!
        PICKPOCKET_COMITTIE            = 7613,  -- A pickpocket? No one like that around here.
        PICKPOCKET_MEINEMELLE          = 7617,  -- Have I seen anyone suspicious? No, not around here. Sorry!
        PICKPOCKET_LAUCIMERCEN         = 7624,  -- A pickpocket? No, not round here.
        PICKPOCKET_RIELLE              = 7628,  -- Hmm? Someone suspicious? Now that you mention it, I did see a woman dart up the western stair, that way.
        PICKPOCKET_NOQUERELLE          = 7631,  -- A pickpocket? Now there's a scoundrel unworthy of San d'Oria! It wasn't an Elvaan, was it?
        PICKPOCKET_MEUXTAJEAN          = 7634,  -- Aye, pickpockets will get you if you don't watch yourself.
        PICKPOCKET_MARQUIE             = 7637,  -- A pickpocket? Things sure have gotten rough around here. You watch yourself.
        PICKPOCKET_CRILDE              = 7639,  -- She went down this corridor! Get that rapscallion, quick!
        PICKPOCKET_EAUGOUINT           = 7641,  -- Hey, that pickpocket just ran that way! Get after her, quick!
        PICKPOCKET_CORIBALGEANT        = 7647,  -- I'd like to just to take a moogle and-- Ah, pardon me, I was lost in thought. No, I haven't seen anyone suspicious.
        PICKPOCKET_PARCARIN            = 7810,  -- Long live King Destin! Huh? Pickpockets? Can't you see I'm in the middle of something here?
        PICKPOCKET_SOLGIERTE           = 7813,  -- Confound them! Give me a sword and... Eh? A pickpocket? Do I look like I hang out with that sort?
        LAY_LOW                        = 7839, --   I'll ask you again once you get your flight privileges back in Jeuno. Best lay low for now.
        FFR_PORTAURE                   = 7840,  -- What's this? A magic shop? Hmm...I could use a new line of work, and magic just might be the ticket!
        PICKPOCKET_SHERIDAN            = 7844,  -- What? A pickpocket? Hey! I may be a loafer, but I'm no thief!
        FFR_ANSWALD                    = 7860,  -- A magic shop? Oh, it's right near here. I'll go check it out sometime.
        PICKPOCKET_ANSWALD             = 7861,  -- A pickpocket!? Whew, my wallet's safe. It takes money to be an adventurer!
        PICKPOCKET_ARTINIEN            = 7870,  -- My grandpa always said that only a thief would take other people's things! If I find that pickpocket... Wham! Wham!
        PICKPOCKET_BRIFALIEN           = 7871,  -- My grandpa always said that the only stuff thieves take are other people's things! If I find that pickpocket, he's chocobo-feed!
        FFR_PRIETTA                    = 7884,  -- This is the first I've heard of a magic shop here in San d'Oria. Such arts have never been popular in the Kingdom.
        PICKPOCKET_MAUNADOLACE         = 7888,  -- A pickpocket? I would have detained anyone suspicious coming this way.
        FFR_AUVARE                     = 7891,  -- What have I got here? Look, I can't read, but I takes what I gets, and you ain't getting it back!
        ALBINIE_SHOP_DIALOG            = 7904,  -- Welcome to my simple shop.
        FFR_MIENE                      = 7944,  -- Oh, a magic shop... Here in San d'Oria? I'd take a look if I got more allowance.
        COULLAVE_SHOP_DIALOG           = 7950,  -- Can I help you?
        CROUMANGUE_SHOP_DIALOG         = 7951,  -- Can't fight on an empty stomach. How about some nourishment?
        FIVA_OPEN_DIALOG               = 7952,  -- I've got imports from Kolshushu!
        MILVA_OPEN_DIALOG              = 7953,  -- How about some produce from Sarutabaruta?
        FIVA_CLOSED_DIALOG             = 7954,  -- I'm trying to sell goods from Kolshushu. But I can't because we don't have enough influence there.
        MILVA_CLOSED_DIALOG            = 7955,  -- I want to import produce from Sarutabaruta... But I can't do anything until we control that region!
        NIMIA_CLOSED_DIALOG            = 7956,  -- I can't sell goods from the lowlands of Elshimo because it's under foreign control.
        PATOLLE_CLOSED_DIALOG          = 7957,  -- I'm trying to find goods from Kuzotz. But how can I when it's under foreign control?
        VENDAVOQ_OPEN_DIALOG           = 7958,  -- Vandoolin! Vendavoq vring voods vack vrom Vovalpolos! Vuy! Vuy!
        VENDAVOQ_CLOSED_DIALOG         = 7959,  -- Vandoolin... Vendavoq's vream vo vell voods vrom vometown vf Vovalpolos...
        DEGUERENDARS_OPEN_DIALOG       = 7960,  -- Welcome! Have a look at these rare goods from Tavnazia!
        DEGUERENDARS_CLOSED_DIALOG     = 7961,  -- With that other nation in control of the region, there is no way for me to import goods from Tavnazia...
        DEGUERENDARS_COP_NOT_COMPLETED = 7962,  -- <Sigh> Why must I wait for the Kingdom to issue a permit allowing me to set up shop? How am I to feed my children in the meantime!?
        ITEM_DELIVERY_DIALOG           = 7963,  -- Now delivering parcels to rooms everywhere!
        GALLIJAUX_CARP_STATUS          = 8134,  -- How's it going with you? I've got <number> [carp/carps] now--don't let me down!
        GALLIJAUX_HELP_OTHER_BROTHER   = 8137,  -- What's this? You're helping me brother, are you? Be gone with you, then! Out of my sight!
        JOULET_CARP_STATUS             = 8146,  -- How goes it? I've got a hold of <number> [carp/carps] now. Keep bringing them--I wouldn't want to lose to my brother!
        JOULET_HELP_OTHER_BROTHER      = 8149,  -- Ah, so you've been helping my brother, have you!? Traitor! Turncoat! Be gone with you!
        BONMAURIEUT_CLOSED_DIALOG      = 8306,  -- I would like to sell goods from the Elshimo Uplands, but I cannot, as it's under foreign control.
        NIMIA_OPEN_DIALOG              = 8307,  -- Hello, friend! Can I interest you in specialty goods from the Elshimo Lowlands?
        PATOLLE_OPEN_DIALOG            = 8308,  -- Hey, [mister/miss]! How about some specialty goods from Kuzotz?
        BONMAURIEUT_OPEN_DIALOG        = 8309,  -- My shipment is in! Would you like to see what has just arrived from the Elshimo Uplands?
        FFR_LOOKS_CURIOUSLY_BASE       = 8446,  -- Answald looks over curiously for a moment.
        FRAGMENT_FAR_TOO_SMALL         = 11514, -- You obtain <keyitem>. However, it is far too small to house an adequate amount of energy. Alone, it serves no purpose.
        FRAGMENTS_MELD                 = 11515, -- The tiny fragments of Lilisette's memory meld together to form <keyitem>!
        OBTAINED_NUM_KEYITEMS          = 11540, -- Obtained key item: <number> <keyitem>!
        NOT_ACQUAINTED                 = 11542, -- I'm sorry, but I don't believe we're acquainted. Please leave me be.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.PORT_SAN_DORIA]
