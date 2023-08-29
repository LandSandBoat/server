-----------------------------------
-- Trust: Ulmia
-----------------------------------
-- Dilapidated Gate : !pos 260.000 7.319 -440.001 25
-----------------------------------
local misareauxID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------

local quest = HiddenQuest:new('TrustUlmia')

local trustMemory = function(player)
    local memories = 0

    -- When I sang the Lay of the Immortals before the fifth crystal, it stirred up emotions within me.
    -- It dawned on me that it was not the oppressive weight of darkness that brought us together, but the holy light of the crystals.
    -- So now...
    if player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) then
        memories = memories + 2
    end

    return memories
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return xi.trust.hasPermit(player) and
            not player:hasSpell(xi.magic.spell.ULMIA) and
            -- On Dawn, but past "the boss"
            (player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.DAWN and
            player:getCharVar('PromathiaStatus') == 3)
            -- TODO: Additional conditions
        end,

        [xi.zone.MISAREAUX_COAST] =
        {
            -- Dilapidated Gate
            ['_0p0'] =
            {
                onTrigger = function(player, npc, trade)
                    return quest:progressEvent(560, 0, 0, 0, trustMemory(player))
                end,
            },

            onEventFinish =
            {
                [560] = function(player, csid, option, npc)
                    if option == 2 and quest:complete(player) then
                        player:addSpell(xi.magic.spell.ULMIA, true, true)
                        player:messageSpecial(misareauxID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.ULMIA)
                    end
                end,
            },
        },
    },
}

return quest
