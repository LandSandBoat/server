-----------------------------------
-- Behind the Smile
-----------------------------------
-- Log ID: 4, Quest ID: 77
-- Enaremand : !pos 96.514 -41 51.613
-----------------------------------
local carpentersLandingID  = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.BEHIND_THE_SMILE)

quest.reward =
{
    item  = xi.item.MANNEQUIN_PUMPS,
}

quest.sections =
{
    -- START: Talk to Enaremand (J-7) on the upper level in Tavnazian Safehold
    -- QUEST AVAILABLE
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ITS_RAINING_MANNEQUINS)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Enaremand'] = quest:progressEvent(533),

            onEventFinish =
            {
                [533] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- QUEST ACCEPTED
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Enaremand'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.RED_OIL) then
                        return quest:progressEvent(534)
                    else
                        return quest:event(541)
                    end
                end,
            },

            onEventFinish =
            {
                [534] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.RED_OIL)
                    end
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            ['Fyi_Chalmwoh'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(320)
                    end
                end,
            },

            onEventFinish =
            {
                [320] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.CARPENTERS_LANDING] =
        {
            ['qm_behind_the_smile'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    if
                        questProgress == 1 and
                        not GetMobByID(carpentersLandingID.mob.BULLHEADED_GROSVEZ):isSpawned()
                    then
                        SpawnMob(carpentersLandingID.mob.BULLHEADED_GROSVEZ):updateClaim(player)
                        return quest:messageSpecial(carpentersLandingID.text.STENCH_OF_DECAY)
                    elseif questProgress == 2 then
                        quest:setVar(player, 'Prog', 3)
                        npcUtil.giveKeyItem(player, xi.ki.RED_OIL)
                        return quest:noAction()
                    end
                end,
            },

            ['Bullheaded_Grosvez'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        }
    },
}

return quest
