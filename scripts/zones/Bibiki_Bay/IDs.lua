-----------------------------------
-- Area: Bibiki_Bay
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BIBIKI_BAY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        YOU_OBTAIN              = 6398, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY = 6403, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET   = 6418, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7053, -- Tallying conquest results...
        POHKA_SHOP_DIALOG       = 7224, -- Hey buddy, need a rod? I've got loads of state-of-the-art, top-of-the-line, high quality rods right here waitin' fer ya! Whaddya say?
        MEP_NHAPOPOLUKO_DIALOG  = 7226, -- Welcome! Fishermen's Guild representative, at your service!
        WHOA_HOLD_ON_NOW        = 7242, -- Whoa, hold on now. Ain't look like you got 'nuff room in that spiffy bag o' yours to carrrry all these darn clams. Why don't you trrry thrrrowin' some o' that old junk away before ya come back here 'gain?
        YOU_GIT_YER_BAG_READY   = 7243, -- You git yer bag ready, pardner? Well alrighty then. Here'rrre yer clams.
        YOU_RETURN_THE          = 7250, -- You return the <item>.
        AREA_IS_LITTERED        = 7251, -- The area is littered with pieces of broken seashells.
        YOU_FIND_ITEM           = 7253, -- You find <item> and toss it into your bucket.
        THE_WEIGHT_IS_TOO_MUCH  = 7254, -- You find <item> and toss it into your bucket... But the weight is too much for the bucket and its bottom breaks! All your shellfish are washed back into the sea...
        YOU_CANNOT_COLLECT      = 7255, -- You cannot collect any clams with a broken bucket!
        IT_LOOKS_LIKE_SOMEONE   = 7256, -- It looks like someone has been digging here.
        YOUR_CLAMMING_CAPACITY  = 7264, -- Your clamming capacity has increased to <number> ponzes! Now you may be able to dig up a...
        SOMETHING_JUMPS_INTO    = 7267, -- Something jumps into your bucket and breaks through the bottom! All your shellfish are washed back into the sea...
        FISHING_MESSAGE_OFFSET  = 7268, -- You can't fish here.
        DIG_THROW_AWAY          = 7281, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING            = 7283, -- You dig and you dig, but find nothing.
        NO_BILLET               = 7485, -- You were refused passage for failing to present <item>!
        HAVE_BILLET             = 7490, -- You cannot buy morrre than one <item>. Use the one you have now to ride the next ship.
        LEFT_BILLET             = 7495, -- You use your <item>. (<number> trip[/s] remaining)
        END_BILLET              = 7496, -- You use up your <item>.
        COMMON_SENSE_SURVIVAL   = 8641, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        NEWS_BILLET             = 8664, -- <item> has been [added to your list of favorites/removed from your list of favorites].
    },
    mob =
    {
        SERRA_PH =
        {
            [16793645] = 16793646, -- -348 0.001 -904
        },
        INTULO_PH =
        {
            [16793741] = 16793742, -- 480 -3 743
        },
        SPLACKNUCK_PH =
        {
            [16793775] = 16793776,
        },
        DALHAM = 16793858,
        SHEN   = 16793859,
    },
    npc =
    {
    },
}

return zones[xi.zone.BIBIKI_BAY]
