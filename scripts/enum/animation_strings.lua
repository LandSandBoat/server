-----------------------------------
-- Animation strings
-----------------------------------
xi = xi or {}

--[[
-----------------------------------
mob:entityAnimationPacket(xi.animationString.STATUS_VISIBLE)
-----------------------------------
The base entity is a mob, and anyone in range to see the mob sees the animation.
We do accept a second argument in this one, for target.
An example of this is the afflictors in Beadeaux, which target the player.

-----------------------------------
player:entityVisualPacket(xi.animationString.STATUS_VISIBLE)
-----------------------------------
In this, it's a part of the zone itself animating, so player is used as base entity and any player that zones in gets sent the packet to light up that part of the zone.
There is technically an "object" or "entity" but its not ID'd like an NPC, and technically speaking a zone dat is laid out like NPC's are part of it.

-----------------------------------
SendEntityVisualPacket(ID.npc.GEYSER_OFFSET,xi.animationString.STATUS_VISIBLE)
-----------------------------------
This one is a luautils binding, sending a packet to the entire zone (of whoever is in visual range of the ID specified) on demand.

These are FOURCC (4 character codes). They will always be 4, not 5+.
For most things you can get away with using the wrong one, and they still just work.
--]]

---@enum xi.animationString
xi.animationString =
{
    -- Physical
    ATTACK_1                  = 'ati0',
    ATTACK_2                  = 'ati1',
    ATTACK_3                  = 'ati2',
    CRITICAL_HIT              = 'chit',

    -- Ranged start
    RANGED_SINGING_START      = 'lc00',
    RANGED_WIND_INSTR_START   = 'lc01',
    RANGED_STRING_INSTR_START = 'lc02',
    RANGED_GUN_START          = 'lc03',
    RANGED_BOOMERANG_START    = 'lc04',
    RANGED_BOW_START          = 'lc06',

    -- Ranged stop
    RANGED_SINGING_STOP       = 'ls00',
    RANGED_WIND_INSTR_STOP    = 'ls01',
    RANGED_STRING_INSTR_STOP  = 'ls02',
    RANGED_GUN_STOP           = 'ls03',
    RANGED_BOOMERANG_STOP     = 'ls04',
    RANGED_BOW_STOP           = 'ls06',

    -- Casting start
    CAST_BLACK_MAGIC_START    = 'cabk',
    CAST_BLUE_MAGIC_START     = 'cabl',
    CAST_ITEM_START           = 'cait',
    CAST_NINJA_START          = 'canj',
    CAST_SUMMONER_START       = 'casm',
    CAST_SONG_START           = 'caso',
    CAST_WHITE_MAGIC_START    = 'cawh',

    -- Casting finish
    CAST_BLACK_MAGIC_STOP     = 'shbk',
    CAST_BLUE_MAGIC_STOP      = 'shbl',
    CAST_ITEM_STOP            = 'shit',
    CAST_NINJA_STOP           = 'shnj',
    CAST_SUMMONER_STOP        = 'shsm',
    CAST_SONG_STOP            = 'shso',
    CAST_WHITE_MAGIC_STOP     = 'shwh',

    -- Actions
    JUMP_0                    = 'jmp0',
    JUMP_1                    = 'jmp1',
    RESTING_START             = 'res0',
    RESTING_STOP              = 'res2',
    SITTING_START             = 'sit0',
    SITTING_STOP              = 'sit2',

    -- Effects
    EFFECT_DEATH              = 'dead',
    EFFECT_SWEATING           = 'hitl',
    EFFECT_SILENCE            = 'sils',
    EFFECT_RAISE_PLAYER       = 'stnd',

    -- Status
    STATUS_VISIBLE            = 'deru',
    STATUS_DISAPPEAR          = 'kesu',

    -- Chests
    OPEN_CRATE_GLOW           = 'open',
    OPEN_CRATE_SMOKE          = 'ope1',
    OPEN_CRATE                = 'ope2',

    -- Doors
    OPEN_DOOR                 = 'smin',
    CLOSE_DOOR                = 'kmin',

    -- Special animations
    SPECIAL_00                = 'sp00', -- Prishe Raise, Selh'teus Lancet, Al'tieu Euvhi (Flowers) sticking to ground, Zdei vertical barriers on, etc...
    SPECIAL_10                = 'sp10', -- Zdei vertical barriers off, etc...
    SPECIAL_20                = 'sp20', -- Zdei horizontal barriers on, etc...
    SPECIAL_30                = 'sp30', -- Zdei horizontal barriers off, etc...
}
