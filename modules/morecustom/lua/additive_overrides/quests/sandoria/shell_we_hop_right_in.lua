-------------------------------------------------------
-- Shell We Hop Right In? (Beastly Shank - Behemoth Pop Item)
-------------------------------------------------------
-- Steps
-------------------------------------------------------
-- !setvar [CB]SHELL_WE_HOP_RIGHT_IN 0
-- Shellnut     !pos 15.0439 -14.0000 -101.9381 139
-- Unlocks: Beastly Shank (Behemoth Pop Item)
-------------------------------------------------------
-- !setvar [CB]SHELL_WE_HOP_RIGHT_IN 1

require("modules/module_utils")
require('scripts/globals/utils')
require('scripts/globals/player')
require('scripts/globals/npc_util')
local cq = require("modules/morecustom/lua/additive_overrides/utils/custom_quest")
-------------------------------------------------------
local m = Module:new("shell_we_hop_right_in?")

local info =
{
    name   = "Shell_We_Hop_Right_In?",
    author = "Kyoko",
    var    = "Shell_We_Hop_Right_In?",
    required =
    {
        item = { { 539, 1 }, { 542, 1 } }, -- crab apron and wild rabbit tail
    },
    reward = 
    {
        item = { { 3342, 1 } } -- savory shank
    },
}

local SHELLNUT = "SHELLNUT"

local entity =
{
    {
        id     = SHELLNUT,
        name   = "Shellnut",
        type   = xi.objType.NPC,
        look   = "0x00003A0B00000000000000000000000000000000",
        area   = "Port_San_dOria",
        pos    = { 15.0439, -14.0000, -101.9381, 139 }, -- !pos 15.0439 -14.0000 -101.9381 139
        dialog =
        {
            NAME      = true,
            DEFAULT   = { 
                { entity = "Shellnut", face  = "player" },
                "blub blub blub." 
            },
            START     =
            {
                { entity = "Shellnut", face  = "player" },
                "Too many adventures have stolen my apron!", 
                { delay = 2000 },
                "My friend , Bunjamin, has lost too many of his wild tails!",
                { delay = 2000 },
                "Bring us back what we have lost and I will introduce you to our friend.",
                { delay = 2000 },
                "Our purple friend."
            },
            REMINDER   = { "Bring me back our apron and tail for your reward." },
            ACCEPTED   = 
            {
                { entity = "Shellnut", face  = "player" },
                "Much appreciated! Now you can use this to lure out our ...friend.", 
                { delay = 3000 },
                "If you find more, continue to bring them to me! If you don't die to the Behe.."
            },
            DECLINED     = { 
                { entity = "Shellnut", face  = "player" },
                "This is not what I asked for!" 
            },
        },
    },
    {
        id     = BUNJAMIN,
        name   = "Bunjamin",
        type   = xi.objType.NPC,
        look   = "0x00000C0100000000000000000000000000000000",
        area   = "Port_San_dOria",
        pos    = { 14.8755, -14.0000, -99.5696, 118 }, -- !pos 14.8755 -14.0000 -99.5696 118
        dialog =
        {
            NAME      = true,
            DEFAULT   = { 
                { entity = "Shellnut", face  = "player" },
                "blub blub blub." 
            },
    }
}

local step =
{
    {
        [SHELLNUT]    = cq.talkStep("START", info.name),
    },
    {
        [SHELLNUT] =
        {
            onTrigger = cq.talkOnly("REMINDER"),
            onTrade   = cq.tradeStep("ACCEPTED", "DECLINED", info.required.item, info.reward, info.name, cbxi.music.SANDORIA),
        },
    },
}

cq.add(m, {
    info   = info,
    entity = entity,
    step   = step,
})

return m
