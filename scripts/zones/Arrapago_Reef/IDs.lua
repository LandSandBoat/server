-----------------------------------
-- Area: Arrapago_Reef
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.ARRAPAGO_REEF] =
{
    text =
    {
        NOTHING_HAPPENS             = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED     = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6389, -- Obtained: <item>.
        GIL_OBTAINED                = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6392, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY     = 6403, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS         = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET      = 7050, -- You can't fish here.
        RESPONSE                    = 7330, -- There is no response...
        DOOR_IS_LOCKED              = 7459, -- The door is locked.  You might be able to open it with <item>.
        DOOR_IS_LOCKED2             = 7460, -- The door is locked.  You might be able to open it with <item> or <item>.
        KEY_BREAKS                  = 7461, -- The <item> breaks!
        YOU_UNLOCK_DOOR             = 7464, -- You unlock the door from the inside.
        LOCK_SUCCESS                = 7465, -- <name> successfully opened the lock with the <item>!
        LOCK_FAIL                   = 7466, -- <name> failed to open the lock with the <item>...
        YOU_NO_REQS                 = 7896, -- You do not meet the requirements to enter the battlefield with your party members. Access is denied.
        CANNOT_ENTER                = 8447, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                   = 8448, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS              = 8452, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR              = 8456, -- One or more party members are too far away from the entrance. Unable to enter area.
        MEDUSA_ENGAGE               = 8558, -- Foolish two-legs... Have you forgotten the terrible power of the gorgons you created? It is time you were reminded...
        MEDUSA_DEATH                = 8559, -- No... I cannot leave my sisters...
        GLITTERING_FRAGMENTS        = 8908, -- Minute glittering fragments are scattered all over...
        SLIMY_TOUCH                 = 8909, -- The ground here is slimy to the touch...
        DRAWS_NEAR                  = 8911, -- Something draws near!
        COMMON_SENSE_SURVIVAL       = 9782, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BLOODY_BONES_PH       =
        {
            [16998653] = 16998655, -- 136.234 -6.831 468.779
        },
        MEDUSA                = 16998862,
        LIL_APKALLU           = 16998871,
        VELIONIS              = 16998872,
        ZAREEHKL_THE_JUBILANT = 16998873,
        NUHN                  = 16998874,
    },
    npc =
    {
    },
}

return zones[ xi.zone.ARRAPAGO_REEF]
