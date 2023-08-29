-----------------------------------
-- Trust: Cherukiki
-----------------------------------
-- Taillegeas : !pos 31.000 1.995 57.971 243
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------

local quest = HiddenQuest:new('TrustCherukiki')

local trustMemory = function(player)
    local memories = 0

    -- TODO: Does she have these?

    return memories
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return xi.trust.hasPermit(player) and
            not player:hasSpell(xi.magic.spell.CHERUKIKI) and
            (
                -- Between these missions
                (player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.CHAINS_AND_BONDS and
                player:getCurrentMission(xi.mission.log_id.COP) < xi.mission.id.cop.THE_WARRIORS_PATH)
                or
                -- On Dawn, but past "the boss"
                (player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.DAWN and
                player:getCharVar('PromathiaStatus') >= 3)
                or
                -- Past Dawn
                player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.DAWN
            )
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Taillegeas'] =
            {
                onTrigger = function(player, npc, trade)
                    return quest:progressEvent(10235, 0, 0, 0, trustMemory(player))
                end,
            },

            onEventFinish =
            {
                [10235] = function(player, csid, option, npc)
                    if option == 2 and quest:complete(player) then
                        player:addSpell(xi.magic.spell.CHERUKIKI, true, true)
                        player:messageSpecial(ruludeID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.CHERUKIKI)
                    end
                end,
            },
        },
    },
}

return quest
