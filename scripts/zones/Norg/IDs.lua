-----------------------------------
-- Area: Norg
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.NORG] =
{
    text =
    {
        HOMEPOINT_SET                = 2, -- Home point set!
        ITEM_CANNOT_BE_OBTAINED      = 6405, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                = 6411, -- Obtained: <item>.
        GIL_OBTAINED                 = 6412, -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6414, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS          = 6450, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY      = 6451, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                 = 6452, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                = 6500, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET       = 6659, -- You can't fish here.
        REGIME_CANCELED              = 6820, -- Current training regime canceled.
        HUNT_ACCEPTED                = 6838, -- Hunt accepted!
        USE_SCYLDS                   = 6839, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                = 6850, -- You record your hunt.
        OBTAIN_SCYLDS                = 6852, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                = 6856, -- Hunt canceled.
        YOU_CAN_NOW_BECOME_A_SAMURAI = 10199, -- You accept the <item> from Gilgamesh. You can now become a samurai.
        CARRYING_TOO_MUCH_ALREADY    = 10200, -- I wish to give you your reward, but you seem to be carrying too much already. Come back when you have more room in your pack.
        JIROKICHI_SHOP_DIALOG        = 10346, -- Heh-heh-heh. Feast your eyes on these beauties. You won't find stuff like this anywhere!
        VULIAIE_SHOP_DIALOG          = 10347, -- Please, stay and have a look. You may find something you can only buy here.
        ACHIKA_SHOP_DIALOG           = 10348, -- Can I interest you in some armor forged in the surrounding regions?
        CHIYO_SHOP_DIALOG            = 10349, -- Magic scrolls! Magic scrolls! We've got parchment hot off the sheep!
        SPASIJA_DELIVERY_DIALOG      = 10350, -- Hiya! I can deliver packages to anybody, anywhere, anytime. What do you say?
        SPASIJA_DIALOG               = 10350, -- Hiya! I can deliver packages to anybody, anywhere, anytime. What do you say?
        PALEILLE_DIALOG              = 10351, -- We can deliver parcels to any residence in Vana'diel.
        PALEILLE_DELIVERY_DIALOG     = 10351, -- We can deliver parcels to any residence in Vana'diel.
        DOOR_IS_LOCKED               = 10356, -- The door is locked tight.
        AVATAR_UNLOCKED              = 10470, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        NOMAD_MOOGLE_DIALOG          = 10538, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        FOUIVA_DIALOG                = 10562, -- Oi 'av naw business wi' de likes av you.
        SOLBYMAHOLBY_SHOP_DIALOG     = 10576, -- Hiya! My name's Solby-Maholby! I'm new here, so they put me on tooty-fruity shop duty. I'll give you a super-duper deal on unwanted items!
        TACHI_KASHA_LEARNED          = 10799, -- You have learned the weapon skill Tachi: Kasha!
        BLADE_KU_LEARNED             = 10824, -- You have learned the weapon skill Blade: Ku!
        RETRIEVE_DIALOG_ID           = 11277, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL        = 12287, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.NORG]
