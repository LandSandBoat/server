-----------------------------------
-- Area: Caedarva Mire
--  Mob: Caedarva Toad
-- Involved in Quest: The Wayward Automation
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_RES_RANK, 9)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.BLIND_RES_RANK, 9)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 350)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMod(xi.mod.ATT, 110)
end

entity.onMobDeath = function(mob, player, optParams)
    local theWaywardAutomaton = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATON)
    local theWaywardAutomatonProgress = player:getCharVar('TheWaywardAutomatonProgress')

    if
        theWaywardAutomaton == xi.questStatus.QUEST_ACCEPTED and
        theWaywardAutomatonProgress == 2 and
        player:getCharVar('TheWaywardAutomatonNM') == 0
    then
        player:setCharVar('TheWaywardAutomatonNM', 1)
    end
end

return entity
