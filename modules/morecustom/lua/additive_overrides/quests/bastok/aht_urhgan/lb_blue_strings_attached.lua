-------------------------------------------------------
-- Blue Strings Attached (Lv66)
-------------------------------------------------------
-- Steps
-------------------------------------------------------
-- !setvar [LB]BLUE_STRINGS_ATTACHED 0
-- Kirk      !pos -286.2880 -12.0200 -83.6707 235
-- Lars      !pos 461.4646 -34.1743 102.7589 79
-- Ktulu     !pos 479.0318 -36.2500 106.8963 79
-- Kirk      !pos -286.2880 -12.0200 -83.6707 235
-- Unlocks: Lv71-75 (PUP LB5)
-------------------------------------------------------
-- !setvar [LB]BLUE_STRINGS_ATTACHED 1

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
        blu_testimony = { { 2331, 1 } },
        pup_testimony = { { 2333, 1 } }
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
        pos    = { 8.52, 11.04, 0, 90 }, -- !pos 8.52 11.04 0 90
        dialog =
        {
            NAME      = true,
            DEFAULT   = { "I am a 400-foot tall purple platypus bear with pink horns and silver wings." },
            START     =
            {
                { emote = xi.emote.WAVE },
                "Ah, an adventurer approaches...", 
                { delay = 1000 },
                { emote = xi.emote.welcome },
                "Strings that dance, magic that flows... Do you understand the harmony between control and chaos?",
                { delay = 2000 },
                "A puppet may move with grace, yet it is only as strong as the hand that guides it. Magic may be unleashed with power, yet without wisdom, it is but a fleeting spark.",
                { delay = 2000 },
                { emote = xi.emote.POINT },
                "If you seek mastery, show me proof that you have walked both paths. Bring me a Blue Mage and Puppetmaster Testimony. Only then will I acknowledge your worth.",
                { delay = 2000 },
                { emote = xi.emote.CROSSED_ARMS },
                "Many have dared, only to find themselves tangled in their own strings, burned by the very magic they sought to create. Rise above, or be reduced to nothing but a cautionary tale.",
            },
            REMINDER = { "You need both testimonies to prove your understanding of balance. Do not return empty-handed." },
            FINISH   = 
            {
                { emote = xi.emote.NOD },
                "So, you have grasped both the strings of control and the ebb of magic...", 
                { delay = 2000 },
                "Very well. You have earned my recognition. But remember, a true master never ceases to refine their craft."
            },
            AFTER    = { "The puppet dances, the magic flows... and you have found your place among them." },
        },
    },
}

local step =
{
    {
        check      = cq.checks({ level = 66, job = { xi.job.PUP, xi.job.BLU } }),
        [AZULA]    = cq.talkStep("START", info.name),
    },
    {
        [AZULA] =
        {
            onTrigger = cq.talkOnly("REMINDER"),
            onTrade   = cq.tradeStep("FINISH", "REMINDER", info.required.items),
        }
    },
    {
        check      = cq.checks({ job = { xi.job.PUP, xi.job.BLU } }),
        [AZULA]    = cq.talkOnly("AFTER"),
    }
}

cq.add(m, {
    info   = info,
    entity = entity,
    step   = step,
})

return m
