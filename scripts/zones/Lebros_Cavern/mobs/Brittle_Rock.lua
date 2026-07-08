-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Brittle Rock
-- Immune to sleep (light, dark), poison, cannot regain HP on deaggro
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener('WEAPONSKILL_TAKE', 'BRITTLE_ROCK_WEAPONSKILL_TAKE', function(user, target, skill, tp, action)
        if skill:getID() == 1838 then
            target:setHP(0)
        end
    end)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
    mob:setMobMod(xi.mobMod.NO_REST, 0)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setAutoAttackEnabled(false)
    mob:setMod(xi.mod.UDMGPHYS, -9000)
    mob:setMod(xi.mod.UDMGBREATH, -9000)
    mob:setMod(xi.mod.UDMGRANGE, -9000)
    mob:setMod(xi.mod.UDMGMAGIC, -9000)
    mob:setMod(xi.mod.CURSE_MEVA, 9999)
    mob:setMod(xi.mod.EVA, 0)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()
        if not instance then
            return
        end

        local mobId = mob:getID()
        if mobId == ID.mob[xi.assault.mission.EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK1 then
            GetNPCByID(ID.npc._1rx, instance):setAnimation(xi.animation.OPEN_DOOR)
        elseif mobId == ID.mob[xi.assault.mission.EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK2 then
            GetNPCByID(ID.npc._1ry, instance):setAnimation(xi.animation.OPEN_DOOR)
        elseif mobId == ID.mob[xi.assault.mission.EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK3 then
            GetNPCByID(ID.npc._1rz, instance):setAnimation(xi.animation.OPEN_DOOR)
        elseif mobId == ID.mob[xi.assault.mission.EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK4 then
            GetNPCByID(ID.npc._jr0, instance):setAnimation(xi.animation.OPEN_DOOR)
        elseif mobId == ID.mob[xi.assault.mission.EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK5 then
            GetNPCByID(ID.npc._jr1, instance):setAnimation(xi.animation.OPEN_DOOR)
        end

        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
