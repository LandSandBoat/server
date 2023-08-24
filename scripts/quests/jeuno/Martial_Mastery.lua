-----------------------------------
-- Martial Mastery
-----------------------------------
-- !addquest 3 167
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local ruLudeID = require('scripts/zones/RuLude_Gardens/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MARTIAL_MASTERY)

quest.reward =
{
    keyItem = xi.ki.HEART_OF_THE_BUSHIN,
    title = xi.title.BUSHIN_RYU_INHERITOR,
}

local validCombatSkills =
{
    xi.skill.HAND_TO_HAND,
    xi.skill.DAGGER,
    xi.skill.SWORD,
    xi.skill.GREAT_SWORD,
    xi.skill.AXE,
    xi.skill.GREAT_AXE,
    xi.skill.SCYTHE,
    xi.skill.POLEARM,
    xi.skill.KATANA,
    xi.skill.GREAT_KATANA,
    xi.skill.CLUB,
    xi.skill.STAFF,
    xi.skill.ARCHERY,
    xi.skill.MARKSMANSHIP,
}

local function hasRequiredCombatSkill(player)
    for _, v in ipairs(validCombatSkills) do
        if player:getSkillLevel(v) >= 357 then
            return true
        end
    end

    return false
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 96 and
                hasRequiredCombatSkill(player)
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] = quest:progressEvent(10196),

            onEventFinish =
            {
                [10196] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            -- TODO: Confirm that the player must be on a valid job to complete
            return status == QUEST_ACCEPTED and
                player:getMainLvl() >= 96 and
                hasRequiredCombatSkill(player) and
                player:getMeritCount() >= 15
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] = quest:progressEvent(10198),

            onEventFinish =
            {
                [10198] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setMerits(player:getMeritCount() - 15)
                        player:messageSpecial(ruLudeID.text.LEARNED_SECRET_TECHNIQUE)
                    end
                end,
            },
        },
    },
}

return quest
