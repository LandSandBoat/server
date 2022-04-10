-----------------------------------
-- Trust: Shantotto
--
-- Shantotto : !pos 122 -2 112 239
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/spell_data')
require('scripts/globals/interaction/hidden_quest')
-----------------------------------
local windurstWallsID = require('scripts/zones/Windurst_Walls/IDs')
-----------------------------------
local quest = HiddenQuest:new("TrustSemih")

local TrustMemory = function(player)
    local memories = 0
    --[[ TODO
    -- 2 - The Three Kingdoms
    if player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK2) or player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2) then
        memories = memories + 2
    end
    -- 4 - Where Two Paths Converge
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) then
        memories = memories + 4
    end
    -- 8 - The Pirate's Cove
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_PIRATES_COVE) then
        memories = memories + 8
    end
    -- 16 - Ayame and Kaede
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE) then
        memories = memories + 16
    end
    -- 32 - Light of Judgement
    if player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT) then
        memories = memories + 32
    end
    -- 64 - True Strength
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH) then
        memories = memories + 64
    end
    ]]--

    -- Kill a Taru under the gun
    -- Defeated Shadowlord
    -- Saving Star Sibyl
    -- Grade, came up in spades
    -- Bring back Prishe
    -- Yoran Oran: No Heir
    -- Incident with Ragnarok
    -- Chocobo Races
    -- Markovich
    -- Puppet Twin battle
    -- Yoran-Oran and Koru-Moru
    -- Grimy Hat
    return memories
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return player:hasSpell(xi.magic.spell.KUPIPI) and
                player:hasSpell(xi.magic.spell.NANAA_MIHGO) and
                player:hasSpell(xi.magic.spell.VOLKER) and
                player:hasSpell(xi.magic.spell.AJIDO_MARUJIDO) and
                player:hasSpell(xi.magic.spell.TRION) and
                not player:hasSpell(xi.magic.spell.SHANTOTTO) and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_A_GOLEM)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    local foiledAGolem = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_A_GOLEM)
                    quest:progressEvent(529, 0, 0, 0, TrustMemory(player), 0, 0, 0, foiledAGolem == QUEST_COMPLETED and 1 or 0)
                end,
            },

            onEventFinish =
            {
                [529] = function(player, csid, option, npc)
                    if option == 2 and quest:complete(player) then
                        player:addSpell(xi.magic.spell.SHANTOTTO, true, true)
                        player:messageSpecial(windurstWallsID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.SHANTOTTO)
                    end
                end,
            },
        },
    },
}

return quest
