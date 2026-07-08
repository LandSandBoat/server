-----------------------------------
-- Trust: Nashmeira
-----------------------------------
local whitegateID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
local quest = HiddenQuest:new('TrustNashmeira')

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return xi.settings.main.ENABLE_TRUST_QUESTS == 1 and
                xi.trust.hasPermit(player) and
                not player:hasSpell(xi.magic.spell.NASHMEIRA) and
                player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_EMPRESS_CROWNED)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(5092, { text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [5092] = function(player, csid, option, npc)
                    if option == 2 and quest:complete(player) then
                        player:addSpell(xi.magic.spell.NASHMEIRA, { silentLog = true })
                        player:messageSpecial(whitegateID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.NASHMEIRA)
                    end
                end,
            },
        },
    },
}

return quest
