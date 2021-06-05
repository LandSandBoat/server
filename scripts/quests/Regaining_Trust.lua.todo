-----------------------------------
-- Regaining Trust
-- Luto Mewrilah !pos -53 0 45 244
-- Monberaux !pos -42 0 -2 244
-- Giant Footprint !pos -501 -11 354 126
-----------------------------------
require('scripts/globals/items')
-- require("scripts/globals/pets/fellow")
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------


local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.REGAINING_TRUST)

quest.reward = {}

quest.sections = {

    -- Qm's normal state
     {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE or status == QUEST_COMPLETED
        end,

        [xi.zone.QUFIM_ISLAND] = {
            ['Giant_Footprint'] = {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.GIGANTIC_FOOTPRINT)
                end
            },
        },
    },

    -- Section: Begin quest
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
                and player:getQuestStatus(OTHER_AREAS_LOG, PICTURE_PERFECT) == QUEST_COMPLETED
                and player:getFellowValue("level") >= 51
                and player:getFellowValue("bond") >= 55
        end,

        [xi.zone.UPPER_JEUNO] = {
            ['Luto_Mewrilah'] = {
                onTrigger = function(player, npc)
                    local fellowParam = getFellowParam(player)
                    return quest:progressEvent(10058, {[7] = fellowParam})
                end,
            },

            onEventFinish = {
                [10058] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },


    -- Section: Questing
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.UPPER_JEUNO] = {
            ['Monberaux'] = {
                onTrigger = function(player, npc)
                    local fellowParam = getFellowParam(player)
                    if quest:getVar(player, "Prog") == 0 then
                        return quest:progressEvent(10059, {[7] = fellowParam})
                    elseif quest:getVar(player, "Prog") == 5 then
                        return quest:progressEvent(10062, {[7] = fellowParam})
                    end
                end,
            },

            ['Luto_Mewrilah'] = {
                onTrigger = function(player, npc)
                    local fellowParam = getFellowParam(player)
                    if quest:getVar(player, "Prog") == 1 then
                        return quest:progressEvent(10060, {[7] = fellowParam})
                    elseif quest:getVar(player, "Prog") == 4 then
                        return quest:progressEvent(10061, {[7] = fellowParam})
                    end
                end,
            },

            onEventFinish = {
                [10059] = function(player, csid, option, npc)
                    local fellowParam = getFellowParam(player)
                    quest:setVar(player, 'Prog', 1)
                end,

                [10060] = function(player, csid, option, npc)
                    local fellowParam = getFellowParam(player)
                    return quest:progressEvent(10204, {[7] = fellowParam})
                end,

                [10061] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [10062] = function(player, csid, option, npc)
                    local fellowParam = getFellowParam(player)
                    return quest:progressEvent(10206, {[7] = fellowParam})
                end,

                [10204] = function(player, csid, option, npc)
                    local fellowParam = getFellowParam(player)
                    return quest:progressEvent(10205, {[7] = fellowParam})
                end,

                [10205] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [10206] = function(player, csid, option, npc)
                    local fellowParam = getFellowParam(player)
                    return quest:progressEvent(10207, {[7] = fellowParam})
                end,

                [10207] = function(player, csid, option, npc)
                    player:setFellowValue("lvlcap", 60)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.QUFIM_ISLAND] = {
            ['Giant_Footprint'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, "Prog") == 2 and player:getLocalVar("Initiate") == 0 and not GetMobByID(zones[player:getZoneID()].mob.INGAEVON):isSpawned() then
                        local fellowParam = getFellowParam(player)
                        return quest:progressEvent(10000, {[7] = fellowParam})
                    elseif quest:getVar(player, "Prog") == 3 then
                        local personality = checkPersonality(player)
                        if personality > 5 then personality = personality - 1 end
                        quest:setVar(player, "Prog", 4)
                        return quest:messageSpecial(zones[player:getZoneID()].text.GIGANTIC_FOOTPRINT + 1 + personality)
                    else
                        return quest:messageSpecial(zones[player:getZoneID()].text.GIGANTIC_FOOTPRINT)
                    end
                end,
            },

            ['Ingaevon'] = {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    local fellow = player:getFellow()

                    if fellow ~= nil and quest:getVar(player, "Prog") == 2 then
                        player:setLocalVar("triggerFellow", 1) -- must talk to fellow(alive) after fight to proceed
                        player:timer(30000, function(player) player:despawnFellow() end) -- 30 sec to talk to fellow
                        player:showText(player:getFellow(), zones[player:getZoneID()].text.WHY_COME)
                    end
                end,
            },

            onEventFinish = {
                [10000] = function(player, csid, option, npc)
                    SpawnMob(zones[player:getZoneID()].mob.INGAEVON):updateClaim(player)
                    player:setLocalVar("FellowSpawn", 1) -- no timer set
                    player:setLocalVar("FellowAttack", 1) -- fellow cannot sync attack
                    player:setLocalVar("FellowDisengage", 1) -- fellow cannot sync disengage
                    player:spawnFellow(player:getFellowValue("fellowid"))
                    player:getFellow():setPos(-504, -11, 362, 47)
                    player:fellowAttack(GetMobByID(zones[player:getZoneID()].mob.INGAEVON))
                    player:setLocalVar("Initiate", 1)
                end,
            },
        },
    },
}

return quest
