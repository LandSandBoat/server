-----------------------------------
-- Twenty in Pirate Years
-----------------------------------
-- Log ID: 5, Quest ID: 143
-- Kagetora: !gotoid 17743879
-- qm2 Spiders: !gotoid 17486241
-- Ryoma: !gotoid 17809466
-- Enetsu: !gotoid 17743909
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local norgID = require("scripts/zones/Norg/IDs")
local eAltepaID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)
local weaponsReward = { xi.items.ANJU,  xi.items.ZUSHIO }

quest.reward =
{
    fameArea = xi.quest.fame_area.NORG,
    fame = 75,
    item = weaponsReward,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainJob() == xi.job.NIN and
            player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.NORG] =
        {
            ['Ryoma'] = quest:progressEvent(133),

            onEventFinish =
            {
                [133] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Ryoma'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TRICK_BOX) then
                        return quest:progressEvent(134)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(804)
                    end
                end,
            },

            onEventFinish =
            {
                [134] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:needToZone(true)
                        player:delKeyItem(xi.ki.TRICK_BOX)
                        return quest:messageSpecial(norgID.text.KEYITEM_LOST, xi.ki.TRICK_BOX)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Kagetora'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(261)
                    end
                end,
            },

            ['Ensetsu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(262)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:event(263)
                    end
                end,
            },

            onEventFinish =
            {
                [261] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [262] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.EASTERN_ALTEPA_DESERT] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        quest:getVar(player, 'nmKilled') == 0 and
                        not player:hasKeyItem(xi.ki.TRICK_BOX) and
                        npcUtil.popFromQM(player, npc, { eAltepaID.mob.TSUCHIGUMO_OFFSET,
                        eAltepaID.mob.TSUCHIGUMO_OFFSET + 1 },
                        { claim = false, hide = 0 })
                    then
                        return quest:messageSpecial(eAltepaID.text.SENSE_OF_FOREBODING)
                    elseif quest:getVar(player, 'nmKilled') == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.TRICK_BOX)
                        quest:setVar(player, 'nmKilled', 0)
                        quest:setVar(player, 'Prog', 4)
                        return quest:noAction()
                    end
                end,
            },

            ['Tsuchigumo'] =
            {
                onMobInitialize = function(mob)
                    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
                    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
                end,

                onMobSpawn = function(mob)
                    mob:setLocalVar("despawnTime", os.time() + 180)
                    mob:setMobMod(xi.mobMod.NO_LINK, 1)
                end,

                onAdditionalEffect = function(mob, target, damage)
                    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 20 })
                end,

                onMobRoam = function(mob)
                    mob:timer(5000, function(mobArg)
                        mobArg:setMobMod(xi.mobMod.NO_LINK, 0)
                        end)

                    local despawnTime = mob:getLocalVar("despawnTime")
                    if
                        despawnTime > 0 and
                        os.time() > despawnTime
                    then
                        DespawnMob(mob:getID())
                    end
                end,

                onMobDeath = function(mob, player, optParams)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        GetMobByID(eAltepaID.mob.TSUCHIGUMO_OFFSET):isDead() and
                        GetMobByID(eAltepaID.mob.TSUCHIGUMO_OFFSET + 1):isDead()
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },
        },
    },
}

return quest
