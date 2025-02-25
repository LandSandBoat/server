-------------------------------------------------------
-- Blue Strings Attached (Lv66)
-------------------------------------------------------
-- Steps
-------------------------------------------------------
-- !setvar [LB]BLUE_STRINGS_ATTACHED 0
-- Azula     !pos 11.8379 0.0000 0.1778 270
-- Unlocks: Lv71-75 (PUP LB5, BLU LB5)
-------------------------------------------------------
-- !setvar [LB]BLUE_STRINGS_ATTACHED 2

require("modules/module_utils")
require('scripts/globals/utils')
require('scripts/globals/player')
require('scripts/globals/npc_util')
local cq = require("modules/morecustom/lua/additive_overrides/utils/custom_quest")
-------------------------------------------------------
local m = Module:new("lb_quest-blue_strings_attached")

local info =
{
    name   = "Blue Strings Attached",
    author = "Kyoko",
    var    = "[LB]BLUE_STRINGS_ATTACHED",
    required =
    {
        item = { { 2331, 1 }, { 2333, 1 } }, -- blue mage and puppetmaster testimonies
    },
    reward =
    {
        after = function(player)
            local job = player:getMainJob()
            if job == xi.job.PUP then
                player:setCharVar("[LB]PUP", 1)
            elseif job == xi.job.BLU then
                player:setCharVar("[LB]BLU", 1)
            end

            if player:getLevelCap() < 75 then
                player:setLevelCap(75);
                player:printToPlayer("Your level limit is now 75.", xi.msg.channel.SYSTEM_3)
                local shatteringStarsStatus = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)

                if shatteringStarsStatus ~= xi.questStatus.QUEST_COMPLETED and shatteringStarsStatus ~= xi.questStatus.QUEST_ACCEPTED then
                    player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)
                    player:printToPlayer("Completing this quest has also completed 'Shattering Stars'.", xi.msg.channel.SYSTEM_3)
                end
            end
            return true
        end,
    },
}

local AZULA = "AZULA"

local entity =
{
    {
        id     = AZULA,
        name   = "Azula",
        type   = xi.objType.NPC,
        look   = "0x0000170300000000000000000000000000000000",
        area   = "Aht_Urhgan_Whitegate",
        pos    = { 11.8379, 0.0000, 0.1778, 270 }, -- !pos 11.8379 0.0000 0.1778 270
        dialog =
        {
            NAME      = true,
            DEFAULT   = { 
                { entity = "Azula", face  = "player" },
                "I am a 400-foot tall purple platypus bear with pink horns and silver wings." 
            },
            START     =
            {
                { entity = "Azula", face  = "player" },
                "Ah, an adventurer approaches...", 
                { delay = 2000 },
                "Strings that dance, magic that flows... Do you understand the harmony between control and chaos?",
                { delay = 2000 },
                "A puppet may move with grace, yet it is only as strong as the hand that guides it.",
                { delay = 2000 },
                "Magic may be unleashed with power, yet without wisdom, it is but a fleeting spark.",
                { delay = 2000 },
                "If you seek mastery, show me proof that you have walked both paths.",
                { delay = 2000 },
                "Bring me a Blue Mage and a Puppetmaster Testimony. Only then will I acknowledge your worth.",
                { delay = 2000 },
                "Many have dared, only to find themselves tangled in their own strings, burned by the very magic they sought to create.",
                { delay = 2000 },
                "Rise above, or be reduced to nothing but a cautionary tale.",
            },
            REMINDER   = { "Bring me a Blue Mage and a Puppetmaster Testimony. Only then will I acknowledge your worth." },
            ACCEPTED   = 
            {
                { entity = "Azula", face  = "player" },
                "So, you have grasped both the strings of control and the ebb of magic...", 
                { delay = 3000 },
                "Very well. You have earned my recognition. But remember, a true master never ceases to refine their craft."
            },
            DECLINED     = { 
                { entity = "Azula", face  = "player" },
                "Nice try, but you cannot fool me. I will tolerate your presence for a little longer, but do not test my patience." 
            },
            AFTER        = { 
                { entity = "Azula", face  = "player" },
                "The puppet dances, the magic flows... and you have found your place among them."
            },
        },
    },
}

local step =
{
    {
        check      = cq.checks({ level = 66, job = { xi.job.BLU, xi.job.PUP } }),
        [AZULA]    = cq.talkStep("START", info.name),
    },
    {
        [AZULA] =
        {
            onTrigger = cq.talkOnly("REMINDER"),
            onTrade   = cq.tradeStep("ACCEPTED", "DECLINED", info.required.item, info.reward, info.name, cbxi.music.WHITEGATE),
        }
    },
    {
        check      = cq.checks({ job = { xi.job.BLU, xi.job.PUP } }),
        [AZULA]    = cq.talkOnly("AFTER"),
    },
}

cq.add(m, {
    info   = info,
    entity = entity,
    step   = step,
})

return m
