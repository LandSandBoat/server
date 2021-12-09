-----------------------------------
-- Trust: Prishe
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/magic')
require('scripts/globals/trust')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/hidden_quest')
-----------------------------------
local tavnaziaID = require("scripts/zones/Tavnazian_Safehold/IDs")
-----------------------------------

local quest = HiddenQuest:new("TrustPrishe")

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
            -- Walnut Door
            -- TODO: TrustMemory dialogues here
            -- Prishe makes references to the following quests if you have completed them:
            -- In the Mood for Love: mentions a jeweler
            -- A Chocobo's Tale: mentions sharing something with a young girl
            -- Hook, Line, and Sinker: mentions a fisherman
            -- Apocalypse Nigh: mentions Eald'narche and other mission bosses
            ['_0qa'] = quest:progressEvent(633),

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
