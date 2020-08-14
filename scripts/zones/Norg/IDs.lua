-----------------------------------
-- Area: Norg
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.NORG] =
{
    text =
    {
        HOMEPOINT_SET                = 2, -- Home point set!
        ITEM_CANNOT_BE_OBTAINED      = 6404, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                = 6410, -- Obtained: <item>.
        GIL_OBTAINED                 = 6411, -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6413, -- Obtained key item: <keyitem>.
        CONQUEST_BASE                = 6499, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET       = 6658, -- You can't fish here.
        REGIME_CANCELED              = 6819, -- Current training regime canceled.
        HUNT_ACCEPTED                = 6837, -- Hunt accepted!
        USE_SCYLDS                   = 6838, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                = 6849, -- You record your hunt.
        OBTAIN_SCYLDS                = 6851, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                = 6855, -- Hunt canceled.
        YOU_CAN_NOW_BECOME_A_SAMURAI = 10198, -- You accept the <item> from Gilgamesh. You can now become a samurai.
        CARRYING_TOO_MUCH_ALREADY    = 10199, -- I wish to give you your reward, but you seem to be carrying too much already. Come back when you have more room in your pack.
        JIROKICHI_SHOP_DIALOG        = 10345, -- Heh-heh-heh. Feast your eyes on these beauties. You won't find stuff like this anywhere!
        VULIAIE_SHOP_DIALOG          = 10346, -- Please, stay and have a look. You may find something you can only buy here.
        ACHIKA_SHOP_DIALOG           = 10347, -- Can I interest you in some armor forged in the surrounding regions?
        CHIYO_SHOP_DIALOG            = 10348, -- Magic scrolls! Magic scrolls! We've got parchment hot off the sheep!
        SPASIJA_DELIVERY_DIALOG      = 10349, -- Hiya! I can deliver packages to anybody, anywhere, anytime. What do you say?
        SPASIJA_DIALOG               = 10349, -- Hiya! I can deliver packages to anybody, anywhere, anytime. What do you say?
        PALEILLE_DIALOG              = 10350, -- We can deliver parcels to any residence in Vana'diel.
        PALEILLE_DELIVERY_DIALOG     = 10350, -- We can deliver parcels to any residence in Vana'diel.
        DOOR_IS_LOCKED               = 10355, -- The door is locked tight.
        AVATAR_UNLOCKED              = 10469, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        NOMAD_MOOGLE_DIALOG          = 10537, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        FOUIVA_DIALOG                = 10561, -- Oi 'av naw business wi' de likes av you.
        SOLBYMAHOLBY_SHOP_DIALOG     = 10575, -- Hiya! My name's Solby-Maholby! I'm new here, so they put me on tooty-fruity shop duty. I'll give you a super-duper deal on unwanted items!
        TACHI_KASHA_LEARNED          = 10798, -- You have learned the weapon skill Tachi: Kasha!
        BLADE_KU_LEARNED             = 10823, -- You have learned the weapon skill Blade: Ku!
        RETRIEVE_DIALOG_ID           = 11276, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL        = 12286, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.NORG]
