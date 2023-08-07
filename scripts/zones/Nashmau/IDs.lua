-----------------------------------
-- Area: Nashmau
-----------------------------------
zones = zones or {}

zones[xi.zone.NASHMAU] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_CANNOT_BE_OBTAINEDX      = 6388,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        ITEM_OBTAINEDX                = 6399,  -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7057,  -- You can't fish here.
        HOMEPOINT_SET                 = 7318,  -- Home point set!
        NOMAD_MOOGLE_DIALOG           = 7338,  -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        REGIME_CANCELED               = 7353,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 7371,  -- Hunt accepted!
        USE_SCYLDS                    = 7372,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 7383,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 7385,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 7389,  -- Hunt canceled.
        JAJAROON_SHOP_DIALOG          = 10487, -- Hellooo. Yooo have caaard? Can do gaaame? Jajaroon have diiice.
        TSUTSUROON_SHOP_DIALOG        = 10497, -- What yooo want? Have katana, katana, and nin-nin...yooo want?
        MAMAROON_SHOP_DIALOG          = 10500, -- Welcome to maaagic shop. Lots of magics for yooo.
        POPOROON_SHOP_DIALOG          = 10502, -- Come, come. Buy aaarmor, looots of armor!
        WATAKHAMAZOM_SHOP_DIALOG      = 10503, -- Looking for some bows and bolts to strrrike fear into the hearts of your enemies? You can find 'em here!
        CHICHIROON_SHOP_DIALOG        = 10505, -- Howdy-hooo! I gots soooper rare dice for yooo.
        SANCTION                      = 10781, -- You have received the Empire's Sanction.
        NENE_DELIVERY_DIALOG          = 10841, -- Yooo want to send gooods? Yooo want to send clink clink?
        NANA_DELIVERY_DIALOG          = 10842, -- Yooo send gooods. Yooo send clink clink.
        YOYOROON_SHOP_DIALOG          = 11793, -- Boooss, boooss! Yoyoroon bring yooo goood custooomer! Yoyoroon goood wooorker, nooo?
        PIPIROON_SHOP_DIALOG          = 11794, -- Yes? I'm a busy man. Make it quick.
        RETRIEVE_DIALOG_ID            = 11894, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL         = 11933, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.NASHMAU]
