-----------------------------------
-- Blighted Gloom
-- Luto Mewrilah !pos -53 0 45 244
-- qm2 (???) Jugnar Forest !pos -155 .5 492 104
-- qm3 (???) Korroloka Tunnel !pos -413 0 120 173
-- qm8 (???) Ordelles Caves !pos 44 30 430 193
-- qm1 (???) Ranguemont Pass !pos 54 10 -147 166
-----------------------------------
require('scripts/globals/items')
-- require("scripts/globals/pets/fellow")
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------


local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BLIGHTED_GLOOM)

quest.reward = {}

quest.sections = {

    -- Qm's normal state
     {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE or status == QUEST_COMPLETED
        end,

        [xi.zone.KORROLOKA_TUNNEL] = {
            ['qm3'] = {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                end
            },
        },

        [xi.zone.ORDELLES_CAVES] = {
            ['qm8'] = {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                end
            },
        },

        [xi.zone.RANGUEMONT_PASS] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                end
            },
        },

        [xi.zone.JUGNER_FOREST] = {
            ['qm2'] = {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                end
            },
        },
    },

    -- Section: Begin quest
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
                and player:getQuestStatus(JEUNO, PAST_REFLECTIONS) == QUEST_COMPLETED
                and player:getFellowValue("bond") >= 45
        end,

        [xi.zone.UPPER_JEUNO] = {
            ['Luto_Mewrilah'] = {
                onTrigger = function(player, npc)
                    local fellowParam = getFellowParam(player)
                    return quest:event(10065, {[7] = fellowParam})
                end,
            },

            onEventFinish = {
                [10065] = function(player, csid, option, npc)
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
            ['Luto_Mewrilah'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, "Prog") == 1 and player:hasKeyItem(xi.keyItem.VITRALLUM) then
                        local fellowParam = getFellowParam(player)
                        return quest:progressEvent(10066, {[7] = fellowParam})
                    end
                end,
            },

            onEventFinish = {
                [10066] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.KORROLOKA_TUNNEL] = {
            ['qm3'] = {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.keyItem.VITRALLUM) then
                        if quest:getVar(player, "Prog") == 0 and player:getLocalVar("Initiate") == 0 and not GetMobByID(zones[player:getZoneID()].mob.METALLIC_SLIME):isSpawned() then
                            local fellowParam = getFellowParam(player)
                            return quest:progressEvent(1, {[7] = fellowParam})
                        elseif quest:getVar(player, "Prog") == 1 then
                            npcUtil.giveKeyItem(player, xi.keyItem.VITRALLUM)
                        else
                            return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                        end
                    else
                        return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,
            },

            ['Metallic_Slime'] = {
                onMobDeath = function(mob, player, isKiller)
                    player:setLocalVar("triggerFellow", 1)
                    player:timer(30000, function(player) player:despawnFellow() end)
                end,
            },

            onEventFinish = {
                [1] = function(player, csid, option, npc)
                    quest.spawnMob(player)
                    player:getFellow():setPos(51, 13, -145, 49)
                end,
            },
        },

        [xi.zone.ORDELLES_CAVES] = {
            ['qm8'] = {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.keyItem.VITRALLUM) then
                        if quest:getVar(player, "Prog") == 0 and player:getLocalVar("Initiate") == 0 and not GetMobByID(zones[player:getZoneID()].mob.METALLIC_SLIME):isSpawned() then
                            local fellowParam = getFellowParam(player)
                            return quest:progressEvent(56, {[7] = fellowParam})
                        elseif quest:getVar(player, "Prog") == 1 then
                            npcUtil.giveKeyItem(player, xi.keyItem.VITRALLUM)
                        else
                            return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                        end
                    else
                        return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,
            },

            ['Metallic_Slime'] = {
                onMobDeath = function(mob, player, isKiller)
                    player:setLocalVar("triggerFellow", 1)
                    player:timer(30000, function(player) player:despawnFellow() end)
                end,
            },

            onEventFinish = {
                [56] = function(player, csid, option, npc)
                    quest.spawnMob(player)
                    player:getFellow():setPos(51, 13, -145, 49)
                end,
            },
        },

        [xi.zone.RANGUEMONT_PASS] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.keyItem.VITRALLUM) then
                        if quest:getVar(player, "Prog") == 0 and player:getLocalVar("Initiate") == 0 and not GetMobByID(zones[player:getZoneID()].mob.METALLIC_SLIME):isSpawned() then
                            local fellowParam = getFellowParam(player)
                            return quest:progressEvent(22, {[7] = fellowParam})
                        elseif quest:getVar(player, "Prog") == 1 then
                            npcUtil.giveKeyItem(player, xi.keyItem.VITRALLUM)
                        else
                            return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                        end
                    else
                        return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,
            },

            ['Metallic_Slime'] = {
                onMobDeath = function(mob, player, isKiller)
                    player:setLocalVar("triggerFellow", 1)
                    player:timer(30000, function(player) player:despawnFellow() end)
                end,
            },

            onEventFinish = {
                [22] = function(player, csid, option, npc)
                    quest.spawnMob(player)
                    player:getFellow():setPos(51, 13, -145, 49)
                end,
            },
        },

        [xi.zone.JUGNER_FOREST] = {
            ['qm2'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, "Prog") == 2 then
                        local fellowParam = getFellowParam(player)
                        return quest:progressEvent(31, {[0] = 104, [1] = 23, [3] = 1743, [7] = fellowParam})
                    else
                        return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                    end
                end
            },

            onEventFinish = {
                [31] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:delKeyItem(xi.keyItem.VITRALLUM)
                    player:setFellowValue("bondcap", 70)
                    player:messageText(player, zones[player:getZoneID()].text.FELLOW_STRENGTH)
                end,
            },
        },
    },
}

quest.spawnMob = function(player)
    SpawnMob(zones[player:getZoneID()].mob.METALLIC_SLIME):updateClaim(player)
    player:setLocalVar("FellowAttack", 1) -- fellow cannot sync attack
    player:setLocalVar("FellowDisengage", 1) -- fellow cannot sync disengage
    player:setLocalVar("triggerFellow", 1) -- must talk to fellow(alive) after fight to proceed
    player:setLocalVar("FellowSpawn", 1) -- no timer set
    player:spawnFellow(player:getFellowValue("fellowid"))
    player:fellowAttack(GetMobByID(zones[player:getZoneID()].mob.METALLIC_SLIME))
    player:setLocalVar("Initiate", 1)
end

return quest
