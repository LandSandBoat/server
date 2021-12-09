-----------------------------------
-- Trust: Ulmia
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/magic')
require('scripts/globals/trust')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/hidden_quest')
-----------------------------------
local misareauxID = require("scripts/zones/Misareaux_Coast/IDs")
-----------------------------------

local quest = HiddenQuest:new("TrustUlmia")

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return xi.trust.hasPermit(player) and
            not player:hasSpell(xi.magic.spell.PRISHE) and
            -- On Dawn, but past "the boss"
            (player:getCurrentMission(COP) > xi.mission.id.cop.DAWN and
            player:getCharVar("PromathiaStatus") == 3)
            -- TODO: Additional conditions
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            -- Dilapidated Gate
            -- TODO: TrustMemory dialogues here
            -- Ulmia makes references to the following quests if you have completed them:
            -- Apocalypse Nigh: "When I sang the Lay of the Immortals before the fifth crystal..."
            ['_0p0'] = quest:progressEvent(560),

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
