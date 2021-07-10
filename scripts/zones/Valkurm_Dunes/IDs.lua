-----------------------------------
-- Area: Valkurm_Dunes
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.VALKURM_DUNES] =
{
    text =
    {
        NOTHING_HAPPENS                = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED        = 6405,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6411,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6412,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6414,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6415,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6425,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET          = 6440,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7022, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7023, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 7024, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                  = 7072,  -- Tallying conquest results...
        BEASTMEN_BANNER                = 7153,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET         = 7231,  -- You can't fish here.
        DIG_THROW_AWAY                 = 7244,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                   = 7246,  -- You dig and you dig, but find nothing.
        SONG_RUNES_DEFAULT             = 7331,  -- Lyrics on the old monument sing the story of lovers torn apart.
        UNLOCK_BARD                    = 7352,  -- You can now become a bard!
        SIGNPOST2                      = 7360,  -- Northeast: La Theine Plateau Southeast: Konschtat Highlands West: Selbina
        SIGNPOST1                      = 7361,  -- Northeast: La Theine Plateau Southeast: Konschtat Highlands Southwest: Selbina
        CONQUEST                       = 7371,  -- You've earned conquest points!
        AN_EMPTY_LIGHT_SWIRLS          = 7767,  -- An empty light swirls about the cave, eating away at the surroundings...
        MONSTERS_KILLED_ADVENTURERS    = 7843,  -- Long ago, monsters killed many adventurers and merchants just off the coast here. If you find any vestige of the victims and return it to the sea, perhaps it would appease the spirits of the dead.
        YOU_CANNOT_ENTER_DYNAMIS       = 7881,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7883,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 8005,  -- There is a strange symbol drawn here. A haunting chill sweeps through you as you gaze upon it...
        PLAYER_OBTAINS_ITEM            = 8093,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8094,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8095,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8096,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8101,  -- You were unable to enter a combination.
        REGIME_REGISTERED              = 10279, -- New training regime registered!
        COMMON_SENSE_SURVIVAL          = 12333, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        VALKURM_EMPEROR_PH =
        {
            [17199434] = 17199438, -- -228.957 2.776 -101.226
            [17199437] = 17199438, -- -264.829 -0.843 -91.306
            [17199420] = 17199438, -- -95.250 -0.268 -49.386
            [17199419] = 17199438, -- -144.284 -1.103 4.202
            [17199435] = 17199438, -- -270.823 -2.168 -16.349
            [17199436] = 17199438, -- -327.000 -1.000 -21.000
        },
        GOLDEN_BAT_PH      =
        {
            [17199562] = 17199564, -- -804.502 -8.567 22.082
            [17199563] = 17199564, -- -798.674 -8.672 19.204
            [17199461] = 17199564, -- -296.679 -0.510 -164.298
        },
        MARCHELUTE         = 17199566,
        DOMAN              = 17199567,
        ONRYO              = 17199568,
    },
    npc =
    {
        CASKET_BASE   = 17199671,
        SUNSAND_QM    = 17199698, -- qm1 in npc_list
        OVERSEER_BASE = 17199708, -- Quanteilleron_RK in npc_list
    },
}

return zones[xi.zone.VALKURM_DUNES]
