-----------------------------------
-- Petals for Parelbriaux
-----------------------------------
-- Log ID: 4, Quest ID: 74
-- Chemioue    !pos 81.728 -33.970 66.351
-- Ondieulix   !pos 3.563 -21.912 65.983
-- Parelbriaux !pos 114.121 41.000 42.564
-- qm_baumesel !pos -211.481 -16.016 287.182
-----------------------------------
local lufaiseID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.PETALS_FOR_PARELBRIAUX)

quest.reward =
{
    item  = xi.item.POWERFUL_ROPE,
    title = xi.title.PUTRID_PURVEYOR_OF_PUNGENT_PETALS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Chemioue'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(512)
                    end
                end,
            },

            ['Ondieulix'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(514)
                    end
                end,
            },

            ['Parelbriaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(513)
                    end
                end,
            },

            onEventFinish =
            {
                [512] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [513] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [514] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LUFAISE_MEADOWS] =
        {

            ['Baumesel'] =
            {
                onMobDeath = function(mob, player, optParams)
                    player:setLocalVar('NMKilled', 1)
                end,
            },

            ['qm_baumesel'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        progress == 3 and
                        player:getLocalVar('NMKilled') == 1
                    then
                        npcUtil.giveKeyItem(player, xi.ki.PARTICULARLY_POIGNANT_PETAL)
                        return quest:progressCutscene(115)
                    elseif
                        progress == 3 and
                        player:getWeather() == xi.weather.FOG and
                        not GetMobByID(lufaiseID.mob.BAUMESEL):isSpawned()
                    then
                        npcUtil.popFromQM(player, npc, lufaiseID.mob.BAUMESEL, { claim = true, hide = 0 })
                        return quest:messageSpecial(lufaiseID.text.SPINE_CHILLING_PRESENCE)
                    end
                end,
            },

            onEventFinish =
            {
                [115] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Ondieulix'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(516)
                    end
                end,
            },

            onEventFinish =
            {
                [516] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.PARTICULARLY_POIGNANT_PETAL)
                    end
                end,
            },
        },
    },
}

return quest
