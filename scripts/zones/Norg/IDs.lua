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
        HOMEPOINT_SET                 = 2,     -- Home point set!
        ITEM_CANNOT_BE_OBTAINED       = 6406,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6412,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6413,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6415,  -- Obtained key item: <keyitem>.
        YOU_OBTAIN                    = 6421,  -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 6451,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6452,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6453,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6473,  -- Your party is unable to participate because certain members' levels are restricted.
        UNABLE_TO_PROGRESS_MISSION    = 6497,  -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        CONQUEST_BASE                 = 6510,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 6669,  -- You can't fish here.
        REGIME_CANCELED               = 6830,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 6848,  -- Hunt accepted!
        USE_SCYLDS                    = 6849,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 6860,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 6862,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 6866,  -- Hunt canceled.
        YOU_CAN_NOW_BECOME_A_SAMURAI  = 10209, -- You accept the <item> from Gilgamesh. You can now become a samurai.
        CARRYING_TOO_MUCH_ALREADY     = 10210, -- I wish to give you your reward, but you seem to be carrying too much already. Come back when you have more room in your pack.
        JIROKICHI_SHOP_DIALOG         = 10356, -- Heh-heh-heh. Feast your eyes on these beauties. You won't find stuff like this anywhere!
        VULIAIE_SHOP_DIALOG           = 10357, -- Please, stay and have a look. You may find something you can only buy here.
        ACHIKA_SHOP_DIALOG            = 10358, -- Can I interest you in some armor forged in the surrounding regions?
        CHIYO_SHOP_DIALOG             = 10359, -- Magic scrolls! Magic scrolls! We've got parchment hot off the sheep!
        SPASIJA_DELIVERY_DIALOG       = 10360, -- Hiya! I can deliver packages to anybody, anywhere, anytime. What do you say?
        PALEILLE_DELIVERY_DIALOG      = 10361, -- We can deliver parcels to any residence in Vana'diel.
        DOOR_IS_LOCKED                = 10366, -- The door is locked tight.
        AVATAR_UNLOCKED               = 10480, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        NOMAD_MOOGLE_DIALOG           = 10548, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        FOUIVA_DIALOG                 = 10572, -- Oi 'av naw business wi' de likes av you.
        SOLBYMAHOLBY_SHOP_DIALOG      = 10586, -- Hiya! My name's Solby-Maholby! I'm new here, so they put me on tooty-fruity shop duty. I'll give you a super-duper deal on unwanted items!
        TACHI_KASHA_LEARNED           = 10809, -- You have learned the weapon skill Tachi: Kasha!
        BLADE_KU_LEARNED              = 10834, -- You have learned the weapon skill Blade: Ku!
        RETRIEVE_DIALOG_ID            = 11287, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL         = 12297, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        DIDYA_GET_BUMPED              = 12325, -- Didya get bumped about by the waves on yer way here, <name>? No matter. The boss be waitin' inside fer ya.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.NORG]
