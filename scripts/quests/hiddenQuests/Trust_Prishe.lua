-----------------------------------
-- Trust: Prishe
-----------------------------------
-- Walnut Door : !pos 117.029 -42.799 41.997 26
-----------------------------------
local tavnaziaID = zones[xi.zone.TAVNAZIAN_SAFEHOLD]
-----------------------------------

local quest = HiddenQuest:new('TrustPrishe')

local trustMemory = function(player)
    local memories = 0

    -- Now that I think about it, I remember a time when some old jeweler over in Jeuno was going on and on about what "love" really is.
    -- You know what I learned from him? That love ain't something you know about until it hits you. So that means I don't know what love is?
    if player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.IN_THE_MOOD_FOR_LOVE) then
        memories = memories + 2
    end

    -- But I recall sharing something with a certain young girl...
    -- Animals have hearts and souls, just like people do, and their hearts are much more pure than ours.
    -- Now if only I were as pure as a moogle, then maybe...
    -- Ah, screw it all! What's this weird heat coming from my cheeks?
    if player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.A_CHOCOBOS_TALE) then
        memories = memories + 4
    end

    -- [Well, then/Hmm... Come to think of it], the two of us make one hell of a team, don't you agree?
    -- Although a certain someone yelled at me not to leap without looking all the time.
    -- Let me share with you a little something. There's this geezer over in Jeuno, always with his fishing rod by the docks, who musta stared daggers at me for hours on end.
    -- You'd picture he'd've just told me to be careful, but oh no!
    -- If it were you in a pit of snakes, though, I wouldn't care what any old fart would have to say! I'd throw myself in after you in a heartbeat!
    if player:hasCompletedMission(xi.questLog.JEUNO, xi.quest.id.jeuno.HOOK_LINE_AND_SINKER) then
        memories = memories + 8
    end

    -- The Shadow Lord, Kam'lanaut, Eald'narche, Nag'Molada...doesn't matter one bit to me.
    -- They may have succumbed--but we didn't. And you remember why, don't you?
    -- The light that brought us into this world shines brighter than the sun, and continues to bless the world, its people, and our hearts.
    if player:hasCompletedMission(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) then
        memories = memories + 16
    end

    return memories
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return  xi.trust.hasPermit(player) and
                not player:hasSpell(xi.magic.spell.PRISHE) and
                (player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.DAWN and
                xi.mission.getVar(player, xi.mission.log_id.COP, xi.mission.id.cop.DAWN, 'Status') >= 5)
                -- TODO: Additional conditions
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            -- Walnut Door
            ['_0qa'] =
            {
                onTrigger = function(player, npc, trade)
                    return quest:progressEvent(633, 0, 0, 0, trustMemory(player))
                end,
            },

            onEventFinish =
            {
                [633] = function(player, csid, option, npc)
                    if option == 2 and quest:complete(player) then
                        player:addSpell(xi.magic.spell.PRISHE, true, true)
                        player:messageSpecial(tavnaziaID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.PRISHE)
                    end
                end,
            },
        },
    },
}

return quest
