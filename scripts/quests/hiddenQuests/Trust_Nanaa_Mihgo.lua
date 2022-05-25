-----------------------------------
-- Trust: Nanaa Mihgo
--
-- Nanaa Mihgo : !pos 26.965 1.999 -34.939 241
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/spell_data')
require('scripts/globals/interaction/hidden_quest')
-----------------------------------
local windurstWoodsID = require('scripts/zones/Windurst_Woods/IDs')
-----------------------------------
local quest = HiddenQuest:new("TrustNanaa")

local TrustMemory = function(player)
    local memories = 0
    -- 2 - Saw her at the start of the game
    if player:getNation() == xi.nation.WINDURST then
        memories = memories + 2
    end
    -- 4 - ROCK_RACKETEER
    if player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER) then
        memories = memories + 4
    end
    -- 8 - HITTING_THE_MARQUISATE
    if player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HITTING_THE_MARQUISATE) then
        memories = memories + 8
    end
    -- 16 - CRYING_OVER_ONIONS
    if player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS) then
        memories = memories + 16
    end
    -- 32 - hasItem(286) Nanaa Mihgo statue
    if player:hasItem(xi.items.NANAA_MIHGO_STATUE) then
        memories = memories + 32
    end
    -- 64 - ROAR_A_CAT_BURGLAR_BARES_HER_FANGS
    if player:hasCompletedMission(xi.mission.log_id.AMK, xi.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS) then
        memories = memories + 64
    end
    return memories
end


quest.sections =
{
    {
        check = function(player, questVars, vars)
            return player:hasKeyItem(xi.ki.WINDURST_TRUST_PERMIT) and
                not player:hasSpell(xi.magic.spell.NANAA_MIHGO)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa Mihgo'] =
            {
                onTrigger = function(player, npc)
                    local mihgosAmigo = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO)
                    local trustFlag = (player:getRank(player:getNation()) >=3 and 1 or 0) + (mihgosAmigo == QUEST_COMPLETED and 2 or 0)
                    quest:progressEvent(865, 0, 0, 0, TrustMemory(player), 0, 0, 0, trustFlag)
                end,
            },

            onEventFinish =
            {
                [865] = function(player, csid, option, npc)
                    if option == 2 and quest:complete(player) then
                        player:addSpell(xi.magic.spell.NANAA_MIHGO, true, true)
                        player:messageSpecial(windurstWoodsID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.NANAA_MIHGO)
                    end
                end,
            },
        },
    },
}

return quest
