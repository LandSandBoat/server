-----------------------------------
-- Trust: Maat
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/magic')
require('scripts/globals/trust')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/hidden_quest')
local ID = require('scripts/zones/RuLude_Gardens/IDs')
-----------------------------------

local quest = HiddenQuest:new("TrustMaat")

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return xi.trust.hasPermit(player) and
                   utils.mask.countBits(player:getCharVar("maatsCap"), 16) >= 6 and
                   not player:hasSpell(xi.magic.spell.MAAT)
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] = quest:progressEvent(10241),

            onEventFinish =
            {
                [10241] = function(player, csid, option, npc)
                    if option == 2 and quest:complete(player) then
                        player:addSpell(xi.magic.spell.MAAT, true, true)
                        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.MAAT)
                    end
                end,
            },
        },
    },
}

return quest
