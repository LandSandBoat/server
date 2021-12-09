-----------------------------------
-- Trust: Cherukiki
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/magic')
require('scripts/globals/trust')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/hidden_quest')
-----------------------------------
local ruludeID = require('scripts/zones/RuLude_Gardens/IDs')
-----------------------------------

local quest = HiddenQuest:new('TrustCherukiki')

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return xi.trust.hasPermit(player) and
            not player:hasSpell(xi.magic.spell.CHERUKIKI) and
            (
                -- Between these missions
                (player:getCurrentMission(COP) > xi.mission.id.cop.CHAINS_AND_BONDS and
                player:getCurrentMission(COP) < xi.mission.id.cop.THE_WARRIOR_S_PATH)
                or
                -- On Dawn, but past "the boss"
                (player:getCurrentMission(COP) > xi.mission.id.cop.DAWN and
                player:getCharVar("PromathiaStatus") == 3)
                or
                -- Past Dawn
                player:getCurrentMission(COP) > xi.mission.id.cop.DAWN
            )
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Taillegeas'] = quest:progressEvent(10235),

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
