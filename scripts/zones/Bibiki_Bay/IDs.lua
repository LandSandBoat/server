-----------------------------------
-- Area: Bibiki_Bay
-----------------------------------
zones = zones or {}

zones[xi.zone.BIBIKI_BAY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        YOU_OBTAIN                    = 6403, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6408, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6423, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072, -- Tallying conquest results...
        POHKA_SHOP_DIALOG             = 7243, -- Hey buddy, need a rod? I've got loads of state-of-the-art, top-of-the-line, high quality rods right here waitin' fer ya! Whaddya say?
        MEP_NHAPOPOLUKO_DIALOG        = 7245, -- Welcome! Fishermen's Guild representative, at your service!
        WHOA_HOLD_ON_NOW              = 7261, -- Whoa, hold on now. Ain't look like you got 'nuff room in that spiffy bag o' yours to carrrry all these darn clams. Why don't you trrry thrrrowin' some o' that old junk away before ya come back here 'gain?
        YOU_GIT_YER_BAG_READY         = 7262, -- You git yer bag ready, pardner? Well alrighty then. Here'rrre yer clams.
        YOU_RETURN_THE                = 7269, -- You return the <item>.
        AREA_IS_LITTERED              = 7270, -- The area is littered with pieces of broken seashells.
        YOU_FIND_ITEM                 = 7272, -- You find <item> and toss it into your bucket.
        THE_WEIGHT_IS_TOO_MUCH        = 7273, -- You find <item> and toss it into your bucket... But the weight is too much for the bucket and its bottom breaks! All your shellfish are washed back into the sea...
        YOU_CANNOT_COLLECT            = 7274, -- You cannot collect any clams with a broken bucket!
        IT_LOOKS_LIKE_SOMEONE         = 7275, -- It looks like someone has been digging here.
        YOUR_CLAMMING_CAPACITY        = 7283, -- Your clamming capacity has increased to <number> ponzes! Now you may be able to dig up a...
        SOMETHING_JUMPS_INTO          = 7286, -- Something jumps into your bucket and breaks through the bottom! All your shellfish are washed back into the sea...
        FISHING_MESSAGE_OFFSET        = 7287, -- You can't fish here.
        DIG_THROW_AWAY                = 7300, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7302, -- You dig and you dig, but find nothing.
        FOUND_ITEM_WITH_EASE          = 7377, -- It appears your chocobo found this item with ease.
        CLUNK_CLUNK_WHIRL_WHIZZ       = 7393, -- <Clunk-clunk>... <Whirl-whizz>...!
        IT_WAS_A_TRAP                 = 7462, -- It was a trap!
        YOU_ARE_NOT_ALONE             = 7463, -- You are not alone!
        NO_BILLET                     = 7505, -- You were refused passage for failing to present <item>!
        HAVE_BILLET                   = 7510, -- You cannot buy morrre than one <item>. Use the one you have now to ride the next ship.
        LEFT_BILLET                   = 7515, -- You use your <item>. (<number> trip[/s] remaining)
        END_BILLET                    = 7516, -- You use up your <item>.
        NOTHING_LEFT_INTEREST         = 7633, -- There is nothing left of interest here.
        SHEN_QM                       = 7634, -- Innumerable shrimp shells are floating in the water here.
        SHEN_SPAWN                    = 7635, -- The <item> begins skimming quietly across the surface of the water. ...What's this!? An enormous creature is chasing after it from below!!!
        UNITY_WANTED_BATTLE_INTERACT  = 8639, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 8661, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        NEWS_BILLET                   = 8684, -- <item> has been [added to your list of favorites/removed from your list of favorites].
    },
    mob =
    {
        INTULO     = GetFirstID('Intulo'),
        PEERIFOOL  = GetFirstID('Peerifool'),
        SERRA      = GetFirstID('Serra'),
        SPLACKNUCK = GetFirstID('Splacknuck'),
    },
    npc =
    {
    },
}

return zones[xi.zone.BIBIKI_BAY]
